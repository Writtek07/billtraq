class Invoice < ApplicationRecord
	include Discard::Model
	
	belongs_to :student
	belongs_to :user
	has_many :particulars, dependent: :destroy
	has_paper_trail

	validates :student, presence: true
	validates :month_to, presence: true
	validates :month_from, presence: true
	validates :payment_mode, presence: true
	validates :bank_account, presence: true, if: :payment_mode_cheque?
	validates :cheque_no, presence: true, if: :payment_mode_cheque?

	after_validation :invoice_month_validity, on: [ :create, :update ]
	before_create :check_invoice_dates
	after_create :change_status
	after_save :update_pending_months
	#after_validation :repeated_invoice_month_check, on: [ :create, :update ]
	
	enum status: { paid: 0, pending: 1 }

	paginates_per 10

	
	def invoice_month_validity
		year_from = self.month_from.split("-").first.to_i
		month_frm = self.month_from.split("-").second.to_i

		year_to = self.month_to.split("-").first.to_i
		to_month = self.month_to.split("-").second.to_i

		if year_from == year_to
			if month_frm > to_month
				errors.add(:base, 'Invoice from: date should be less than Invoice to: date')
			else
			end
		end
	end

	def change_status
        if self.payment_mode == 'Cash' || self.payment_mode == 'Online'
        #   self.update_attributes!(status: 'Paid')
			self.paid!
        elsif self.payment_mode == 'Cheque'
        #   self.update_attributes!(status: 'Pending')
			self.pending!
        end
  	end
	

	def check_invoice_dates
		student = Student.find(self.student_id)
		pending_fee = student.pending_fees
		if pending_fee.present?
			from_year, from_month = self.month_from.split("-")			
			if pending_fee[from_year].present?
				if !pending_fee[from_year].include?(from_month)
					#puts pending_fee[from_year].include?(from_month).to_s+"Pending->#{pending_fee[from_year]}"+"from_month->#{from_month}"
					errors.add(:month_from, 'Invoice exists!')
				else
				end
				if pending_fee[from_year].include?(from_month) && pending_fee[from_year].index(from_month) != 0
					# errors.add(:base, 'There are months pending for this student before'.concat(" "+from_month.concat("-01").to_date.strftime("%B")))
					errors.add(:base, 'There are months pending for this student before the entered month')
				else
				end
			end
		end
	end


	def update_pending_months
		student = Student.find(self.student_id)        
		student.update_column(:pending_fees, InvoiceService::CalculatePendingFee.pending(student))
		InvoiceService::FeePendingStatus.update_status(student)
	end

	private

	def payment_mode_cheque?
		payment_mode == 'Cheque'
	end
end

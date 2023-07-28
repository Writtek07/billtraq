class Invoice < ApplicationRecord
	include Discard::Model
	
	belongs_to :student
	belongs_to :user
	has_many :particulars, dependent: :destroy
	has_paper_trail

	validates :student, presence: true
	validates :month_to, presence: true
	validates :month_from, presence: true
	
	after_validation :invoice_month_validity, on: [ :create, :update ]
	before_create :check_invoice_dates
	after_create :change_status
	after_save :update_pending_months
	#after_validation :repeated_invoice_month_check, on: [ :create, :update ]
	
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
          self.update_attributes!(status: 'Paid')
        elsif self.payment_mode == 'Cheque'
          self.update_attributes!(status: 'Pending')
        end
  	end
	

	def check_invoice_dates
		student = Student.find(self.student_id)
		pending_fee = student.pending_fees
		from_year, from_month = self.month_from.split("-")
		#to_year, to_month = self.month_to.split("-")
		#puts student.id,from_year, from_month,pending_fee
		if pending_fee[from_year].present?
			if !pending_fee[from_year].include?(from_month)
				#puts pending_fee[from_year].include?(from_month).to_s+"Pending->#{pending_fee[from_year]}"+"from_month->#{from_month}"
				errors.add(:month_from, 'Invoice exists!')
			else
			end
			if pending_fee[from_year].include?(from_month) && pending_fee[from_year].index(from_month) != 0
				errors.add(:base, 'There are months pending for this student before'.concat(" "+month_from.concat("-01").to_date.strftime("%B")))
			else
			end
	end


	def update_pending_months
		student = Student.find(self.student_id)        
		student.update_column(:pending_fees, InvoiceService::CalculatePendingFee.pending(student))
		InvoiceService::FeePendingStatus.update_status(student)
	end

  end





  #Moved all logic to controller as validations in model is getting affected by update pending fees logic
	#For now skipping that part where invoice having month_from != month_to 
  #def repeated_invoice_month_check
  #	student = Student.find(self.student_id)
  #	if student.pending_fees.present?
	#  	if self.month_from == self.month_to
	#  		if !(student.pending_fees[self.month_from.split("-").first.to_s].include?(self.month_from.split("-").last.to_s))
	#  			errors.add(:base, 'Invoice for entered months already exists.')
	#  		end
	#  	else
	#  		if !student.pending_fees[self.month_from.split("-").first].include?(self.month_from.split("-").last) && !student.pending_fees[self.month_to.split("-").first].include?(self.month_to.split("-").last)
	#  			errors.add(:base, 'Invoice for entered months already exists.')
	#  		end
	#  	end
	#  end
  #end

	private
end

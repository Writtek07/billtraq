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

	after_create :update_pending_months
	after_create :change_status
	paginates_per 10

	def date_validity?
		if self.date.present? && self.date.to_date > self.created_at.to_date
			return false
		else
			return true
		end
	end

	def invoice_month_validity
		year_from = self.month_from.split("-").first.to_i
		month_frm = self.month_from.split("-").second.to_i

		year_to = self.month_to.split("-").first.to_i
		to_month = self.month_to.split("-").second.to_i

		if year_from == year_to
			if month_frm > to_month
				errors.add(:base, 'Invoice from: date should be less than Invoice to: date')
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

	def update_pending_months
	    student = Student.find(self.student_id)
	    months_array = []
	    student.invoices.kept.each do |inv|
	    	if inv.month_from == inv.month_to
	    		months_array << [inv.month_from]
	    	else
	    		months_array << [inv.month_from]
	    		months_array << [inv.month_to]
	    	   	cur_months = months_array.sort.map {|i| i[0].to_s.split("-").second} #=> ["05", "06", "09"]
	    		missing_months = find_missing_consecutive_numbers(cur_months).map { |e| e.rjust(2, "0") }
	    		temp_months = []
	    		missing_months.map { |j| temp_months << [months_array.last[0].split("-").first+ "-" +j] }
	    	    months_array += temp_months	
	    	end
		end	    
	    
	    #pending_months_2022 = check_months(months_array, "2022") #returns => {"2022"=>["01", "02", "03", "04", "05", "06", "07", "08", "09", "10"]}
	    #pending_months_till = check_months(months_array, "#{Time.zone.today.year}")

	    #pending_months = student.pending_fees
	    #if pending_months.blank?
	    	pending_months = {}
	    #end
	    (2022..Time.zone.now.year).each do |year|
	    	inv_year = []
	    	#inv_month = []
	    	months_array.each do |e|
	    		inv_year << e[0].to_s.split("-").first
	    		if inv_year.include?(year.to_s)
	    			pending_months.merge!(check_months(months_array, year.to_s))
	    		end
	    	end
	    end
	    student.update_column(:pending_fees, pending_months)
	    year = student.pending_fees.keys.sort.first
	    	if year.to_i >= Time.zone.now.year.to_i
			    student.pending_fees[Time.now.year.to_s].each do |month|
				    if month.to_i <= Time.now.month
				    	student.update_column(:fee_pending, true)
				    else
				    	student.update_column(:fee_pending, false)
				    end
				end
			else
				if student.pending_fees[year].present?
					student.update_column(:fee_pending, true)
				else
					student.update_column(:fee_pending, false)
				end
			end
	 end

	private
	
	def check_months(arr,year)
	  # Initialize an empty hash to store months for the given year
	  months_year = {}
	  # Initialize an array to store the pending months
	  pending_months = []
	  # Iterate through the input array
	  arr.each do |date|
	    # Split the date string into year and month
	    date_year, month = date[0].split("-")

	    # Add the month to the corresponding year array
	    if date_year == year
	      months_year[year] = [] unless months_year.key?(year)
	      months_year[year] << month
	    end
	  end

	  # Check if all 12 months are present in the given year array
	  (1..12).each do |month|
	    pending_months << month.to_s.rjust(2, "0") if !months_year[year].include?(month.to_s.rjust(2, "0"))
	  end

	  return { year => pending_months }
	end

	def find_missing_consecutive_numbers(arr)
	  missing_nums = []
	  arr.each_with_index do |num, index|
	    next_num = arr[index + 1]
	    if next_num.nil? || (next_num.to_i - num.to_i) > 1
	      (num.to_i + 1...next_num.to_i).each { |n| missing_nums << n.to_s }
	    end
	  end
	  missing_nums
	end

	private
end

module InvoiceService
    class CalculatePendingFee
        def self.pending(student)
            months_array = []
            student.invoices.kept.each do |inv|
                if inv.month_from == inv.month_to
                months_array << [inv.month_from]
                else
                months_array << [inv.month_from]
                months_array << [inv.month_to]
                cur_months = months_array.sort.map {|i| i[0].to_s.split("-").second} #=> ["05", "06", "09"]
                missing_months = self.find_missing_consecutive_numbers(cur_months).map { |e| e.rjust(2, "0") }
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

            # Making start year to be 2023 so that actual backdated students can be tracked
            # Also, As we are recording invoices from 2023 Jan. Remember to change here if using for seperate org.
            start_year = student.date_of_admission.year > 2022 ? student.date_of_admission.year : 2023
            (start_year..Time.zone.now.year).each do |year|
                inv_year = []
                #inv_month = []
                months_array.each do |e|
                    inv_year << e[0].to_s.split("-").first
                    if inv_year.include?(year.to_s)
                        pending_months.merge!(self.check_months(months_array, year.to_s, student.date_of_admission))
                    end
                end
            end            
            pending_months
        end

        def self.check_months(arr,year,doa)
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
      
            # If new admission then select months from date of admission month
            if doa.year == Time.zone.now.year
              (doa.month+1..12).each do |month|
                pending_months << month.to_s.rjust(2, "0") if !months_year[year].include?(month.to_s.rjust(2, "0"))
              end
            else  
              # Check if all 12 months are present in the given year array
              (1..12).each do |month|
                pending_months << month.to_s.rjust(2, "0") if !months_year[year].include?(month.to_s.rjust(2, "0"))
              end
            end
      
            return { year => pending_months }
        end
      
        def self.find_missing_consecutive_numbers(arr)
            missing_nums = []
            arr.each_with_index do |num, index|
              next_num = arr[index + 1]
              if next_num.nil? || (next_num.to_i - num.to_i) > 1
                (num.to_i + 1...next_num.to_i).each { |n| missing_nums << n.to_s }
              end
            end
            missing_nums
        end
    end
end
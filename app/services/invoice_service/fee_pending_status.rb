module InvoiceService
    class FeePendingStatus
        def self.check_status(student)
            year = student.pending_fees.keys.sort.first
            if year.to_i >= Time.zone.now.year.to_i
                student.pending_fees[Time.now.year.to_s].each do |month|
                    if month.to_i <= Time.now.month                       
                        return true
                    else                        
                        return false
                    end
                end
            else
                    if student.pending_fees[year].present?                        
                        return true
                    else                        
                        return false
                    end
            end            
        end

        def self.update_status(student)
            student.update_column(:fee_pending, self.check_status(student))
        end
    end
end
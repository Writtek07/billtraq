module InvoicesHelper

	def month_name(str)
		if str == ""
			return nil
		else
			mon_name = ["January","February","March","April","May","June","July","August","September","October","November","December"]
			mon_num = str.split("-").second.to_i
			return mon_name[mon_num-1]
		end
	end
end

module StudentsHelper
	def month_names(month_numbers)
	  month_numbers.map { |month_number| Date::MONTHNAMES[month_number.to_i] }
	end

end

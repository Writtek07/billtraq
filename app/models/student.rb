class Student < ApplicationRecord
	include Discard::Model
	
	has_many :invoices, dependent: :destroy
	has_paper_trail

	paginates_per 10

	validates :first_name, presence: true
	#validates :last_name, presence: true   Some cases dont have last_name
	validates :dob, presence: true
	validates :date_of_admission, presence: true
	validates :admission_no, presence: true, uniqueness: true
	validates :phone_number, numericality: { only_integer: true }, length: { is: 10 }
	validates :grade, presence: true
	validates :section, presence: true,  unless: Proc.new { |a| a.grade == "Playgroup" }
	validates :father_name, presence: true
	validates :mother_name, presence: true
	



	#validates :section, presence: true
	 #Removed the presense and uniqeness as some cases dont have number now + uniquesness is not needed as one parent can have multiple students
	 #Later will add presence once all have number updated
	#validates :phone_number, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 10 }
	#validates :email, presence: true, uniqueness: true {We are not using email now}



	

	validate :validate_dob



	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			Student.create! row.to_hash
		end
	end


	private

	def validate_dob
		if self.date_of_admission.present? && self.dob.present?
			if self.date_of_admission < self.dob
	        	errors.add(:date_of_admission,'should be a date after Date of Birth.')
	        end
	    else
	    	errors.add(:base, 'Date of admission or Date of birth is Missing')
	    end
    end
end

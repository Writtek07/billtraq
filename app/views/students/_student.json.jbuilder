json.extract! student, :id, :first_name, :last_name, :email, :admission_no, :phone_number, :grade, :section, :father_name, :mother_name, :created_at, :updated_at
json.url student_url(student, format: :json)

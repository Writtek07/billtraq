require "application_system_test_case"

class StudentsTest < ApplicationSystemTestCase
  setup do
    @student = students(:one)
  end

  test "visiting the index" do
    visit students_url
    assert_selector "h1", text: "Students"
  end

  test "creating a Student" do
    visit students_url
    click_on "New Student"

    fill_in "Admission no", with: @student.admission_no
    fill_in "Email", with: @student.email
    fill_in "Father name", with: @student.father_name
    fill_in "First name", with: @student.first_name
    fill_in "Grade", with: @student.grade
    fill_in "Last name", with: @student.last_name
    fill_in "Mother name", with: @student.mother_name
    fill_in "Phone number", with: @student.phone_number
    fill_in "Section", with: @student.section
    click_on "Create Student"

    assert_text "Student was successfully created"
    click_on "Back"
  end

  test "updating a Student" do
    visit students_url
    click_on "Edit", match: :first

    fill_in "Admission no", with: @student.admission_no
    fill_in "Email", with: @student.email
    fill_in "Father name", with: @student.father_name
    fill_in "First name", with: @student.first_name
    fill_in "Grade", with: @student.grade
    fill_in "Last name", with: @student.last_name
    fill_in "Mother name", with: @student.mother_name
    fill_in "Phone number", with: @student.phone_number
    fill_in "Section", with: @student.section
    click_on "Update Student"

    assert_text "Student was successfully updated"
    click_on "Back"
  end

  test "destroying a Student" do
    visit students_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Student was successfully destroyed"
  end
end

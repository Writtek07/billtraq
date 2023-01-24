class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]
  before_action :set_paper_trail_whodunnit
  
  # GET /students or /students.json
  def index
    @q = Student.ransack(params[:q])
    @students = @q.result(distinct: true).kept
    @students = @students.order('grade DESC').page(params[:page]) #To not let pagination affect ransack search
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  def pending_fee
    @students = Student.where(fee_pending: true).page(params[:page])
    cur_students = []
    Invoice.where(created_at: Time.zone.today.beginning_of_month.beginning_of_day..Time.zone.now).map { |i| cur_students << i.student }
    @current_month_students = Student.all - cur_students.uniq
    render 'pending_fee.html.erb'
  end

  def removed
    @students = Student.discarded
    if @students.present?
      render 'discarded_students.html.erb'
    else
      flash[:error] = "No Students with TC"
      redirect_to students_path
    end
  end

  def import
    Student.import(params[:file])
    return redirect_to students_path, error: "Please upload CSV only!" unless params[:file].content_type == 'text/csv'

    redirect_to students_path, notice: "Students Uploaded Successfully"
  end


  def missing
    @students = Student.where(admission_no: nil).or(Student.where(phone_number: nil)).or(Student.where(father_name: "")).or(Student.where(mother_name:"")).or(Student.where(dob: nil)).or(Student.where(date_of_admission: nil)).or(Student.where(grade: ""))
    if @students.present?
      render 'students/pending_data.html.erb'
    else
      flash[:alert] = "No Students with incomplete data!"
      redirect_to root_path
    end
  end

  def show_invoices
    set_student
    if current_user.admin?
      @invoices = @student.invoices
    else
      @invoices = @student.invoices.kept
    end
    
    if @invoices.any?
      render 'student_invoices.html.erb'
    else
      flash[:alert] = "No invoices for this student."
      redirect_to students_path
    end
    
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)
    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    @student.undiscard if params.dig(:restore)
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.discard

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :admission_no, :phone_number, :grade, :section, :father_name, :mother_name, :dob, :date_of_admission, :discarded_at)
    end
end

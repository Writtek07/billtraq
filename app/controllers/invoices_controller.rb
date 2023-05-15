class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy print pdf]

  before_action :set_paper_trail_whodunnit
  # GET /invoices or /invoices.json
  def index
    @q = Invoice.ransack(params[:q])
    @invoices = @q.result(distinct: true)
    @search = Invoice.all.search(params[:q])
    @invoices = @search.result
    @invoices = @invoices.order('created_at DESC').page(params[:page])
  end

  def search
    index
    render :index
  end

  def print
    pdf
  end

  def pdf
    respond_to do |format|
      format.html
      format.pdf do
          render pdf: "Receipt for (#{@invoice.student.first_name} #{@invoice.student.last_name})",
          page_size: 'A4',
          template: 'invoices/print.html.erb',
          lowquality: true,
          dpi: 100,
          encoding: 'utf8'
        end
      end
  end


  def cheque
    @invoices = Invoice.kept.where(status: 'Pending')
    if @invoices.present?
      render 'cheque_data.html.erb'
    else
      flash[:alert] = "No Cheque Invoices found in Pending!"
      redirect_to root_path
    end
  end



  # GET /invoices/1 or /invoices/1.json
  def show
    begin
      @invoice = Invoice.find(params[:id])
      @student = Student.find_by_id(@invoice.student_id)
      @particulars = @invoice.particulars
    rescue StandardError => e
      redirect_to root_path
      flash[:error] = e.message
    end
  end

  # GET /invoices/new
  def new
    @student = Student.find(params[:student_id])
    @invoice = Invoice.new
    @particulars = @invoice.particulars
  end

  # GET /invoices/1/edit
  def edit
    @student = Student.find_by_id(@invoice.student_id)
    @particulars = @invoice.particulars
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @student = @invoice.student
    update_pending_months(@student)
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    if (invoice_params[:month_from] || invoice_params[:month_to]) && !current_user.admin?
      flash[:error] = 'Unauthorized to update months in invoice after creating'
      redirect_to invoice_url(@invoice)
    else
      respond_to do |format|
        @invoice = Invoice.find(params[:id])
        @student = @invoice.student
        if @invoice.update(invoice_params)
          update_pending_months(@student)
          format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully updated." }
          format.json { render :show, status: :ok, location: @invoice }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @invoice.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.discard
    @invoice.update_attributes!(discarded_by: current_user.id)
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Invoice was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.require(:invoice).permit(:date, :total, :user_id, :payment_mode, :student_id, :class_no, :cheque_no, :receipt_number, :bank_account, :status, :month_from, :month_to, :discarded_by, :notes)
    end

    def update_pending_months(student)
        #student = Student.find(self.student_id)
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
        start_year = student.date_of_admission.year > 2022? student.date_of_admission.year : 2022
        (start_year..Time.zone.now.year).each do |year|
          inv_year = []
          #inv_month = []
          months_array.each do |e|
            inv_year << e[0].to_s.split("-").first
            if inv_year.include?(year.to_s)
              pending_months.merge!(check_months(months_array, year.to_s, student.date_of_admission))
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

    def check_months(arr,year,doa)
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
end

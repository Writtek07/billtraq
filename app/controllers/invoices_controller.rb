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
    @invoice = Invoice.find(params[:id])
    @student = Student.find_by_id(@invoice.student_id)
    @particulars = @invoice.particulars
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
    respond_to do |format|
      @invoice = Invoice.find(params[:id])
      @student = @invoice.student
      if @invoice.update(invoice_params)
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
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
end

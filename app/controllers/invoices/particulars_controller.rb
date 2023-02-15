class Invoices::ParticularsController < ApplicationController
  before_action :set_invoice
  before_action :set_particular, except: [:new, :create]
  before_action :set_paper_trail_whodunnit
  
  # GET /particulars or /particulars.json
  def index
    @particulars = Particular.kept
  end

  # GET /particulars/1 or /particulars/1.json
  def show
  end

  # GET /particulars/new
  def new
    @particular = Particular.new
  end

  # GET /particulars/1/edit
  def edit
  end

  # POST /particulars or /particulars.json
  def create
    @particular = Particular.new(particular_params)
    @particular.invoice = @invoice

    respond_to do |format|
      if @particular.save
        format.html { redirect_to @invoice, notice: "Fee was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /particulars/1 or /particulars/1.json
  def update
    respond_to do |format|
      if @particular.update(particular_params)
        format.html { redirect_to particular_url(@particular), notice: "Fee was successfully updated." }
        format.json { render :show, status: :ok, location: @particular }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @particular.errors, status: :unprocessable_entity }
      end
    end
  end

#updated
  # DELETE /particulars/1 or /particulars/1.json
  def destroy
    @particular = Particular.find(params[:id])
    title = @particular.fee_type
    if @particular.discard
      @particular.discard
      @particular.update(discarded_by: current_user.id)
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @invoice
    else
      flash[:error] = "There was an error deleting the Fee."
      render :show
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_particular
      @particular = Particular.find(params[:id])
    end

    def set_invoice
      @invoice = Invoice.find(params[:invoice_id])
    end

    # Only allow a list of trusted parameters through.
    def particular_params
      params.require(:particular).permit(:fee_type, :amount, :invoice_id, :price)
    end
end

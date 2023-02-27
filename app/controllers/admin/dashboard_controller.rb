class Admin::DashboardController < ApplicationController
	before_action :authenticate_admin, :set_more_invoice_data_table, :set_invoice_chart_data

	def index		
	  @users = User.all
	  #@students = Student.all
	  #@invoices = Invoice.kept
	  @discarded_invoices = Invoice.discarded
	  @discarded_particulars = Particular.discarded
	  @anamoly_invoices = []

	  Invoice.kept.each do |invoice|
	    if (invoice.updated_at - invoice.created_at) > 86400
	      @anamoly_invoices << invoice
	    end 
	  end

	  render 'admin/dashboard.html.erb'	  
	end

	#Had to define create method as we are using POST in form_tag for filter submission
	#This requires create to be defined in controller
	def create
		index
	end

	private

	def authenticate_admin
		if !current_user.admin?
			flash[:error] = "You are not authorized to view the page!"
			redirect_to root_path
		end
	end

	def set_more_invoice_data_table
	    if params[:start_date].present? && params[:end_date].present?
	      start_date = Time.zone.parse(params[:start_date]).beginning_of_day
	      end_date = Time.zone.parse(params[:end_date]).end_of_day
	      if end_date.to_date < start_date.to_date
	        flash[:error] = 'Filter End Date- ' + end_date.strftime("%d-%m-%Y") + ' should be after Start Date- ' + start_date.strftime("%d-%m-%Y")
	        @more_invoice_data = Invoice.kept.where(created_at: (Time.zone.today-7.days).beginning_of_day..Time.zone.now)
	      else
	      	@more_invoice_data = Invoice.kept.where(created_at: start_date..end_date)
	      	flash[:error] = 'No Invoice data found between selected dates ' + start_date.strftime("%d-%m-%Y") + ' to ' + end_date.strftime("%d-%m-%Y") unless @more_invoice_data.present?	        
	      end
	    else
	    	#When no filter or one param i.e.start or end date missing	    
	     	@more_invoice_data = Invoice.kept.where(created_at: (Time.zone.today-7.days).beginning_of_day..Time.zone.now)
	    end
	  end

	def set_invoice_chart_data
		#puts params[:inv_chart_start_date], params[:inv_chart_end_date]
		if params[:inv_chart_start_date].present? && params[:inv_chart_end_date].present?
		  start_date = Time.zone.parse(params[:inv_chart_start_date]).beginning_of_day
		  end_date = Time.zone.parse(params[:inv_chart_end_date]).end_of_day
		  if end_date.to_date < start_date.to_date
		  	flash[:error] = 'Filter End Date should be after Start Date- '+ start_date.strftime("%d-%m-%Y")
		  end
		  @invoice_chart_data = Invoice.kept.group("date(created_at)").where(created_at: start_date..end_date).count.sort.map { |h| [h.first.to_date.strftime("%d-%b"),h.second] }
		else
			#When no filter or one param i.e.start or end date missing
		  	@invoice_chart_data = Invoice.kept.group("date(created_at)").limit(7).count.sort.map { |h| [h.first.to_date.strftime("%d-%b"),h.second] }
		end		
	end
end
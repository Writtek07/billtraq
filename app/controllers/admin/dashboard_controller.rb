class Admin::DashboardController < ApplicationController
	before_action :authenticate_admin
	
	def index
		#@q = Invoice.kept.ransack(params[:q])
		#@invoice_dates = @q.result(distinct: true)
		@users = User.all
		@students = Student.all
		@invoices = Invoice.kept
		@invoices_created_this_month = Invoice.kept.where(created_at: Time.zone.today.beginning_of_month.beginning_of_day .. Time.zone.now)
		@discarded_invoices = Invoice.all.discarded
		@discarded_particulars = Particular.all.discarded
		@anamoly_invoices = []
		@invoices.each do |invoice|
			if (invoice.updated_at - invoice.created_at) > 86400
				@anamoly_invoices << invoice
			end 
		end
		render 'admin/dashboard.html.erb'
	end

	private

	def authenticate_admin
		if !current_user.admin?
			flash[:error] = "You are not authorized to view the page!"
			redirect_to root_path
		end
	end
end
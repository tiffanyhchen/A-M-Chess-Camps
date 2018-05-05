class RegistrationsController < ApplicationController
  authorize_resource

  #  def index
  #   if logged_in? && !current_user.role?(:customer)
  #     @not_shipped_orders = Order.not_shipped.chronological.paginate(:page => params[:page]).per_page(10)
  #     @all_orders = Order.all.chronological.paginate(:page => params[:page]).per_page(10)
  #   end
  # end
  
  def new
    @registration   = Registration.new
    @camp              = Camp.find(params[:camp_id])
    @other_registrations = @camp.students
  end
  
  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      flash[:notice] = "Successfully added student."
      redirect_to camp_path(@registration.camp)
    else
      @camp = Camp.find(params[:registration][:camp_id])
      @other_registrations = @camp.students
      render action: 'new', locals: { camp: @camp, other_students: @other_students }
    end
  end
 
  def destroy
    camp_id = params[:id]
    student_id = params[:student_id]
    @registration = Registration.where(camp_id: camp_id, student_id: student_id).first
    unless @registration.nil?
        @registration.destroy
        flash[:notice] = "Successfully removed this registration"
    end
  end

  private
    def registration_params
      params.require(:registration).permit(:student_id, :camp_id)#, :credit_card_number, :expiration_year, :expiration_month)
    end
end
class CartsController < ApplicationController
  # before_action :set_camp, only: [:add_to_cart, :delete_from_cart]
  # before_action :set_student, only: [:add_to_cart, :delete_from_cart]
  require 'base64'
  
  include AppHelpers::Cart

  def add_to_cart
    if !session[:cart].nil?
      @student = params[:registration][:student_id]
      @camp = params[:registration][:camp_id]
      add_registration_to_cart(@camp, @student)
    end
    redirect_to "/camps/#{@camp}"
  end

  def delete_from_cart
    if !session[:cart].nil?
      @camp_id = params[:camp_id]
      @student_id = params[:student_id]
      remove_registration_from_cart(@camp_id, @student_id)
    end
    redirect_to view_cart_path
  end

  def view_cart
    @cart_items = get_array_of_ids_for_generating_registrations
    @registration_total = calculate_total_cart_registration_cost
  end

  def checkout_cart
    if !session[:cart].nil?
      @cart_items = get_array_of_ids_for_generating_registrations
      @registration_total = calculate_total_cart_registration_cost
      go_through = true

      @credit_card_number = params[:registration][:credit_card_number]
      @expiration_year = params[:registration][:expiration_year]
      @expiration_month = params[:registration][:expiration_month]

      @cart_items.each do |ci_ids|
        @registration = Registration.new
        @registration.camp_id = ci_ids[0]
        @registration.student_id = ci_ids[1]
        @registration.credit_card_number = @credit_card_number
        @registration.expiration_year = @expiration_year.to_i
        @registration.expiration_month = @expiration_month.to_i
        if @registration.valid?
          @registration.pay
        else
          go_through = false
          flash[:error] = "Invalid registration or card"
          redirect_to view_cart_path
        end
      end
      if go_through 
        clear_cart
        redirect_to confirmation_path, notice: "Thank you for registering!"
      end
    end
  end

  def confirmation

  end


  private

    def registration_params
      params.require(:registration).permit(:student_id, :camp_id, :credit_card_number, :expiration_year, :expiration_month)
    end

end
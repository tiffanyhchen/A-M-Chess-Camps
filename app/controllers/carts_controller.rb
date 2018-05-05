class CartsController < ApplicationController
  before_action :set_camp, only: [:add_to_cart, :delete_from_cart]
  before_action :set_student, only: [:add_to_cart, :delete_from_cart]
  require 'base64'
  
  include AppHelpers::Cart

  def add_to_cart
    if !session[:cart].nil?
      add_registration_to_cart(@camp.id, @student.id)
    end
  end

  def delete_from_cart
    if !session[:cart].nil?
      remove_registration_from_cart(@camp.id, @student.id)
    end
  end

  def show
    @cart_items = get_array_of_ids_for_generating_registrations
    @registration_total = calculate_total_cart_registration_cost
  end

  def create
    if !session[:cart].nil?

      @cart_items = get_array_of_ids_for_generating_registrations
      @registration_total = calculate_total_cart_registration_cost

      @credit_card_number = params[:registration][:credit_card_number]
      @expiration_year = params[:registration][:expiration_year]
      @expiration_month = params[:registration][:expiration_month]

      @cart_items.each do |ci_ids|
        @registration = Registration.new(ci_ids.camp_id, ci_ids.student_id, @credit_card_number, @expiration_year, @expiration_month)
        @registration.pay
      end

      clear_cart
      redirect_to confirmation_path, notice: "Thank you for registering!"
    end
  end

  def confirmation

  end


  private
    def set_camp
      @camp = Camp.find(params[:id])
    end

    def camp_params
      params.require(:camp).permit(:curriculum_id, :location_id, :cost, :start_date, :end_date, :time_slot, :max_students, :active)
    end

    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:first_name, :last_name, :family_id, :date_of_birth, :rating, :active)
    end

    def registration_params
      params.require(:registration).permit(:student_id, :camp_id, :credit_card_number, :expiration_year, :expiration_month)
    end

end
class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    @families = Family.all.alphabetical#.paginate(:page => params[:page]).per_page(12)
  end

  def show
    # @past_camps = @instructor.camps.past.chronological
    @students = @family.students.alphabetical
  end

  def edit
  end

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
    @user = User.new(user_params)
    @user.role = "parent"
    if !@user.save
      @family.valid?
      render action: 'new'
    else
      @family.user_id = @user.id
      if @family.save
        flash[:notice] = "#{@family.parent_first_name} #{@family.family_name} was added to the system."
        redirect_to family_path(@family)
      else
        render action: 'new'
      end
    end
  end

  # Edit this for in place 
  def update
    if @family.update(family_params)
      redirect_to family_path(@family), notice: "#{@family.parent_first_name} #{@family.family_name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    if @family.destroy
      redirect_to families_url, notice: "#{@family.parent_first_name} #{@family.family_name} was deleted from the system."
    end
  end

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:family_name, :parent_first_name, :user_id, :active, :username, :password, :password_confirmation, :email, :phone)
    end

    def user_params
      params.require(:family).permit(:active, :username, :role, :email, :phone, :password, :password_confirmation)    
    end
end
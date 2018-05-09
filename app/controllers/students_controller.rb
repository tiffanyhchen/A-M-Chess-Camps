class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    @students = Student.all.alphabetical.paginate(:page => params[:students]).per_page(10)
  end

  def show
    @registrations = @student.registrations.alphabetical
  end

  def edit
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to student_path(@student), notice: "#{@student.name} was added to the system."
    else
      render action: 'new'
    end
  end

  # Edit this for in place 
  def update
    if @student.update(student_params)
      redirect_to student_path(@student), notice: "#{@student.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    if @student.destroy
      redirect_to students_url, notice: "#{@student.name} was deleted from the system."
    end
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:first_name, :last_name, :family_id, :date_of_birth, :rating, :active)
    end
end
class HomeController < ApplicationController
  include AppHelpers::Cart

  def index
    @curriculums = Curriculum.all.alphabetical.map{|c| c.name}.to_a
    @curriculums_camps = Curriculum.all.alphabetical.map{|c| c.camps.size}.to_a
    @revenue = Camp.all.sum{|c| c.cost * c.enrollment}
    @registrations_count = Registration.all.size
    @students_count = Student.all.size
    @full_camps = Camp.all.count{|c| c.is_full? }
    @all_camps = Camp.all.count
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def search
    @query = params[:query]
    # @camps = Camp.search(@query)
    @curriculums = Curriculum.search(@query)
    @users = User.search(@query)
    @students = Student.search(@query)
    @families = Family.search(@query)
    @instructors = Instructor.search(@query)
    @locations = Location.search(@query)
    @totalhits = @curriculums.size + @users.size + @students.size + @locations.size + @instructors.size + @families.size
  end

end
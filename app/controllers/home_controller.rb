class HomeController < ApplicationController
  include AppHelpers::Cart

  def index
    # admin dashboard
    if logged_in? && current_user.role?(:admin)
      # WILL REFACTOR IF TIME ALLOWS
      @curriculums = Curriculum.all.alphabetical.map{|c| c.name}.to_a
      @curriculums_camps = Curriculum.all.alphabetical.map{|c| c.camps.size}.to_a
      @revenue = Camp.all.sum{|c| c.cost * c.enrollment}
      @registrations_count = Registration.all.size
      @students_count = Student.all.size
      @full_camps = Camp.all.count{|c| c.is_full? }
      @all_camps = Camp.all.count
      student_ratings = Student.all.map{|s| s.rating}
      student_count = Hash.new(0)
      student_ratings.each do |s|
        if s < 200
          student_count["J Class"] += 1
        elsif s < 400
          student_count["I Class"] += 1
        elsif s < 600
          student_count["H Class"] += 1
        elsif s < 800
          student_count["G Class"] += 1
        elsif s < 1000
          student_count["F Class"] += 1
        elsif s < 1200
          student_count["E Class"] += 1
        elsif s < 1400
          student_count["D Class"] += 1
        elsif s < 1600
          student_count["C Class"] += 1
        elsif s < 1800
          student_count["B Class"] += 1
        elsif s < 2000
          student_count["A Class"] += 1
        else
          student_count["2000+"] += 1
        end
      end
      @rating_categories = student_count.keys
      @student_ratings_count = student_count.values

      @recent_registrations = Registration.last(5).reverse

      
      # @enrollment_rates = Camp.upcoming.limit(5).map{|c| c.enrollment.to_f / c.max_students}
      @enrollment_rates = Hash.new(0)
      Camp.upcoming.limit(5).each do |c|
        @enrollment_rates[c] = c.enrollment.to_f / c.max_students
      end

    elsif logged_in? && current_user.role?(:parent)
      @parent = Family.where(user_id: current_user).first
      @your_students = @parent.students
      @registrations

    elsif logged_in? && current_user.role?(:instructor)
    end

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
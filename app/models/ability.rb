class Ability
  include CanCan::Ability

  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    # set authorizations for different user roles
    if user.role? :admin
      # they get to do it all
      can :manage, :all
      
    elsif user.role? :instructor 

      # can read curriculums, locations, and camps
      can :read, Curriculum
      can :read, Location
      can :read, Camp

      # they can read their own profile
      can :show, User do |u|  
        u.id == user.id
      end

      # they can update their own profile
      can :update, User do |u|  
        u.id == user.id
      end

      can :show, Instructor do |this_instructor|  
        Instructor.where(user_id: user).first == this_instructor
      end

      can :update, Instructor do |this_instructor|  
        Instructor.where(user_id: user).first == this_instructor
      end

      # they can read their own students' data
      can :show, Student do |this_student|  
        my_camps = Instructor.where(user_id: user).first.camps
        my_students = my_camps.map{|c| c.students }.flatten
        my_students.include? this_student 
      end

      # they can read their own students' family data
      can :show, Family do |this_family|  
        my_camps = Instructor.where(user_id: user).first.camps
        my_students = my_camps.map{|c| c.students }.flatten
        my_families = my_students.map{|s| s.family}.flatten
        my_families.include? this_family
      end

    elsif user.role? :parent
       # can read curriculums and camps
      can :read, Curriculum
      can :read, Camp
      can :read, Location

      # they can read their own profile
      can :show, User do |u|  
        u.id == user.id
      end

      # they can update their own profile
      can :update, User do |u|  
        u.id == user.id
      end

      can :show, Student do |this_student|
        my_students = Family.where(user_id: user).first.students.map(&:id)
        my_students.include? this_student.id 
      end

      can :update, Student do |this_student|
        my_students = Family.where(user_id: user).first.students.map(&:id)
        my_students.include? this_student.id 
      end

      can :show, Family do |this_family|  
        Family.where(user_id: user).first == this_family
      end

      can :update, Family do |this_family|  
        Family.where(user_id: user).first == this_family
      end

      can :create, Registration do |this_registration|  
        my_students = Family.where(user_id: user).first.students.map(&:id)
        my_students.include? this_student.id 
      end

      can :update, Registration do |this_registration|  
        my_students = Family.where(user_id: user).first.students.map(&:id)
        my_students.include? this_student.id 
      end
      
    else
      can :read, Camp
      can :read, Curriculum
      can :read, Location

      can :create, User
      can :create, Family
    end
  end
end

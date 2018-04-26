class Ability
  include CanCan::Ability

  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    # set authorizations for different user roles
    # if user.role? :admin
    #   # they get to do it all
    #   can :manage, :all
      
    # elsif user.role? :instructor

    #   # can read curriculums, locations, and camps
    #   can :read, Curriculum
    #   can :read, Location
    #   can :read, Camp

    #   # they can read their own profile
    #   can :show, User do |u|  
    #     u.id == user.id
    #   end

    #   # they can update their own profile
    #   can :update, User do |u|  
    #     u.id == user.id
    #   end

    #   # they can read their own profile
    #   can :show, Instructor do |i|  
    #     i.id == i.id
    #   end

    #   # they can update their own profile
    #   can :update, User do |u|  
    #     u.id == user.id
    #   end

    # elsif user.role? :family
    #    # can read curriculums and camps
    #   can :read, Curriculum
    #   can :read, Camp

    #   # they can read their own data
    #   can :show, Family do |this_family|  
    #     user.family.id == this_family.id
    #   end

    #    # they can update their own profile
    #   can :update, User do |u|  
    #     u.id == user.id
    #   end
      
    # else
    #   # guests can only read animals covered (plus home pages)
    #   can :read, Camp
    #   can :read, Curriculum
    # end
  end
end

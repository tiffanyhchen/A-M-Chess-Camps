module ApplicationHelper
  def camp_instructor_id_for(camp, instructor)
    ci = CampInstructor.where(camp_id: camp.id, instructor_id: instructor).first
    return ci.id unless ci.nil?
  end

  def registration_id_for(camp, student)
    reg = Registration.where(camp_id: camp.id, student_id: student).first
    return reg.id unless reg.nil?
  end

  def instructor_for(user)
    instructor = Instructor.where(user_id: user).first
    return instructor.id unless instructor.nil?
  end

  def family_for(user)
    family = Family.where(user_id: user).first
    return family.id unless family.nil?
  end
end

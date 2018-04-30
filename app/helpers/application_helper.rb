module ApplicationHelper
  def camp_instructor_id_for(camp, instructor)
    ci = CampInstructor.where(camp_id: camp.id, instructor_id: instructor).first
    return ci.id unless ci.nil?
  end

  def registration_id_for(camp, student)
    reg = Registration.where(camp_id: camp.id, student_id: student).first
    return reg.id unless reg.nil?
  end
end

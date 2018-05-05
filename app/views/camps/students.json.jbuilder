json.array!(@students) do |student|
  json.extract! student, :id, :first_name, :last_name, :family_id, :date_of_birth, :rating, :active
  json.url student_url(student, format: :json)
end
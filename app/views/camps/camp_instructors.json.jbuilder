json.array!(@camp_instructors) do |camp_instructor|
  json.extract! camp_instructor, :id, :camp_id, :instructor_id
  json.url camp_instructor_url(camp_instructor, format: :json)
end
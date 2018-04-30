module StudentsHelper
  # create a helper to get the options for the pet select menu
  # will return an array with key being pet_name : owner_name so 
  # that vet can choose the right pet (many pets share same names)
  def get_family_options
    Family.active.alphabetical.map{|f| ["#{f.family_name}", f.id] }
  end
end
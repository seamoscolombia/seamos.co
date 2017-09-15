class AcademicTitle < ApplicationRecord
  belongs_to :user, inverse_of: :academic_titles
end

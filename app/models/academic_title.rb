# == Schema Information
#
# Table name: academic_titles
#
#  id         :integer          not null, primary key
#  title      :string
#  period     :string
#  institute  :string
#  annotation :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AcademicTitle < ApplicationRecord
  belongs_to :user, inverse_of: :academic_titles
end

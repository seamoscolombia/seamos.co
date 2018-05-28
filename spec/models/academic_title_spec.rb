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

require 'rails_helper'

RSpec.describe AcademicTitle, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

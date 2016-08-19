# == Schema Information
#
# Table name: globales
#
#  id         :integer          not null, primary key
#  codigo     :string           not null
#  valor      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Global < ApplicationRecord
end

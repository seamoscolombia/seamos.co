# == Schema Information
#
# Table name: municipios
#
#  id              :integer          not null, primary key
#  nombre          :string
#  departamento_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Municipio < ApplicationRecord
  belongs_to :departamento
end

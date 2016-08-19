# == Schema Information
#
# Table name: tipo_de_documentos
#
#  id         :integer          not null, primary key
#  codigo     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TipoDeDocumento < ApplicationRecord
  
  def code_view
    I18n.t(:tipo_de_documento)[codigo.to_sym]
  end
end

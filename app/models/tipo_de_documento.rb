class TipoDeDocumento < ApplicationRecord
  
  def code_view
    I18n.t(:tipo_de_documento)[codigo.to_sym]
  end
end

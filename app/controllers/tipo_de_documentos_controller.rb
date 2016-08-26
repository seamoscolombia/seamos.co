# == Schema Information
#
# Table name: tipo_de_documentos
#
#  id         :integer          not null, primary key
#  codigo     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TipoDeDocumentosController < ApplicationController
  def index
    @tipo_de_documentos = TipoDeDocumento.all
    render json: @tipo_de_documentos, status: :ok
  end
end

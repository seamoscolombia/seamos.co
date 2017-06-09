class FrontendController < ApplicationController
  def index
    @frontend_props = { name: "Stranger" }
  end
end

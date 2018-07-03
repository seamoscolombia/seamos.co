class PagesController < ApplicationController
  
  def politicians  
    @politicians = JSON.parse(File.read("app/helpers/politicians.json"))
  end
  
end

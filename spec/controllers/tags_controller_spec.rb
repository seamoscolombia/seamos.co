require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  describe "GET #index" do
    subject { get :index }

    it {expect(subject).to render_template(:index)}
    

    it {expect(subject).to_not render_template("fake")}
    
  end

end

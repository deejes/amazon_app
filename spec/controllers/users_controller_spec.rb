require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#new" do
    it "creates a new instance variable" do
      get :new
      expect(assigns[:user]).to be_a_new(User)
    end

    it "renders a new template" do
      get :new
      expect(response).to render_template(:new)
    end

  end

  describe 'create' do

    context 'with valid params' do
      def valid_request
        attributes = {
          first_name: 'Abby',
          last_name: "Chow",
          email: 'AC@gmail.com',
          password: 'supersecret'
        }

        post :create, params:{user: attributes}
      end

      it 'creates a user in the database' do
        expect{valid_request}.to change{User.count}.by(1)
      end

      it 'redirects to the root path of the app' do
        valid_request
        expect(response).to redirect_to(home_path)
      end
    end
    context 'with INvalid parameters' do

      def invalid_request
        attributes = {
          first_name: 'Abby',
          last_name: "Chow"
        }

        post :create, params:{user: attributes}
      end

      it 'does not create a user in the db' do
        expect{invalid_request}.to_not change{User.count}
      end

      it 're renders the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end


    end

  end

end

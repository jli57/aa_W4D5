require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: FactoryBot.create(:user).id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "GET #create" do
    context "with valid params" do
      subject(:user) { User.find_by(username: 'testtest') }

      before(:each) do
        post :create, params: { user: { username: 'testtest', password: 'password' } }
      end

      it "creates the user" do
        expect(user).not_to be_nil
      end

      it "logs the user in" do
        expect(user.session_token).to eq(session[:session_token])
      end

      it "redirect to user homepage" do
        expect(response).to redirect_to(user_url(user))
      end
    end

    context "with invalid params" do

      before(:each) do
        post :create, params: { user: { username: 'testtest', password: '' } }
      end

      it "renders :new" do
        expect(response).to render_template(:new)
      end

      it "responds with status 422" do
        expect(response).to have_http_status(422)
      end

      it "displays errors" do
        expect(flash[:errors]).to be_present
      end
    end
  end
end

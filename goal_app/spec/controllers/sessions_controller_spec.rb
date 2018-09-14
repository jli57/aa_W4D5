require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    subject(:user) { FactoryBot.create(:user, { username: 'testtest' }) }

    context "with valid credentials" do
      it "logs the user in" do
        user
        post :create, params: { user: { username: 'testtest', password: 'password'}}
        user.reload
        expect(user.session_token).to eq(session[:session_token])
      end
    end

    context "with invalid credentials" do
      it "redirect to sign in page" do
        user
        post :create, params: { user: { username: '', password: 'password'}}
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:user) { FactoryBot.create(:user, { username: 'testtest' }) }

    it "logs the user out" do
      user
      post :create, params: { user: { username: 'testtest', password: 'password'}}
      expect do
        delete :destroy, params: { id: user.id }
        user.reload
      end.to(
        change { user.session_token }
      )
      expect(session[:session_token]).to be_nil
    end
  end
end

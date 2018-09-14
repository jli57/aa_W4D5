require 'rails_helper'

RSpec.describe GoalsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }

  # This should return the minimal set of attributes required to create a valid
  # Goal. As you add validations to Goal, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      title: "Goal1",
      details: "Don't write spaghetti code",
      private: true,
      completed: false,
      user_id: user.id
    }
  }

  let(:invalid_attributes) {
    { title: "", details: "", private: true, completed: false, user_id: user.id }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GoalsController. Be sure to keep this updated too.
  let(:valid_session) { { session_token: user.session_token } }

  describe "GET #show" do
    it "returns a success response" do
      goal = Goal.create! valid_attributes
      get :show, params: {id: goal.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      goal = Goal.create! valid_attributes
      get :edit, params: {id: goal.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Goal" do
        expect {
          post :create, params: {goal: valid_attributes}, session: valid_session
        }.to change(Goal, :count).by(1)
      end

      it "redirects to the created goal" do
        post :create, params: {goal: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Goal.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {goal: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { details: "Eh, just write spaghetti code" }
      }

      it "updates the requested goal" do
        goal = Goal.create! valid_attributes
        put :update, params: {id: goal.to_param, goal: new_attributes}, session: valid_session
        goal.reload
        expect(goal.details).to eq("Eh, just write spaghetti code")
      end

      it "redirects to the goal" do
        goal = Goal.create! valid_attributes
        put :update, params: {id: goal.to_param, goal: valid_attributes}, session: valid_session
        expect(response).to redirect_to(goal)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        goal = Goal.create! valid_attributes
        put :update, params: {id: goal.to_param, goal: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested goal" do
      goal = Goal.create! valid_attributes
      expect {
        delete :destroy, params: {id: goal.to_param}, session: valid_session
      }.to change(Goal, :count).by(-1)
    end

    it "redirects to the user's homepage" do
      goal = Goal.create! valid_attributes
      delete :destroy, params: {id: goal.to_param}, session: valid_session
      expect(response).to redirect_to(goal.user)
    end
  end

end

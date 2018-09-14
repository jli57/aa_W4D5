require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_uniqueness_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }

  subject(:user) { FactoryBot.build(:user) }

  describe "session_token" do
    it "assigns a session_token when one is not given" do
      expect(user.session_token).not_to be_nil
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_uniqueness_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }

  subject(:user) { FactoryBot.build(:user) }

  describe "#session_token" do
    it "assigns a session_token when one is not given" do
      expect(user.session_token).not_to be_nil
    end
  end

  describe "password encryption" do
    it "does not save password to database" do
      user = FactoryBot.create(:user)
      user_from_db = User.find_by(username: user.username)
      expect(user_from_db.password).to be_nil
    end

    it "uses BCrypt" do
      expect(BCrypt::Password).to receive(:create).with('password')
      FactoryBot.build(:user)
    end
  end

  describe "#reset_session_token!" do
    it "changes the session token" do
      expect{ user.reset_session_token! }.to(change{ user.session_token })
    end
  end

  describe "::find_by_credentials" do
    context "when given valid credentials" do
      it "returns the user" do
        user = FactoryBot.create(:user, username: "testtest")
        expect(User.find_by_credentials("testtest", "password")).to eq(user)
      end
    end

    context "when given invalid credentials" do
      it "returns nil" do
        user = FactoryBot.create(:user, username: "testtest")
        expect(User.find_by_credentials("test", "password")).to be_nil
        expect(User.find_by_credentials("testtest", "abcdef")).to be_nil
      end
    end
  end

end

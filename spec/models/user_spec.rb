require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it "ensures the presence of a username" do
      user = User.new(username: "").save
      expect(user).to eq(false)
    end
    
    it "ensures that username has 4 or more characters" do
      user = User.new(username: "uni").save
      expect(user).to eq(false)
    end
  
    it "ensures that valid username will be accepted" do
      user = User.new(username: "gogl457", password: "unauliz2")
      expect(user).to be_valid
    end
  end

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_length_of(:username).is_at_least(4) }
  it { should validate_presence_of(:password) }
  it { should_not validate_length_of(:password).is_at_least(5) }
end

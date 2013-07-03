require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  describe "name" do
    describe "when not present" do
      before { @user.name = "" }
      it { should_not be_valid }
    end
    describe "when too long" do
      before { @user.name = 'a' * 51 }
      it { should_not be_valid }
    end
  end

  describe "authentication" do
    it { should respond_to(:password_digest) }
  end

  describe "email" do
    describe "when not present" do
      before { @user.email = "" }
      it { should_not be_valid }
    end
    it "should be in a valid format" do
      samples = %w[user@foo,com user_at_foo.org example@foo foo@.com foo@bar+baz.com]
      samples.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
    it "should be unique" do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
      expect(@user).not_to be_valid
    end
  end



end

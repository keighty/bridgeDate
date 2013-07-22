require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should_not be_admin }
  it { should respond_to(:remember_token) }

  it { should respond_to(:admin) }
  it { should respond_to(:microposts) }

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

    it "should be saved as all lowercase" do
      mixed_case_email = "Foo@ExAmPlE.CoM"
      @user.email = "Foo@ExAmPlE.CoM"
      @user.password = "foobar"
      @user.password_confirmation = "foobar"
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

  describe 'remember token' do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "with admin attribute set to true" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end
    it { should be_admin }
  end

  describe "micropost associations" do
    before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
    end

    it "should destroy associated microposts" do
      microposts = @user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty
      microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty
      end
    end
  end
end

require 'spec_helper'

describe User do
  context "validation" do
    describe "fullname" do
      it "invalid without fullname" do
        user = User.new(fullname: nil, email: 'user02@example.com', password: 'password', password_confirmation: 'password')
        user.should have(1).error_on(:fullname)
      end
    end

    describe "email" do
      it "downcase email" do
        user = User.create!(fullname: "downcase", email: 'DOWNCASE@example.com', password: 'password', password_confirmation: 'password')
        user.email.should == 'downcase@example.com'
      end
    end
  end

  describe "#friends" do
    it "returns users who are friends" do
      user01 = users(:user01)
      user01.friends.should == [users(:user02)]
    end
  end

  describe "#friend_ids" do
    context "no friends" do
      it "returns empty array" do
        users(:user00).friend_ids.should be_empty
      end
    end
    
    context "with one friend" do
      it "returns array of user id" do
        users(:user01).friend_ids.should == [users(:user02).id]
      end
    end
  end

  describe "User.dummy_create()" do
    context "valid email" do
      it "creates new user" do
        User.dummy_create('thisisnew@example.com').should be_valid
      end
    end

    context "invalid email" do
      it "raise exception" do
        expect do
          User.dummy_create('notanemail')
        end.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
  end
end
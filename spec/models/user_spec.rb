require 'spec_helper'

describe User do

  it "can be instantiated" do
    User.new.should be_an_instance_of(User)
  end

  it "must have attributes" do
    user = User.new
    user.should_not be_valid
    user.should have(1).error_on(:name)
    user.should have(1).error_on(:email)
    user.should have(1).error_on(:password)
    user.should have(1).error_on(:password_confirmation)
  end

  it "can be saved" do
    User.create({ name: "Tester",
                  email: "test@example.com",
                  password: "test-password",
                  password_confirmation: "test-password",
                }).should be_persisted
  end

  it "can be created as inactive" do
    User.create({ name: "Tester",
                  email: "test@example.com",
                  active: false 
                }).should be_persisted
  end
  
  it "can be logged in to if active" do
    User.create({ name: "Tester",
                  email: "test@example.com",
                  password: "test-password",
                  password_confirmation: "test-password",
                }).should be_persisted
    User.find_by_email('test@example.com').password_ok('test-password').should be_true
  end

  it "cannot be logged in to if inactive" do
    User.create({ name: "Tester",
                  email: "test@example.com",
                  password: "test-password",
                  password_confirmation: "test-password",
                  active: false
                }).should be_persisted
    User.find_by_email('test@example.com').password_ok('test-password').should be_false
  end



end

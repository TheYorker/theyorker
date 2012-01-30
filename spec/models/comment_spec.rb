require 'spec_helper'


describe Comment do

  it "can be instantiated" do
    Comment.new.should be_an_instance_of(Comment)
  end

end

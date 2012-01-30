require 'spec_helper'

describe Article do

  it "can be instantiated" do
    Article.new.should be_an_instance_of(Article)
  end
  
end

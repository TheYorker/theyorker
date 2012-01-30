require 'spec_helper'

describe Image do
  it "can be instantiated" do
    Image.new.should be_an_instance_of Image
  end

end

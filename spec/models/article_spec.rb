require 'spec_helper'

describe Article do

  it "can be instantiated" do
    Article.new.should be_an_instance_of(Article)
  end

  it "should have a name" do
    article = Article.new
    article.should_not be_valid
    article.should have(1).errors_on :title
  end

  it "should have a section" do
    article = Article.new
    article.should_not be_valid
    article.should have(1).errors_on :section_id
  end

end

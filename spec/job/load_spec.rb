#encoding: utf-8
require 'spec_helper'

describe Region do
  before :each do
    @load = Load.new(Region.first)  
  end
  
  it "should respond config" do
    @load.should be_respond_to(:config)
  end

  it "shold respond config is hash" do
    @load.config.class.to_s.should == "Hash"
  end

  it "should respond make_criterias" do
    @load.should be_respond_to(:make_criterias)
  end

  it "shold respond make_criterias is hash" do
    @load.make_criterias.class.to_s.should == "Array"
  end

  it "shold respond by respond method " do
    @load.respond({:sex=>2, :age=>20}).class.to_s.should == "Hash"
  end

  it "shold respond by respond method with zero values " do
    @load.respond({:sex=>0, :age=>0}).class.to_s.should == "Hash"
  end
  
end




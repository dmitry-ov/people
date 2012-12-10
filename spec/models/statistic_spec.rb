require 'spec_helper'

describe Statistic do
  before :each do
    @statistic = Statistic.new
  end

  it "should have date" do
    @statistic.should be_respond_to(:date) 
  end

  pending "add foreign key from region"
  pending "validates_presents :region"
  pending "validates_associated :region"
  pending "validates_presents :date"
  pending "validates_presents :hash"
  pending "validates  :hash length/size"
  
  # if size < 600 job must be reload"

end
#encoding: utf-8

require 'spec_helper'

describe Statistic do
  before :each do
    @statistic = Statistic.new
  end

  it "should not valid with only date" do
    @statistic.date = DateTime.now
    @statistic.should be_invalid
  end

  it "should not valid with only hashvalue" do
    @statistic.hashvalue = {"woman" => 110550}
    @statistic.should be_invalid
  end

  it "should not valid with only date" do
    @statistic.region = Region.first  
    @statistic.should be_invalid
  end

  it "should valid with date and region" do
    @statistic.date = DateTime.now
    @statistic.region = Region.first
    @statistic.should be_valid
  end

  it "should save value in db with date,region and hashvalue" do
    @statistic = Statistic.new
    @statistic.date = DateTime.now
    @statistic.region = Region.first
    @statistic.save
    @statistic.hashvalue = {"woman_99" => 88888 }
    @statistic.save.should be_true
  end
 
  pending "validates  :hash  length/size = 600"
  pending "clear method. Похож на аналогичный метод в RespondLog"

end






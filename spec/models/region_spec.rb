#encoding: utf-8
require 'spec_helper'

describe Region do
  before :each do
    @region = Region.new
  end

  describe "name" do
    context "valid" do 
      before :each do
        @region.id_vk = 100046
      end

      it "should not accept nil in name" do
        @region.name = nil
        @region.should be_invalid
      end

      it "should accept space symbol in name" do 
        @region.name = "Хабаровский край"
        @region.name.should == "Хабаровский край"
        @region.should be_valid
      end

      it "should accept symbol - in name" do 
        @region.name = "Ханты-Мансийский автономный округ - Югра"
        @region.name.should == "Ханты-Мансийский автономный округ - Югра"
        @region.should be_valid
      end

      it "should not valid with not string value in name" do
        @region.name = Integer(12)
        @region.should_not be_valid
      end
    end
  end

  describe "id_vk" do
    context "valid" do
      before :each do
        @region.name = "Ямало-Ненецкий"
      end   
      
      it "integer value" do
        @region.id_vk = -100046
        @region.should be_valid
      end

      it "not integer invalid" do 
        @region.id_vk = "Якутия"
        @region.should be_invalid
      end

      it "invalid not cirilic" do 
        @region.id_vk = "Moscow"
        @region.should be_invalid
      end
    end
  end
end
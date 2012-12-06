require 'spec_helper'


describe Region do
	before :each do
		@region = Region.new
	end

	describe "name" do
	  it "should have name" do
	  	@region.should be_respond_to(:name) 
	  end

	  it "should save value name" do
	    @region.name = "random first name"
	    @region.name.should == "random first name"
	  end
	end
	
	describe "id_vk" do
	  it "should have id_vk" do
	  	@region.should be_respond_to(:id_vk) 
	  end

	  it "should save value id_vk" do
	    @region.id_vk = -100046
	    @region.id_vk.should == -100046
	  end
	end

  describe "valid" do  
    it "should be valid" do
      @region.name = 'moscow'
      @region.id_vk = -100046
      @region.save.should be_true
    end
  end
end
require 'spec_helper'

describe RespondLog do
  before :each do
    @respondlog = RespondLog.new 
  end

  it "should have regions" do
    @respondlog.should be_respond_to(:region)
  end

  it "should valid with region_id, responddate, status attributes" do
    @respondlog.region_id = Region.first
    @respondlog.responddate = DateTime.now
    @respondlog.status = "report about response"
    @respondlog.should be_valid
  end
 
  it "should add to log" do
    before = RespondLog.all.size
    RespondLog.add(Region.first, DateTime.now, "Long long report about response" )
    (RespondLog.all.size - before).should == 1
  end
  
  it "should clear log" do
    before = RespondLog.all.size
    RespondLog.clear 
    (RespondLog.all.size - before).should == 0
  end


  pending "send mail. run every hour"
  
  pending "send log to e-mail's if exist"

  pending "clear log action on page"


end

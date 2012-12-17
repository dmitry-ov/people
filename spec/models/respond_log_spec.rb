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
    RespondLog.create(:region_id => Region.first, :responddate => DateTime.now, :status => "report")
    RespondLog.clear 
    RespondLog.all.size.should == 0
  end

  it "should send mail" do 
    Mail.deliver do
      to 'mikel@me.com'
      from 'you@you.com'
      subject 'testing'
      body 'hello'
    end
    Mail::TestMailer.deliveries.length.should == 1
    Mail::TestMailer.deliveries.first
    Mail::TestMailer.deliveries.clear
  end
end

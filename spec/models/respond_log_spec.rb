require 'spec_helper'

describe RespondLog do
  before :each do
    @respondlog = RespondLog.new 
  end

  it "should have regions" do
    @respondlog.should be_respond_to(:region)
  end

  context "status" do
    before :each do
      @respondlog = RespondLog.new
      @respondlog.region_id = Region.first
      @respondlog.responddate = DateTime.now
      @respondlog.message = "report about response... Long long message....."
    end  

    it "should valid with region_id, responddate, message and status success attributes" do
      @respondlog.status = "success"
      @respondlog.should be_valid
    end

    it "should valid with region_id, responddate, message and status fail attributes" do
      @respondlog.status = "fail"
      @respondlog.should be_valid
    end

    it "should valid with region_id, responddate, message and status error attributes" do
      @respondlog.status = "error"
      @respondlog.should be_valid
    end
  end
 
  it "should add to log" do
    before = RespondLog.all.size
    RespondLog.add(Region.first, DateTime.now, "fail", "Long long report about response" )
    (RespondLog.all.size - before).should == 1
  end
  
  it "should clear log" do
    Random.rand(10).times do |r|
      RespondLog.add(Region.all[(rand(83))], DateTime.now, "fail", "#{r} Long report")
    end

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

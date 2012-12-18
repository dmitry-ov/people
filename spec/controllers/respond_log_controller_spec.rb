require 'spec_helper'

describe RespondLogController do

  describe "GET 'log'" do
    it "returns http success" do
      get 'log'
      response.should be_success
    end
  end

end

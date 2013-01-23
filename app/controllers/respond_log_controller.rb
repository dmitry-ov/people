class RespondLogController < ApplicationController
  def log
    @log = RespondLog.order("id DESC").all    
  end

end 
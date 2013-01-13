class RespondLogController < ApplicationController
  def log
    @log = RespondLog.all    
  end

end 
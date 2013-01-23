#encoding: utf-8
class Fetch

  @@time = nil

  def initialize(region)
      @region=region
  end

  def perform
    load = Load.new(@region)
   
    time_begin = Time.new
      region_report = load.report 
    @@time = Time.new - time_begin 

    statistic = Statistic.create(:date => DateTime.now, :region => @region)
    statistic.hashvalue = region_report 
    statistic.save
  end

  def before(job)
  end

  def after(job)
  end

  def success(job)
    RespondLog.add(@region, DateTime.now, "success", "Выполнено за #{@@time} секунд")
  end

  def error(job, exception)
    # Airbrake.notify(exception)
    RespondLog.add(@region, DateTime.now, "error", "Class: #{exception.class.to_s}   Message: #{exception.message.to_s}" )
   sleep 3
  end

  def failure
    # page_sysadmin_in_the_middle_of_the_night
    RespondLog.add(@region, DateTime.now, "fail", "Удалено из очереди")
  end
end

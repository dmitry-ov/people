#encoding: utf-8
class Fetch

  def initialize(region)
      @region=region
  end

  def perform
    load = Load.new(@region)
    region_report = load.report 
    statistic = Statistic.create(:date => DateTime.now, :region => @region)
    statistic.hashvalue = region_report 
    statistic.save
  end

  def before(job)
  end

  def after(job)
  end

  def success(job)
    RespondLog.add(@region, DateTime.now, "success", "Выполнено")
  end

  def error(job, exception)
    # Airbrake.notify(exception)
    RespondLog.add(@region, DateTime.now, "error", "Class: #{exception.class.to_s}   Message: #{exception.message.to_s}" )
  end

  def failure
    # page_sysadmin_in_the_middle_of_the_night
    RespondLog.add(@region, DateTime.now, "fail", "Удалено из очереди")
  end
end
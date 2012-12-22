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
    # record_stat 'newsletter_job/start'
  end

  def after(job)
    # record_stat 'newsletter_job/after'
  end

  def success(job)
    # record_stat 'newsletter_job/success'
    # пишем в лог о успешном получении запросов по региону
    
  end

  def error(job, exception)
    # Airbrake.notify(exception)
    # пишем в лог о том что появились ошибки. текст ошибки записываем

  end

  def failure
    page_sysadmin_in_the_middle_of_the_night
    # лог падений записываем в таблицу

  end
end
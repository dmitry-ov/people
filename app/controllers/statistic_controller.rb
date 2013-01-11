class StatisticController < ApplicationController
  def index
    @statistic = Statistic.all
  end
end

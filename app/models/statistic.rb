class Statistic < ActiveRecord::Base
  attr_accessible :date, :hashvalue, :region
  validates_presence_of :date, :region
  belongs_to :region

  def self.fetch
     Region.all.each do |region|
       Delayed::Job.enqueue Fetch.new(region) 
     end
  end

  def self.clear
    Statistic.all.each do |s|
      s.delete
    end
  end



end
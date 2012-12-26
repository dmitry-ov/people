#encoding: utf-8
class RespondLog < ActiveRecord::Base
  attr_accessible :region_id, :responddate, :status, :message

  belongs_to :region

  validates_presence_of :region_id, :responddate, :status, :message 
  
  validates :status, :inclusion => { :in => %w(success fail error),
    :message => "%{value} is not a valid status"}

  def self.add(region, date, status, message)
    RespondLog.create(
      :region_id => region.id,
      :responddate=> date, 
      :status => status,
      :message => message)
  end

  def self.clear
    RespondLog.all.each do |r|
      r.delete    
    end
  end
  
end

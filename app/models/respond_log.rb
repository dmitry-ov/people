class RespondLog < ActiveRecord::Base
  attr_accessible :region_id, :responddate, :status

  belongs_to :region

  validates_presence_of :region_id, :responddate, :status

  def self.add(region, date, status)
    RespondLog.create(
      :region_id => region.id,
      :responddate=> date, 
      :status => status)
  end

  def self.clear
    RespondLog.all.each do |r|
      r.delete    
    end
  end
  
end

class Statistic < ActiveRecord::Base
  attr_accessible :date, :hashvalue, :region
  validates_presence_of :date, :region
  belongs_to :region
end

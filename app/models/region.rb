class Region < ActiveRecord::Base
  attr_accessible :name, :id_vk
  # has_many :statistics
  validates_presence_of :name, :id_vk
  # validates :name, 
  validates :id_vk, :numericality => { :only_integer => true }
end

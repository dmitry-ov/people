class Region < ActiveRecord::Base
  attr_accessible :name, :id_vk
  # has_many :statistics
  validates_presence_of :name, :id_vk
  validates :id_vk, :numericality => { :only_integer => true }

  # Это криво, но использовать в регулярных выражениях 
  # русские буквы не приемлимо для rspec
  validates :name, 
    :presence => true,
    :if => Proc.new {|name| name.class == "String"}
end

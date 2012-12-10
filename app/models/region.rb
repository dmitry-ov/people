#encoding: utf-8
class Region < ActiveRecord::Base
  attr_accessible :name, :id_vk
  # has_many :statistics

  validates_presence_of :name, :id_vk
  validates :id_vk, :numericality => { :only_integer => true }
  
  validates :name, 
    :format => {  
      :with => /[а-яА-Я ()-]/, 
      :message => "Допустимы только русские буквы" }

  has_many :statistics
end

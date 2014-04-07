class Period < ActiveRecord::Base
  has_many :checkins
  attr_accessible :beginning, :end_at, :name

  def self.actual_period
  	Period.where("beginning < '#{Date.today}'").where("end_at > '#{Date.today}'").first
  end
end

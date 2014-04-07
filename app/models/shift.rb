class Shift < ActiveRecord::Base
  belongs_to :block
  has_many :checkins
  attr_accessible :weekday, :block_id, :meeting

  def name
  	self.weekday + " " + self.block.name
  end

end

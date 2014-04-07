class Block < ActiveRecord::Base
  attr_accessible :end_at, :name, :start_at
end

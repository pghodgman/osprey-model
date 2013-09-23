class Model < ActiveRecord::Base
  has_many :bodies
  has_one :location
  has_many :levels
end

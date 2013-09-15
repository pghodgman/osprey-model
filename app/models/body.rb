class Body < ActiveRecord::Base
  has_one :transform
  belongs_to :model
end

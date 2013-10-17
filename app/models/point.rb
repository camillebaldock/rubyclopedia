class Point < ActiveRecord::Base
belongs_to :kind  
belongs_to :user  
  attr_accessible :kind_id, :user_id, :value
end

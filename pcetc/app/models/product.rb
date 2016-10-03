class Product < ActiveRecord::Base

  belongs_to :category
  belongs_to :vendor

  searchkick text_start: [‘name’]

end

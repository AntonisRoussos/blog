class Post < ActiveRecord::Base
  attr_accessor :name
  attr_accessible :name
  validates :name,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :tags
 
  accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
end

# == Schema Information
# Schema version: 20101214111833
#
# Table name: institution_types
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class InstitutionType < ActiveRecord::Base
  default_scope :order => :name
  validates_presence_of :name

  simple_column_search :name, :match => :middle, :escape => lambda { |query| query.gsub(/[^\w\s\-\.']/, "").strip }
end

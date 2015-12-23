class Bird
  include Mongoid::Document
  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :added, type: Date, default: ->{Time.now}
  field :visible, type: Mongoid::Boolean, default: false
  validates_length_of :continents, minimum: 1
end

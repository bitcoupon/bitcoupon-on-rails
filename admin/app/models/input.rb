# Input
class Input
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :id, :transaction_id, :output_id, :signature

  validates_presence_of :title

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def self.from_json(input_json)
    input = Input.new

    unless input_json.blank?
      # TODO: senere
      # input.save
    end

    input
  end
end

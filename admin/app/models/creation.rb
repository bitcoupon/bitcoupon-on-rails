# Creation
class Creation
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :id, :transaction_id, :creator_address, :amount, :signature

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def self.from_json(creation_json)
    creation = Creation.new

    unless creation_json.blank?
      # Only one creation for now
      creation_json = creation_json.first
      # TODO: Make loop

      creation.creator_address = creation_json['creatorAddress']
      creation.amount = creation_json['amount'].to_i
      creation.signature = creation_json['signature']
    end

    creation
  end
end

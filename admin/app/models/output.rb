# Output
class Output
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor(:id, :transaction_id, :creator_address,
                :amount, :address, :input)

  validates_presence_of :title

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def self.from_json(output_json)
    output = Output.new

    unless output_json.blank?
      # Only one creation for now
      output_json = output_json.first
      # TODO: Make loop

      output.creator_address = output_json['creatorAddress']
      output.amount = output_json['amount'].to_i
      output.address = output_json['address']
      # TODO: Add input when relevant
      # output.save
    end

    output
  end
end

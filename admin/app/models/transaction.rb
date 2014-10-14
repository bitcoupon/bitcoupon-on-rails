# Transaction
class Transaction
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :id, :creation, :input, :output

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def self.from_json(parsed_output)
    creation_json = parsed_output['creations']
    input_json = parsed_output['inputs']
    output_json = parsed_output['outputs']

    transaction = Transaction.new

    transaction.creation = Creation.from_json(creation_json)
    transaction.input = Input.from_json(input_json)
    transaction.output = Output.from_json(output_json)
    transaction
  end
end

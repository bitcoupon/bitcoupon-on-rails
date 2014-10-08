class Transaction
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :id, :creation, :input, :output

  # has_many :creations
  # has_many :inputs
  # has_many :outputs

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
    creation = Creation.new
    input = Input.new
    output = Output.new

    unless creation_json.blank?
      # Only one creation for now
      creation_json = creation_json.first
      # TODO: Make loop

      creation.creator_address = creation_json['creatorAddress']
      creation.amount = creation_json['amount'].to_i
      creation.signature = creation_json['signature']
      # creation.save
    end

    unless input_json.blank?
      # TODO: senere
      # input.save
    end

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

    transaction.creation = creation
    transaction.input = input
    transaction.output = output
    transaction
  end
end

# Transaction
class Transaction < ActiveRecord::Base
  has_many :creations
  has_many :inputs
  has_many :outputs

  def self.from_json(transaction_json)
    parsed_transaction = JSON.parse(transaction_json)

    creation_json = parsed_transaction['creations']
    input_json = parsed_transaction['inputs']
    output_json = parsed_transaction['outputs']

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
      creation.save
    end

    unless input_json.blank?
      input_json = input_json.first

      input.output_id = input_json['outputId'].to_i
      input.signature = input_json['signature']
      input.save

      o = Output.find(input.output_id)
      o.input_id = input.id
      o.save
      # input.save
    end

    unless output_json.blank?
      # Only one creation for now
      output_json = output_json.first
      # TODO: Make loop

      output.creator_address = output_json['creatorAddress']
      output.amount = output_json['amount'].to_i
      output.address = output_json['address']
      output.input_id = 0
      # TODO: Add input when relevant
      output.save
    end

    transaction.creations << creation if creation.id
    transaction.inputs << input if input.id
    transaction.outputs << output if output.id
    transaction
  end

  def self.history
    transactions = all.to_a

    history = { transactionList: [] }

    transactions.each do |transaction|
      history[:transactionList] << transaction_hash(transaction)
    end

    history.to_json
  end

  def self.transaction_hash(t)
    transaction_hash = { transactionId: t.id }

    c = t.creations.first
    transaction_hash['creations'] = creation_hash(c)

    i = t.inputs.first
    transaction_hash['inputs'] = input_hash(i)

    o = t.outputs.first
    transaction_hash['outputs'] = output_hash(o)

    transaction_hash
  end

  def self.creation_hash(c)
    if c.blank?
      []
    else
      [{
        creationId: c.id,
        creatorAddress: c.creator_address,
        amount: c.amount,
        signature: c.signature
      }]
    end
  end

  def self.input_hash(i)
    if i.blank?
      []
    else
      [{
        inputId: i.id,
        outputId: i.output_id.to_i,
        signature: i.signature
      }]
    end
  end

  def self.output_hash(o)
    return [] if o.blank?
    [{
      outputId: o.id,
      creatorAddress: o.creator_address,
      amount: o.amount,
      address: o.address,
      inputId: o.input_id
    }]
  end
end

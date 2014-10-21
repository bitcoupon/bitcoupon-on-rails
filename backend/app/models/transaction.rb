# Transaction
class Transaction < ActiveRecord::Base
  has_many :creations
  has_many :inputs
  has_many :outputs

  def self.from_json(transaction_json)
    parsed_transaction = JSON.parse(transaction_json)

    transaction = Transaction.new

    relations_from_json transaction, parsed_transaction

    transaction
  end

  def self.relations_from_json(transaction, parsed_transaction)
    creation_json = parsed_transaction['creations']
    input_json = parsed_transaction['inputs']
    output_json = parsed_transaction['outputs']

    creation = Creation.from_json(creation_json)
    input = Input.from_json(input_json)
    output = Output.from_json(output_json)

    transaction.creations << creation if creation.id
    transaction.inputs << input if input.id
    transaction.outputs << output if output.id
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
      address: o.receiver_address,
      inputId: o.input_id
    }]
  end
end

# Output
class Output < ActiveRecord::Base
  # Rails has method named transaction, can't use that again here.
  belongs_to(:bitcoin_transaction,
             foreign_key: 'transaction_id',
             class_name: 'Transaction')

  def self.from_json(output_json)
    output = Output.new
    return output if output_json.blank?

    # Only one creation for now
    output_json = output_json.first
    # TODO: Make loop

    output.creator_address = output_json['creatorAddress']
    output.payload = output_json['payload']
    output.amount = output_json['amount'].to_i
    output.receiver_address = output_json['receiverAddress']
    output.input_id = output_json['referringInput'].to_i

    output.save
    output
  end

  def self.history
    outputs = all.to_a

    history = { outputList: [] }

    outputs.each do |transaction|
      history[:outputList] << output_hash(transaction)
    end

    history.to_json
  end

  def self.output_hash(o)
    return nil if o.blank?
    {
      outputId: o.id,
      creatorAddress: o.creator_address,
      payload: o.payload,
      amount: o.amount,
      receiverAddress: o.receiver_address,
      referringInput: o.input_id
    }
  end
end

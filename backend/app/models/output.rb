# Output
class Output < ActiveRecord::Base
  # Rails has method named transaction, can't use that again here.
  belongs_to(:bitcoin_transaction,
             foreign_key: 'transaction_id',
             class_name: 'Transaction')

  def self.from_json(output_json)
    output = Output.new

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

    output
  end
end

# Input
class Input < ActiveRecord::Base
  # Rails has method named transaction, can't use that again here.
  belongs_to(:bitcoin_transaction,
             foreign_key: 'transaction_id',
             class_name: 'Transaction')

  def self.from_json(input_json)
    input = Input.new

    unless input_json.blank?
      input_json = input_json.first

      input.output_id = input_json['referredOutput'].to_i
      input.signature = input_json['signature']
      input.save

      save_output(input)
    end

    input
  end

  def self.save_output(input)
    o = Output.find(input.output_id)
    o.input_id = input.id
    o.save
  end
end

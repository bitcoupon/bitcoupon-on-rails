# Creation
class Creation < ActiveRecord::Base
  # Rails has method named transaction, can't use that again here.
  belongs_to(:bitcoin_transaction,
             foreign_key: 'transaction_id',
             class_name: 'Transaction')

  def self.from_json(creation_json)
    creation = Creation.new

    unless creation_json.blank?
      # Only one creation for now
      creation_json = creation_json.first
      # TODO: Make loop

      creation.creator_address = creation_json['creatorAddress']
      creation.amount = creation_json['amount'].to_i
      creation.signature = creation_json['signature']
      creation.save
    end

    creation
  end
end

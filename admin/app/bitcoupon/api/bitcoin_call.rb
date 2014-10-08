module Bitcoupon
  module Api
    # Class encapsulating integration with Bitcoupon Java library
    class BitcoinCall
      attr_accessor :command, :method

      def initialize
        @command = 'java -jar ../bitcoin/bitcoin-1.0.jar'
      end

      # Name: getCreatorAddresses
      # Arguments: String privateKey, String transactionHistoryJson
      def creator_addresses(private_key, transaction_history)
        @method = 'getCreatorAddresses'
        key     = Shellwords.escape private_key
        history = Shellwords.escape transaction_history

        `#{command} #{method} #{key} #{history}`
      end

      # Name: generateCreationTransaction
      # Arguments: String privateKey
      def generate_creation_transaction(private_key)
        @method = 'generateCreationTransaction'

        `#{@command} #{method} #{private_key}`
      end

      # Name: generateSendTransaction
      # Arguments: String privateKey, String creatorAddress,
      #            String transactionHistoryJson, String receiverAddress
      def generate_send_transaction(private_key, creator_address,
                                    transaction_history, receiver_address)
        @method = 'generateSendTransaction'
        history = Shellwords.escape transaction_history

        `#{command} #{method} #{private_key}\
         #{creator_address} #{history} #{receiver_address}`
      end

      # Name: verifyTransaction
      # Arguments: String transactionJson, String transactionHistoryJson
      def verify_transaction
      end
    end
  end
end

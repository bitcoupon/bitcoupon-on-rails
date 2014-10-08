module Bitcoupon
  module Api
    # Class encapsulating integration with Bitcoupon Java library
    class BitcoinCall
      attr_accessor :command, :method

      def initialize
        @command = 'java -jar ../bitcoin/bitcoin-1.0.jar'
      end

      # Name: getCreatorAddresses
      # Argumentss: String privateKey, String transactionHistoryJson
      def creator_addresses(private_key, transaction_history)
        @method = 'getCreatorAddresses'
        key     = Shellwords.escape private_key
        history = Shellwords.escape transaction_history

        `#{command} #{method} #{key} #{history}`
      end
    end
  end
end

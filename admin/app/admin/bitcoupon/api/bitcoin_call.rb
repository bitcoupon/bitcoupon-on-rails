module Bitcoupon
  module Api
    # Class encapsulating integration with Bitcoupon Java library
    class BitcoinCall
      attr_accessor :command, :method

      def initialize
        @command = 'java -jar ../bitcoin/bitcoin-2.0.jar'
      end

      # 2.0 Library
      # Name: generateCreateTransaction
      #   Arguments: String strPrivateKey, String payload

      def generate_create_transaction(private_key, payload_input)
        @method = 'generateCreateTransaction'
        key     = Shellwords.escape private_key
        payload = Shellwords.escape payload_input

        `#{command} #{method} #{key} #{payload}`
      end

      # Name: generateSendTransaction
      #   Arguments: String strPrivateKey, String creatorAddress,
      #              String payload, String receiverAddress,
      #              String outputHistoryJson

      def generate_send_transaction(private_key, creator_address, payload,
                                    receiver_address, output_history)
        @method = 'generateSendTransaction'
        payload = Shellwords.escape payload
        history = Shellwords.escape output_history

        `#{command} #{method} #{private_key} \
#{creator_address} #{payload} #{receiver_address} #{history}`
      end

      # Name: generateDeleteTransaction
      #   Arguments: String strPrivateKey, String creatorAddress,
      #              String payload, String outputHistoryJson

      def generate_delete_transaction(private_key, creator_address, payload,
                                      output_history)
        @method = 'generateDeleteTransaction'
        payload = Shellwords.escape payload
        history = Shellwords.escape output_history

        `#{command} #{method} #{private_key} \
#{creator_address} #{payload} #{history}`
      end

      # Name: verifyTransaction
      #   Arguments: String transactionJson, String outputHistoryJson

      def verify_transaction(transaction_json, output_history_json)
        @method = 'verifyTransaction'
        arg_one = Shellwords.escape transaction_json.chomp
        arg_two = Shellwords.escape output_history_json

        output = `#{command} #{method} #{arg_one} #{arg_two}`

        if output.chomp.eql? 'true'
          true
        else
          false
        end
      end

      # Name: generateOutputHistoryRequest
      #   Arguments: String strPrivateKey

      def generate_output_history_request(private_key)
        @method = 'generateOutputHistoryRequest'

        `#{command} #{method} #{private_key}`
      end

      # Name: verifyOutputHistoryRequest
      #   Arguments: String outputHistoryRequestJson

      def verify_output_history_request(output_history_request)
        @method = 'verifyOutputHistoryRequest'
        request = Shellwords.escape output_history_request

        output = `#{command} #{method} #{request}`

        if output.chomp.eql? 'true'
          true
        else
          false
        end
      end

      # Name: getCoupons
      #   Arguments: String address, String outputHistoryJson

      def get_coupons(address, output_history_json)
        @method = 'getCoupons'
        address     = Shellwords.escape address
        history = Shellwords.escape output_history_json

        `#{command} #{method} #{address} #{history}`
      end

      # Name: getCouponOwners
      #   Arguments: String creatorAddress, String outputHistoryJson

      def get_coupon_owners(address, output_history_json)
        @method = 'getCouponOwners'
        address     = Shellwords.escape address
        history = Shellwords.escape output_history_json

        `#{command} #{method} #{address} #{history}`
      end

      # Name: generatePrivateKey
      #   Arguments: none

      def generate_private_key
        @method = 'generatePrivateKey'
        `#{command} #{method}`
      end

      # Name: generateAddress
      #   Arguments: String strPrivateKey

      def generate_address(private_key)
        @method = 'generateAddress'
        `#{command} #{method} #{private_key}`
      end
    end
  end
end

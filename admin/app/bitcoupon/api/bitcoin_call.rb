module Bitcoupon
  module Api
    # Class encapsulating integration with Bitcoupon Java library
    class BitcoinCall
      attr_accessor :command_1_0, :command_2_0, :method

      def initialize
        @command_1_0 = 'java -jar ../bitcoin/bitcoin-1.0.jar'
        @command_2_0 = 'java -jar ../bitcoin/bitcoin-2.0.jar'
      end

      # 1.0 Library

      # Name: getCreatorAddresses
      # Arguments: String privateKey, String transactionHistoryJson
      def creator_addresses(private_key, transaction_history)
        @method = 'getCreatorAddresses'
        key     = Shellwords.escape private_key
        history = Shellwords.escape transaction_history

        `#{command_1_0} #{method} #{key} #{history}`
      end

      # Name: generateCreationTransaction
      # Arguments: String privateKey
      def generate_creation_transaction(private_key)
        @method = 'generateCreationTransaction'

        `#{command_1_0} #{method} #{private_key}`
      end

      # Name: generateSendTransaction
      # Arguments: String privateKey, String creatorAddress,
      #            String transactionHistoryJson, String receiverAddress
      def generate_send_transaction_1_0(private_key, creator_address,
                                    transaction_history, receiver_address)
        @method = 'generateSendTransaction'
        history = Shellwords.escape transaction_history

        `#{command_1_0} #{method} #{private_key}\
         #{creator_address} #{history} #{receiver_address}`
      end

      # Name: verifyTransaction
      # Arguments: String transactionJson, String transactionHistoryJson
      def verify_transaction_1_0(transaction_json, transaction_history_json)
        @method = 'verifyTransaction'
        arg_one = Shellwords.escape transaction_json.chomp
        arg_two = Shellwords.escape transaction_history_json
        output = `#{command_1_0} #{method} #{arg_one} #{arg_two}`

        if output.chomp.eql? 'true'
          true
        else
          false
        end
      end

      # 2.0 Library
      # Name: generateCreateTransaction
      #   Arguments: String strPrivateKey, String payload

      def generate_create_transaction(private_key, payload_input)
        @method = 'generateCreateTransaction'
        key     = Shellwords.escape private_key
        payload = Shellwords.escape payload_input

        `#{command_2_0} #{method} #{key} #{payload}`
      end

      # Name: generateSendTransaction
      #   Arguments: String strPrivateKey, String couponJson,
      #              String receiverAddress, String outputHistoryJson

      def generate_send_transaction(private_key, creator_address, payload,
                                    receiver_address, output_history)
        @method = 'generateSendTransaction'
        history = Shellwords.escape output_history

        `#{command_2_0} #{method} #{private_key}\
         #{creator_address} #{payload} #{receiver_address} #{history}`
      end

      # Name: verifyTransaction
      #   Arguments: String transactionJson, String outputHistoryJson

      def verify_transaction(transaction_json, output_history_json)
        @method = 'verifyTransaction'
        arg_one = Shellwords.escape transaction_json.chomp
        arg_two = Shellwords.escape output_history_json

        output = `#{command_2_0} #{method} #{arg_one} #{arg_two}`

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
        key     = Shellwords.escape address
        history = Shellwords.escape output_history_json

        `#{command_2_0} #{method} #{key} #{history}`
      end

      # Name: getCouponOwners
      #   Arguments: String creatorAddress, String payload,
      #              String outputHistoryJson

      def get_coupon_owners
      end

      # Name: generatePrivateKey
      #   Arguments: none

      def generate_private_key
        @method = 'generatePrivateKey'
        `#{command_2_0} #{method}`
      end

      # Name: generateAddress
      #   Arguments: String strPrivateKey

      def generate_address(private_key)
        @method = 'generateAddress'
        `#{command_2_0} #{method} #{private_key}`
      end

      private

      # Takes care of calling the shell
      # TODO: Do something if errors are written to.
      def open
        cmd = "#{command_1_0} #{method} #{arg_one} #{arg_two}"
        output = ''

        Open3.popen3(cmd) do |_stdin, stdout, stderr, wait_thr|
          _pid = wait_thr.pid # pid of the started process.
          output = stdout.read
          _errors = stderr.read
          _exit_status = wait_thr.value # Process::Status object returned.
        end

        output
      end
    end
  end
end

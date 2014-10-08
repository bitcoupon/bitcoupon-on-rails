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

      def verify_transaction(transaction_json, transaction_history_json)
        @method = 'verifyTransaction'
        arg_one = Shellwords.escape transaction_json.chomp
        arg_two = Shellwords.escape transaction_history_json
        output = `#{@command} #{method} #{arg_one} #{arg_two}`

        if output.chomp.eql? 'true'
          true
        else
          false
        end
      end

      private

      # Takes care of calling the shell
      # TODO: Do something if errors are written to.
      def open
        cmd = "#{command} #{method} #{arg_one} #{arg_two}"
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

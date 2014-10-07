require_dependency '../bitcoupon/api/backend_request'
require_dependency '../bitcoupon/api/bitcoin_call'

##
# TransactionsController
#
class TransactionsController < ApplicationController
  def index
    request = backend_request.new :get, '/transaction_history'
    result = request.start

    private_key = '5JAy2V6vCJLQnD8rdvB2pF8S6bFZuhEzQ43D95k6wjdVQ4ipMYu'
    transaction_history = JSON.parse(result.body)

    output = bitcoin.new.creator_addresses(private_key, transaction_history)

    @transactions = output.split("\n")
  end

  def generate_creation
    @json = '{"transactionId":0,"creations":[{"creationId":0,"creatorAddress":"1LfXmYtDHyCM8fHMhrMX2EtfECGjzmw3BW","amount":1,"signature":"EsykzEva7gBWpyZbpBXvyWiZb3Dwta18T6uEg4E39jdpkh3ouaNhaGyfg3rVfij4bY38pnuyedT6Ab63wyBzY2z6WUUy4P5v1QqDx 3agqkP4xN8q573oKCJTNz3nb1y4euvuAP2qeuaLRhpvGCRoJ3godvpEDKqAEGP6GyeYLw9hRtgczD9NPv5drmE7Q5DF8dd"}],"inputs":[],"outputs":[{"outputId":0,"creatorAddress":"1LfXmYtDHyCM8fHMhrMX2EtfECGjzmw3BW","amount":1,"address":"1LfXmYtDHyCM8fHMhrMX2EtfECGjzmw3BW","inputId":0}]}'
    @command = 'java -jar ../bitcoin/bitcoin-1.0.jar'

    @method_name = 'generateCreationTransaction'
    @private_key = '5JAy2V6vCJLQnD8rdvB2pF8S6bFZuhEzQ43D95k6wjdVQ4ipMYu'

    @output = `#{@command} #{@method_name} #{@private_key}`

    render(text: 'Something went wrong') and return if @output.blank?

    @id = verify_transaction @output
    @parsed_json = JSON.parse(@json)
    @parsed_output = JSON.parse(@output)

    creation_json = @parsed_output['creations']
    input_json = @parsed_output['inputs']
    output_json = @parsed_output['outputs']
    %#
{"transactionId"=>0,
 "creations"=>
  [{"creationId"=>0,
    "creatorAddress"=>"1LfXmYtDHyCM8fHMhrMX2EtfECGjzmw3BW",
    "amount"=>1,
    "signature"=>
     "EsykzF7P9LpLSFNiR6PTBJH5LrxKQLAn6bSnKwXUVgTiMQE9kGfvd3UQuYvxhKR6uFvRDBFqsRbkWzRS3Ki9AR4mMNYDLumNN1ZXn 3agqkP4xN8q573oKCJTNz3nb1y4euvuAP2qeuaLRhpvGCRoJ3godvpEDKqAEGP6GyeYLw9hRtgczD9NPv5drmE7Q5DF8dd"}],
 "inputs"=>[],
 "outputs"=>
  [{"outputId"=>0,
    "creatorAddress"=>"1LfXmYtDHyCM8fHMhrMX2EtfECGjzmw3BW",
    "amount"=>1,
    "address"=>"1LfXmYtDHyCM8fHMhrMX2EtfECGjzmw3BW",
    "inputId"=>0}]}
  %#

    transaction = Transaction.new
    creation = Creation.new
    input = Input.new
    output = Output.new

    unless creation_json.blank?
      # Only one creation for now
      creation_json = creation_json.first
      # TODO: Make loop

      creation.creator_address = creation_json['creatorAddress']
      creation.amount = creation_json['amount'].to_i
      creation.signature = creation_json['signature']
      # creation.save
    end

    unless input_json.blank?
      # TODO: senere
      # input.save
    end

    unless output_json.blank?
      # Only one creation for now
      output_json = output_json.first
      # TODO: Make loop

      output.creator_address = output_json["creatorAddress"]
      output.amount = output_json["amount"].to_i
      output.address = output_json["address"]
      # TODO Add input når relevant
      #output.save
    end

    transaction.creation = creation
    transaction.input = input
    transaction.output = output
    @transaction = transaction
    # render json: "#{@output}\n\n\n#{@json}"
  end

  def generate_send
    private_key = '5JAy2V6vCJLQnD8rdvB2pF8S6bFZuhEzQ43D95k6wjdVQ4ipMYu'

    # Public key: 138u97o2Sv5qUmucSasmeNf5CAb3B1CmD6
    creator_public_key = params['public_key']

    transaction_history = Shellwords.escape get_transaction_history.to_s

    # Receiver address: 1Kau4L6BM1h6QzLYubq1qWrQSjWdZFQgMb
    receiver_address = params['receiver_address']

    command = 'java -jar ../bitcoin/bitcoin-1.0.jar'
    method = 'generateSendTransaction'

    output = `#{command} #{method} #{private_key} #{creator_public_key} #{transaction_history} #{receiver_address}`

    if output.blank?
      render text: "Something went wrong" and return
    end

    id = verify_transaction output

    # Name: generateSendTransaction - Argumentss: String privateKey, String creatorPublicKey
    #                             , String transactionHistoryJson, String receiverAddress
    #binding.pry
    redirect_to root_path
  end

  private

  def get_transaction_history
    request = backend_request.new :get, '/transaction_history'
    result = request.start

    @transactions = JSON.parse(result.body)
  end

  def verify_transaction(output)
    request = backend_request.new :post, '/verify_transaction'
    request.content_type = 'application/json'
    request.body = { transaction: output }.to_json
    result = request.start

    id = result.header['id'].to_i
    id
  end
end

var search_data = {"index":{"searchIndex":["address","applicationcontroller","bitcoupon","api","backendrequest","bitcoincall","sessionscontroller","transactionscontroller","transactionshelper","user","userscontroller","command()","create()","create()","destroy()","destroy()","edit()","generate_address()","generate_create()","generate_create_transaction()","generate_delete()","generate_delete_transaction()","generate_keys()","generate_output_history_request()","generate_private_key()","generate_send()","generate_send_transaction()","get_coupon_owners()","get_coupons()","index()","index()","new()","new()","output_history_request()","password?()","show()","start()","translate_address()","update()","verify_output_history_request()","verify_transaction()","welcome()","readme"],"longSearchIndex":["address","applicationcontroller","bitcoupon","bitcoupon::api","bitcoupon::api::backendrequest","bitcoupon::api::bitcoincall","sessionscontroller","transactionscontroller","transactionshelper","user","userscontroller","bitcoupon::api::bitcoincall::command()","sessionscontroller#create()","userscontroller#create()","sessionscontroller#destroy()","userscontroller#destroy()","userscontroller#edit()","bitcoupon::api::bitcoincall::generate_address()","transactionscontroller#generate_create()","bitcoupon::api::bitcoincall::generate_create_transaction()","transactionscontroller#generate_delete()","bitcoupon::api::bitcoincall::generate_delete_transaction()","user#generate_keys()","bitcoupon::api::bitcoincall::generate_output_history_request()","bitcoupon::api::bitcoincall::generate_private_key()","transactionscontroller#generate_send()","bitcoupon::api::bitcoincall::generate_send_transaction()","bitcoupon::api::bitcoincall::get_coupon_owners()","bitcoupon::api::bitcoincall::get_coupons()","transactionscontroller#index()","userscontroller#index()","bitcoupon::api::backendrequest::new()","userscontroller#new()","user#output_history_request()","user#password?()","userscontroller#show()","bitcoupon::api::backendrequest#start()","transactionshelper#translate_address()","userscontroller#update()","bitcoupon::api::bitcoincall::verify_output_history_request()","bitcoupon::api::bitcoincall::verify_transaction()","userscontroller#welcome()",""],"info":[["Address","","Address.html","","<p>Address\n"],["ApplicationController","","ApplicationController.html","","<p>ApplicationController\n"],["Bitcoupon","","Bitcoupon.html","",""],["Bitcoupon::Api","","Bitcoupon/Api.html","",""],["Bitcoupon::Api::BackendRequest","","Bitcoupon/Api/BackendRequest.html","","<p>BackendRequest: This class handles API requests to backend\n"],["Bitcoupon::Api::BitcoinCall","","Bitcoupon/Api/BitcoinCall.html","","<p>Class encapsulating integration with Bitcoupon Java library\n"],["SessionsController","","SessionsController.html","","<p>SessionsController\n"],["TransactionsController","","TransactionsController.html","","<p>TransactionsController rubocop:disable Metrics/ClassLength\n"],["TransactionsHelper","","TransactionsHelper.html","","<p>TransactionsHelper\n"],["User","","User.html","","<p>User\n"],["UsersController","","UsersController.html","","<p>UsersController\n"],["command","Bitcoupon::Api::BitcoinCall","Bitcoupon/Api/BitcoinCall.html#method-c-command","()",""],["create","SessionsController","SessionsController.html#method-i-create","()",""],["create","UsersController","UsersController.html#method-i-create","()","<p>POST /users\n"],["destroy","SessionsController","SessionsController.html#method-i-destroy","()",""],["destroy","UsersController","UsersController.html#method-i-destroy","()","<p>DELETE /users/1\n"],["edit","UsersController","UsersController.html#method-i-edit","()","<p>GET /users/1/edit\n"],["generate_address","Bitcoupon::Api::BitcoinCall","Bitcoupon/Api/BitcoinCall.html#method-c-generate_address","(private_key)","<p>Name: generateAddress\n\n<pre>Arguments: String strPrivateKey</pre>\n"],["generate_create","TransactionsController","TransactionsController.html#method-i-generate_create","()","<p>rubocop:disable Metrics/MethodLength rubocop:disable\nMetrics/PerceivedComplexity rubocop:disable Metrics/CyclomaticComplexity …\n"],["generate_create_transaction","Bitcoupon::Api::BitcoinCall","Bitcoupon/Api/BitcoinCall.html#method-c-generate_create_transaction","(private_key, payload_input)","<p>2.0 Library Name: generateCreateTransaction\n\n<pre>Arguments: String strPrivateKey, String payload</pre>\n"],["generate_delete","TransactionsController","TransactionsController.html#method-i-generate_delete","()",""],["generate_delete_transaction","Bitcoupon::Api::BitcoinCall","Bitcoupon/Api/BitcoinCall.html#method-c-generate_delete_transaction","(private_key, creator_address, payload, output_history)","<p>Name: generateDeleteTransaction\n\n<pre>Arguments: String strPrivateKey, String creatorAddress,\n           String ...</pre>\n"],["generate_keys","User","User.html#method-i-generate_keys","()",""],["generate_output_history_request","Bitcoupon::Api::BitcoinCall","Bitcoupon/Api/BitcoinCall.html#method-c-generate_output_history_request","(private_key)","<p>Name: generateOutputHistoryRequest\n\n<pre>Arguments: String strPrivateKey</pre>\n"],["generate_private_key","Bitcoupon::Api::BitcoinCall","Bitcoupon/Api/BitcoinCall.html#method-c-generate_private_key","()","<p>Name: generatePrivateKey\n\n<pre>Arguments: none</pre>\n"],["generate_send","TransactionsController","TransactionsController.html#method-i-generate_send","()","<p>rubocop:enable Metrics/CyclomaticComplexity rubocop:enable\nMetrics/PerceivedComplexity\n"],["generate_send_transaction","Bitcoupon::Api::BitcoinCall","Bitcoupon/Api/BitcoinCall.html#method-c-generate_send_transaction","(private_key, creator_address, payload, receiver_address, output_history)","<p>Name: generateSendTransaction\n\n<pre>Arguments: String strPrivateKey, String creatorAddress,\n           String ...</pre>\n"],["get_coupon_owners","Bitcoupon::Api::BitcoinCall","Bitcoupon/Api/BitcoinCall.html#method-c-get_coupon_owners","(address, output_history_json)","<p>Name: getCouponOwners\n\n<pre>Arguments: String creatorAddress, String outputHistoryJson</pre>\n"],["get_coupons","Bitcoupon::Api::BitcoinCall","Bitcoupon/Api/BitcoinCall.html#method-c-get_coupons","(address, output_history_json)","<p>Name: getCoupons\n\n<pre>Arguments: String address, String outputHistoryJson</pre>\n"],["index","TransactionsController","TransactionsController.html#method-i-index","()",""],["index","UsersController","UsersController.html#method-i-index","()","<p>GET /users\n"],["new","Bitcoupon::Api::BackendRequest","Bitcoupon/Api/BackendRequest.html#method-c-new","(http_method, path)",""],["new","UsersController","UsersController.html#method-i-new","()","<p>GET /users/new\n"],["output_history_request","User","User.html#method-i-output_history_request","(private_key)",""],["password?","User","User.html#method-i-password-3F","()","<p>Returns true if user has set password\n"],["show","UsersController","UsersController.html#method-i-show","()","<p>GET /users/1\n"],["start","Bitcoupon::Api::BackendRequest","Bitcoupon/Api/BackendRequest.html#method-i-start","()",""],["translate_address","TransactionsHelper","TransactionsHelper.html#method-i-translate_address","(address)",""],["update","UsersController","UsersController.html#method-i-update","()","<p>PATCH/PUT /users/1\n"],["verify_output_history_request","Bitcoupon::Api::BitcoinCall","Bitcoupon/Api/BitcoinCall.html#method-c-verify_output_history_request","(output_history_request)","<p>Name: verifyOutputHistoryRequest\n\n<pre>Arguments: String outputHistoryRequestJson</pre>\n"],["verify_transaction","Bitcoupon::Api::BitcoinCall","Bitcoupon/Api/BitcoinCall.html#method-c-verify_transaction","(transaction_json, output_history_json)","<p>Name: verifyTransaction\n\n<pre>Arguments: String transactionJson, String outputHistoryJson</pre>\n"],["welcome","UsersController","UsersController.html#method-i-welcome","()",""],["README","","README_rdoc.html","","<p>README\n<p>This README would normally document whatever steps are necessary to get the\napplication up and …\n"]]}}
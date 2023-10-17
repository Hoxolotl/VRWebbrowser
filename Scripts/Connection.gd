extends Node

func _ready():
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request("https://en.wikipedia.org/wiki/Main_Page")
	print("OHAY")

func _on_request_completed(result, response_code, headers, body):
	#var json = JSON.parse_string(body.get_string_from_utf8())
	print("size: " ,body.size())
	print("headers: ", body.get_string_from_utf8())
	print("code: ", response_code) # Show response code.
	print("**headers:\\n", headers) # Show headers.
		
# HTTPClient demo
# This simple class can do HTTP requests; it will not block, but it needs to be polled.

#func _init():
#	var err = 0
#	var http = HTTPClient.new() # Create the Client.
#
#	err = http.connect_to_host("https://en.wikipedia.org/wiki/Main_Page", 80) # Connect to host/port.
#	assert(err == OK) # Make sure connection is OK.
#
#	# Wait until resolved and connected.
#	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
#		http.poll()
#		print("Connecting...")
#		if not OS.has_feature("web"):
#			OS.delay_msec(500)
#		else:
#			await Engine.get_main_loop().idle_frame
#
#	#assert(http.get_status() == HTTPClient.STATUS_CONNECTED) # Check if the connection was made successfully.
#
#	# Some headers
#	var headers = [
#		"User-Agent: Pirulo/1.0 (Godot)",
#		"Accept: */*"
#	]
#
#	err = http.request(HTTPClient.METHOD_GET, "/ChangeLog-5.php", headers) # Request a page from the site (this one was chunked..)
#	#assert(err == OK) # Make sure all is OK.
#
#	while http.get_status() == HTTPClient.STATUS_REQUESTING:
#		# Keep polling for as long as the request is being processed.
#		http.poll()
#		print("Requesting...")
#		if OS.has_feature("web"):
#			# Synchronous HTTP requests are not supported on the web,
#			# so wait for the next main loop iteration.
#			await Engine.get_main_loop().idle_frame
#		else:
#			OS.delay_msec(500)
#
#	#assert(http.get_status() == HTTPClient.STATUS_BODY or http.get_status() == HTTPClient.STATUS_CONNECTED) # Make sure request finished well.
#
#	print("response? ", http.has_response()) # Site might not have a response.
#
#	if http.has_response():
#		# If there is a response...
#
#		headers = http.get_response_headers_as_dictionary() # Get response headers.
#		print("code: ", http.get_response_code()) # Show response code.
#		print("**headers:\\n", headers) # Show headers.
#
#		# Getting the HTTP Body
#
#		if http.is_response_chunked():
#			# Does it use chunks?
#			print("Response is Chunked!")
#		else:
#			# Or just plain Content-Length
#			var bl = http.get_response_body_length()
#			print("Response Length: ", bl)
#
#		# This method works for both anyway
#
#		var rb = PackedByteArray() # Array that will hold the data.
#
#		while http.get_status() == HTTPClient.STATUS_BODY:
#			# While there is body left to be read
#			http.poll()
#			# Get a chunk.
#			var chunk = http.read_response_body_chunk()
#			if chunk.size() == 0:
#				if not OS.has_feature("web"):
#					# Got nothing, wait for buffers to fill a bit.
#					OS.delay_usec(1000)
#				else:
#					await Engine.get_main_loop().idle_frame
#			else:
#				rb = rb + chunk # Append to read buffer.
#		# Done!
#
#		print("bytes got: ", rb.size())
#		var text = rb.get_string_from_ascii()
#		print("Text: ", text)
#

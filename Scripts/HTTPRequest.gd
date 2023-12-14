extends Node

var linkArray = []

func _ready():
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request("https://en.wikipedia.org/wiki/Godot_(game_engine)")
	
func _on_request_completed(result, response_code, headers, body):
	
	#Convert body to human readable data
	var data = body.get_string_from_utf8()

	
	#title Element
	var titleLength = data.find("</title>") - data.find("<title>") -7
	var title = data.get_slice("<title>", 1).left(titleLength)
	$Room/Title.text = title
	
	#Room Size
	var dataSize = data.length()/240000
	$Room/Room.scale += Vector3(dataSize,dataSize,dataSize)
	
	#href element
	var url_count = data.count("</a>", 0, 0)
	print(url_count)
	var urlLength = data.find("</a") - data.find("</a>") -4
	var url = data.get_slice("<a", 1).left(urlLength)
	print(url)

	

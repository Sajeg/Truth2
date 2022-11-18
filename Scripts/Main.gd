extends Control

onready var text_display = get_node("CenterContainer/RichTextLabel")
onready var name_display = get_node("Name")

var acting_player

var tasks = Global.truth

var players = Global.players
var path_truth = "user://truth.json"
var path_dare = "user://dare.json"


func _ready():
	var file = File.new()
	if not file.file_exists(path_truth):
		download("truth")
		$downloading.visible = true
		yield(get_node("HTTPRequest"), "request_completed")
		$downloading.visible = false
		
		file.open(path_truth,File.READ)
		Global.truth = JSON.parse(file.get_as_text()).result
		file.close()
		
		file.open(path_truth,File.WRITE)
		file.store_line(to_json(Global.truth))
		file.close()
		
	elif file.file_exists(path_truth):
		file.open(path_truth,File.READ)
		Global.truth = JSON.parse(file.get_as_text()).result
		file.close()
	
	if not file.file_exists(path_dare):
		download("dare")
		$downloading.visible = true
		yield(get_node("HTTPRequest"), "request_completed")
		$downloading.visible = false

		file.open(path_dare,File.READ)
		Global.dare = parse_json(file.get_as_text())
		file.close()

		file.open(path_dare,File.WRITE)
		file.store_line(to_json(Global.dare))
		file.close()
		
	elif file.file_exists(path_dare):
		file.open(path_dare,File.READ)
		Global.dare = parse_json(file.get_as_text())
		file.close()
	

	$transition/AnimationPlayer.play("fade_right_end")
	randomize()
	
	new_player()

func new_player():
	acting_player = players[String(randi() % players.size())]
	
	if acting_player.get("name") == null:
		new_player()
	
	randomize()
	text_display.bbcode_text = "[center]" + get_task() + "[/center]"
	name_display.text = acting_player.get("name")

func get_task():
	tasks = Global.truth
	var task = check_task(acting_player.get("sex"), acting_player.get("level"))
	
	while task == null:
		task = check_task(acting_player.get("sex"), acting_player.get("level"))
	
	
	
	if "{both}" in task.get("task"):
		var player_number = randi() % players.size()
		

		
		task = task.get("task").format({"both" : players[String(player_number)].get("name")})
		
		
		return(task)
	
	if "{male}" in task.get("task"):
		var player_number = randi() % players.size()
		
		while (players[String(player_number)].get("sex") != "male"):
			player_number = randi() % players.size()
		
		task = task.get("task").format({"male" : players[String(player_number)].get("name")})
		
		
		return(task)
	
	if "{female}" in task.get("task"):
		var player_number = randi() % players.size()
		
		while (players[String(player_number)].get("sex") != "female"):
			player_number = randi() % players.size()
		
		task = task.get("task").format({"female" : players[String(player_number)].get("name")})
		
		
		return(task)
	
	return(task.get("task"))

func check_task(sex, level):
	var task_number = randi() % tasks.size()
	var valid_task = tasks[String(task_number)]
	if (valid_task.get("sex") == sex or valid_task.get("sex") == "both") and (level >= valid_task.get("level")):
		return valid_task
	else:
		return null

func download(file):
	var request = get_node("HTTPRequest")
	
	if file == "truth":
		request.set_download_file(path_truth)
	elif file == "dare":
		request.set_download_file(path_dare)
	request.request(Global.download_task_url + file +".json")


func _on_done_yes_pressed():
	acting_player.level += 1
	new_player()


func _on_done_no_pressed():
	if acting_player.level > 0:
		acting_player.level -= 1
	new_player()


func _on_people_pressed():
	$transition/AnimationPlayer.play("fade_left_start")
	yield(get_tree().create_timer(0.6),"timeout")
	if get_tree().change_scene("res://Scenes/Player.tscn") == OK:
		pass
	else:
		print("error loading Scene")


func _on_TouchScreenButton_pressed():
	$transition/AnimationPlayer.play("fade_right_start")
	yield(get_tree().create_timer(0.6),"timeout")
	if get_tree().change_scene("res://Scenes/Menu.tscn") == OK:
		pass
	else:
		print("error loading Scene")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print("Request completed ", result, ", ", response_code)

extends Control

onready var text_display = get_node("CenterContainer/RichTextLabel")
onready var name_display = get_node("Name")

var acting_player

var tasks = Global.tasks

var players = Global.players

func _ready():
	
	$transition/AnimationPlayer.play("fade_right_end")
	randomize()
	
	new_player()

func new_player():
	acting_player = players[randi() % players.size()]
	
	if acting_player.get("name") == null:
		new_player()
	
	randomize()
	text_display.bbcode_text = "[center]" + get_task() + "[/center]"
	name_display.text = acting_player.get("name")

func get_task():
	
	var task = check_task(acting_player.get("sex"), acting_player.get("level"))
	
	while task == null:
		task = check_task(acting_player.get("sex"), acting_player.get("level"))
	
	
	
	if "{both}" in task.get("task"):
		var player_number = randi() % players.size()
		
		task = task.get("task").format({"both" : players[player_number].get("name")})
		
		
		return(task)
	
	if "{male}" in task.get("task"):
		var player_number = randi() % players.size()
		
		while players[player_number].get("sex") != "male":
			player_number = randi() % players.size()
		
		task = task.get("task").format({"male" : players[player_number].get("name")})
		
		
		return(task)
	
	if "{female}" in task.get("task"):
		var player_number = randi() % players.size()
		
		while players[player_number].get("sex") != "female":
			player_number = randi() % players.size()
		
		task = task.get("task").format({"female" : players[player_number].get("name")})
		
		
		return(task)
	
	return(task.get("task"))

func check_task(sex, level):
	var task_number = randi() % tasks.size()
	var valid_task = tasks[task_number]
	if (valid_task.get("sex") == sex or valid_task.get("sex") == "both") and (level >= valid_task.get("level")):
		return valid_task
	else:
		return null


func _on_done_yes_pressed():
	acting_player.level += 1
	new_player()


func _on_done_no_pressed():
	if acting_player.level > 0:
		acting_player.level -= 1
	new_player()


func _on_people_pressed():
	$transition/AnimationPlayer.play("fade_left_start")
	yield(get_tree().create_timer(0.5),"timeout")
	if get_tree().change_scene("res://Scenes/Player.tscn") == OK:
		pass
	else:
		print("error loading Scene")

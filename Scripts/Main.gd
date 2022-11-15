extends Control

onready var text_display = get_node("CenterContainer/RichTextLabel")
onready var name_display = get_node("Name")

var acting_player

var tasks = {
	"0" : {
		"task" : "Tanze einmal im Kreis",
		"level" : 0,
		"sex" : "female"
	},
	"1" : {
		"task" : "Mache 10 Liegestützen",
		"level" : 0,
		"sex" : "male"
	},
	"2" : {
		"task" : "Erzähle eine peinliche Geschichte",
		"level" : 0,
		"sex" : "both"
	},
	"3" : {
		"task" : "Küsse {male} auf die Wange",
		"level" : 1,
		"sex" : "female"
	}
}

var players = {
	"0" : {
		"name" : "Ole",
		"sex" : "male",
		"level" : 0
	},
	"1" : {
		"name" : "Hans",
		"sex" : "male",
		"level" : 0
	},
	"2" : {
		"name" : "Lisa",
		"sex" : "female",
		"level" : 0
	},
	"3" : {
		"name" : "Frauke",
		"sex" : "female",
		"level" : 1
	}
}

func _ready():
	randomize()
	
	new_player()

func new_player():
	acting_player = players[String(randi() % players.size())]
	
	randomize()
	text_display.bbcode_text = "[center]" + get_task() + "[/center]"
	name_display.text = acting_player.get("name")

func get_task():
	
	var task = check_task(acting_player.get("sex"), acting_player.get("level"))
	
	while task == null:
		task = check_task(acting_player.get("sex"), acting_player.get("level"))
	
	
	
	if "{both}" in task.get("task"):
		var player_number = randi() % players.size()
		
		task = task.get("task").format({"both" : players[String(player_number)].get("name")})
		
		print(acting_player.get("name"))
		return(task)
	
	if "{male}" in task.get("task"):
		var player_number = randi() % players.size()
		
		while players[String(player_number)].get("sex") != "male":
			player_number = randi() % players.size()
		
		task = task.get("task").format({"male" : players[String(player_number)].get("name")})
		
		print(acting_player.get("name"))
		return(task)
	
	if "{female}" in task.get("task"):
		var player_number = randi() % players.size()
		
		while players[String(player_number)].get("sex") != "female":
			player_number = randi() % players.size()
		
		task = task.get("task").format({"female" : players[String(player_number)].get("name")})
		
		print(acting_player.get("name"))
		return(task)
	
	return(task.get("task"))

func check_task(sex, level):
	var task_number = randi() % tasks.size()
	var valid_task = tasks[String(task_number)]
	if (valid_task.get("sex") == sex or valid_task.get("sex") == "both") and (level >= valid_task.get("level")):
		return valid_task
	else:
		return null


func _on_done_yes_pressed():
	acting_player.level += 1
	print(acting_player)
	new_player()


func _on_done_no_pressed():
	if acting_player.level > 0:
		acting_player.level -= 1
	print(acting_player)
	new_player()

extends Control

onready var VBox = get_node("VBoxContainer")

func _ready():
	$transition/AnimationPlayer.play("fade_left_end")
	player_list()


func player_list():
	for n in VBox.get_children():
		VBox.remove_child(n)
		n.queue_free()
	for i in Global.players.size():
		
		if Global.players[i].get("name") != null:
			var label = Label.new()
			
			VBox.add_child(label)
			label.name = Global.players[i].get("name")
			label.text = Global.players[i].get("name")
			label.add_font_override("font", load("res://Assets/Fonts/standart.tres"))
			label.align = label.ALIGN_CENTER
			label.add_color_override("font_color", Color.black)
			
			var button = TouchScreenButton.new()
			
			label.add_child(button)
			button.normal = load("res://Assets/nothing.png")
			button.scale.x = 5
			button.scale.y = 0.8
			button.connect("pressed", self, "delete_player", [i])

func _on_back_pressed():
	$transition/AnimationPlayer.play("fade_right_start")
	yield(get_tree().create_timer(0.6),"timeout")
	if get_tree().change_scene("res://Scenes/Main.tscn") == OK:
		pass
	else:
		print("Error changing Scene")

func delete_player(player):
	if Global.players.size() == 1:
		return
	
	Global.players[player] = Global.players[Global.players.size() -1]
	Global.players.erase(Global.players.size() -1)
	player_list()
	print("delted player")


func _on_AddButton_pressed():
	$transition/AnimationPlayer.play("fade_left_start")
	yield(get_tree().create_timer(0.6),"timeout")
	if get_tree().change_scene("res://Scenes/AddPlayer.tscn") == OK:
		pass
	else:
		print("Error changing scene")

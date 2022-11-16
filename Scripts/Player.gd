extends Control

onready var VBox = get_node("VBoxContainer")

func _ready():
	$transition/AnimationPlayer.play("fade_left_end")
	
	for i in Global.players.size():
		
		if Global.players[String(i)].get("name") != null:
			var label = Label.new()
			
			VBox.add_child(label)
			label.name = Global.players[String(i)].get("name")
			label.text = Global.players[String(i)].get("name")
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
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scenes/Main.tscn")

func delete_player(player):
	
	get_node("VBoxContainer/" + Global.players[String(player)].get("name")).queue_free()
	Global.players[String(player)].name = null
	print("delted player")

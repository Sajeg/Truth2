extends Control



func _ready():
	$transition/AnimationPlayer.play("fade_left_end")
	
	for i in Global.players.size():
		
		var label = Label.new()
		
		$VBoxContainer.add_child(label)
		label.text = Global.players[String(i)].get("name")
		label.add_font_override("font", load("res://Assets/Fonts/standart.tres"))
		label.align = label.ALIGN_CENTER
		label.add_color_override("font_color", Color.black)


func _on_back_pressed():
	$transition/AnimationPlayer.play("fade_right_start")
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scenes/Main.tscn")

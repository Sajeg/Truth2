extends Control

func _ready():
	$transition/AnimationPlayer.play("fade_left_end")


func _on_TouchScreenButton_pressed():
	$transition/AnimationPlayer.play("fade_right_start")
	yield(get_tree().create_timer(0.6),"timeout")
	if get_tree().change_scene("res://Scenes/Main.tscn") == OK:
		pass
	else:
		print("Error changing Scene")

func _on_ExitButton_pressed():
	get_tree().quit()


func _on_CreditsButton_pressed():
	$transition/AnimationPlayer.play("fade_right_start")
	yield(get_tree().create_timer(0.6),"timeout")

	$Name.text = "Credits"

	$VBoxContainer/Import.visible = false
	$VBoxContainer/Credits.visible = false
	$VBoxContainer/Exit.visible = false

	$VBoxContainer/Credits1.visible = true
	$VBoxContainer/Credits2.visible = true
	$VBoxContainer/Credits3.visible = true
	$VBoxContainer/Credits4.visible = true
	$VBoxContainer/Credits5.visible = true
	$VBoxContainer/Credits6.visible = true

	
	$transition/AnimationPlayer.play("fade_left_end")


func _on_ImportButton_pressed():
	$transition/AnimationPlayer.play("fade_right_start")
	yield(get_tree().create_timer(0.6),"timeout")
	if get_tree().change_scene("res://Scenes/Import.tscn") == OK:
		pass
	else:
		print("Error changing Scene")

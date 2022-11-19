extends Control

var path_truth = "user://truth.json"
var path_dare = "user://dare.json"

var import

func _ready():
    $transition/AnimationPlayer.play("fade_left_end")

func _on_UpdateButton_pressed():
    var dir = Directory.new()
    dir.remove(path_truth)
    dir.remove(path_dare)
    
    $transition/AnimationPlayer.play("fade_right_start")
    yield(get_tree().create_timer(0.6), "timeout")
    if get_tree().change_scene("res://Scenes/Main.tscn") == OK:
        pass
    else:
        print("Error changing Scene")



func _on_TouchScreenButton_pressed():
    $transition/AnimationPlayer.play("fade_right_start")
    yield(get_tree().create_timer(0.6),"timeout")
    if get_tree().change_scene("res://Scenes/Menu.tscn") == OK:
        pass
    else:
        print("error loading Scene")




func _on_DareButton_pressed():
    if OS.request_permissions() == true: 
        $FileDialog.set_current_path(OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS))
        $FileDialog.popup()
        import = "dare"

func _on_TruthButton_pressed():
    if OS.request_permissions() == true:
        $FileDialog.set_current_path(OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS))
        $FileDialog.popup()
        import = "truth"

func _on_FileDialog_file_selected(path:String):
    print(path)
    var file = File.new()
    if import == "dare":
        file.open(path,File.READ)
        Global.dare = parse_json(file.get_as_text())
        file.close()

        file.open(path_dare,File.WRITE)
        file.store_line(to_json(Global.dare))
        file.close()
    elif import == "truth":
        file.open(path,File.READ)
        Global.truth = parse_json(file.get_as_text())
        file.close()

        file.open(path_truth,File.WRITE)
        file.store_line(to_json(Global.dare))
        file.close()
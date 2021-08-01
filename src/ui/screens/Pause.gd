extends Control

var last_scene_path
func _input(event):
	if event.is_action_pressed("pause"):
		last_scene_path = get_tree().get_current_scene().get_name()
		global.last_scene_path = "res://src/levels/" + last_scene_path + ".tscn"
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		


func _on_RestartButton_Pause_button_up():
	get_tree().paused = false
	visible = false
	get_tree().change_scene(global.last_scene_path)
	


func _on_MainMenuBitton_Pause_button_up():
	get_tree().paused = false
	visible = false
	get_tree().change_scene("res://src/ui/screens/MainScreen.tscn")
	

func _on_QuitButton_Pause_button_up():
	get_tree().paused = false
	visible = false
	get_tree().quit

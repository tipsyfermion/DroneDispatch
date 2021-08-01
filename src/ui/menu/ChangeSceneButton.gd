tool
extends Button

export(String, FILE) var next_scene_path: = ""
#func _ready():
	#global.last_scene_path = "none"

func _on_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene(next_scene_path)
	prints("button")

func _on_Restart_button_up():
	prints(global.last_scene_path)
	get_tree().change_scene(global.last_scene_path)
	
func _on_Main_button_up():
	get_tree().change_scene(next_scene_path)



func _get_configuration_warning() -> String:
	return "next_scene_path msut be set" if next_scene_path=="" else ""


func _on_RestartButton_button_up():
	prints(global.last_scene_path)
	get_tree().change_scene(global.last_scene_path)


func _on_MainMenuBitton_button_up():
	get_tree().change_scene(next_scene_path)


func _on_BackButton_button_up():
	get_tree().change_scene(global.last_scene_path)


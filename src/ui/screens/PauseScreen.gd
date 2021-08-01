extends CanvasLayer

func _input(event):
	if event.is_action_pressed("pause"):
		$Pause.visible = !$Pause.visible
		get_tree().paused = !get_tree().paused
		
func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible

func _on_Restart_Pause_pressed():
	get_tree().paused = false
	set_visible(false)
	get_tree().change_scene(global.last_scene_path)
	pass # Replace with function body.

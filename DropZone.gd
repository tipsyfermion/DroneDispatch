extends Area2D

var hasBox = false

func _on_DropZone_body_entered(body: Node) -> void:
	if body.has_method("isBox"):
		hasBox = true
	
	pass # Replace with function body.


func _on_DropZone_body_exited(body: Node) -> void:
	hasBox = false
	pass # Replace with function body.

extends CollisionShape2D

var object

func _on_Grabber_body_shape_entered(body_id: int, body: Node, body_shape: int, local_shape: int) -> void:
	object = body

func _on_Grabber_body_shape_exited(body_id: int, body: Node, body_shape: int, local_shape: int) -> void:
	object = null


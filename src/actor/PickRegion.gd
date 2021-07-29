extends CollisionShape2D

var object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Grabber_body_shape_entered(body_id: int, body: Node, body_shape: int, local_shape: int) -> void:
	object = body

func _on_Grabber_body_shape_exited(body_id: int, body: Node, body_shape: int, local_shape: int) -> void:
	object = null


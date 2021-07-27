extends PinJoint2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var isClosed: = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_claw"):
		
			isClosed = false
	

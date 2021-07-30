extends Actor

export var motorStrength: = 100
export var weight = 100

var isOpen = true

func _physics_process(delta: float) -> void:
	
	acceleration = get_acceleration()
	velocity = update_velocity()
	rotation = update_rotation() 

	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, true)
	return

func get_acceleration() -> Vector2:
	var acc: = Vector2.ZERO
	
	# Gravity Inputs
	acc.y += g_modifier * weight
	
	# Motor Inputs
	acc.x += motorStrength*(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	acc.y += motorStrength*(Input.get_action_strength("move_down") - Input.get_action_strength("move_up")*2)
	
	# Wind Inputs
	# TODO
	return acc

func update_velocity() -> Vector2:
	var delta = get_physics_process_delta_time()
	velocity.x += acceleration.x*delta - velocity.x*drag
	velocity.y += acceleration.y*delta - velocity.y*drag
	return velocity

func update_rotation() -> float:
	return velocity.x/3000.0


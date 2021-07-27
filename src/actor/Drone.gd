extends Actor

export var motorStrength: = 100

func _physics_process(delta: float) -> void:
	
	acceleration = get_acceleration()
	velocity = update_velocity()
	rotation = update_rotation() 
	#(linear_velocity: Vector2, up_direction: Vector2 = Vector2( 0, 0 ), stop_on_slope: bool = false, 
	#max_slides: int = 4, floor_max_angle: float = 0.785398, infinite_inertia: bool = true)

	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, true)
	return

func get_acceleration() -> Vector2:
	var acc: = Vector2.ZERO
	
	# Gravity Inputs
	acc.y += gravity * g_modifier 
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

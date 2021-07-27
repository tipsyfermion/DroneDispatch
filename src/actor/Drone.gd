extends Actor

export var motorStrength: = 100
var isOpen = false

func _physics_process(delta: float) -> void:
	
	acceleration = get_acceleration()
	velocity = update_velocity()
	rotation = update_rotation() 
	#(linear_velocity: Vector2, up_direction: Vector2 = Vector2( 0, 0 ), stop_on_slope: bool = false, 
	#max_slides: int = 4, floor_max_angle: float = 0.785398, infinite_inertia: bool = true)
	claw_action()

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

func claw_action() -> void:
	if Input.is_action_just_pressed("toggle_claw"):
		
		if isOpen:
			isOpen = false
			var pin_1 = PinJoint2D.new()
			var pin_2 = PinJoint2D.new()
			pin_1.set_name("A1")
			pin_2.set_name("A2")
			#add_child(pin_1)
			#add_child(pin_2)
			pin_1.node_a = "Chain/Node2D/Hook"
			pin_2.node_a = "Chain/Node2D/Hook"
			pin_1.node_b = "Chain/Node2D/Box"
			pin_2.node_b = "Chain/Node2D/Box"
			add_child_below_node(get_node("Chain/Node2D/Hook"),pin_1,true)
			add_child_below_node(get_node("Chain/Node2D/Hook"),pin_2,true)
		else :
			isOpen = true
			var pin_1 = get_node("Chain/Node2D/Hook/A1")
			var pin_2 = get_node("Chain/Node2D/Hook/A2")
			#remove_child(pin_1)
			#remove_child(pin_2)
			get_node("Chain/Node2D/Hook/").remove_child(pin_1)
			get_node("Chain/Node2D/Hook/").remove_child(pin_2)
			pin_1.queue_free()
			pin_2.queue_free()
			var box = get_node("Chain/Node2D/Box")
			remove_child(box)
			add_child_below_node(get_node(".."),box,true)

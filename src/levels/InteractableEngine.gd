extends Node2D

var drone: KinematicBody2D
var grabber: RigidBody2D
var pickRegion: CollisionShape2D
var hook: Node2D
var pocL: Position2D
var pocR: Position2D
var pinL: PinJoint2D
var pinR: PinJoint2D
var object: RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drone = get_node("Drone")
	hook = drone.get_node("Chain/Hook")
	grabber = hook.get_node("Grabber")
	pickRegion = grabber.get_node("PickRegion")
	pocL = grabber.get_node("POCLeft")
	pocR = grabber.get_node("POCRight")
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	claw_action()
	
func claw_action() -> void:
	if Input.is_action_just_pressed("toggle_claw"):
		if drone.isOpen:
			if pickRegion.object == null:
				return
			if !pickRegion.object.is_class("RigidBody2D"):
				return
			object = pickRegion.object
			drone.isOpen = false
			#TODO: Detect if object is present
			var pos = object.global_position
			remove_child(object)
			hook.add_child(object)
			object.global_position = pos
			
			#object.rotation = 0
			#object.angular_velocity = 0
			#object.linear_velocity = Vector2(0,0)
			pinL = PinJoint2D.new()
			pinR = PinJoint2D.new()
			pinL.set_name("PinL")
			pinR.set_name("PinR")
			pinL.position = pocL.position
			pinR.position = pocR.position
			pinL.node_a = grabber.get_path()
			pinR.node_a = grabber.get_path()
			pinL.node_b = object.get_path()				#UPDATE LATER
			pinR.node_b = object.get_path() 			#UPDATE LATER
			grabber.add_child(pinL, true)
			grabber.add_child(pinR, true)
			#object.mode = RigidBody2D.MODE_STATIC
		else :
			drone.isOpen = true
			var pos = object.global_position
			hook.remove_child(object)
			object.mode = RigidBody2D.MODE_RIGID
			add_child(object)
			object.global_position = pos
			pinL.queue_free()
			pinR.queue_free()

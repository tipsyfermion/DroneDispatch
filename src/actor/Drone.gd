extends Actor

export var motorStrength: = 100
export var weight = 100
export var maxHP = 1000;
export var maxBattery = 500;
export var dischargeRate = 0.05
export var totalPackageCount = 4
export var Camera_left = 0
export var Camera_right = 1000000
export var Camera_top = 10000000
export var Camera_bottom = 100000

export var last_scene_path: String
var hp: float 
var battery: float
var count: int

var isOpen = true
var beingDamaged = false
var damageCooldown = 0

var bars: Control
var packages: Control
var dropZone: Node2D

func set_initials_values_bars():
	bars = get_node("../../InterfaceLayer/Interface/bars")
	bars.get_node("HPBar/TextureProgress").set_max(hp)
	bars.get_node("HPBar/Counter/Label").text = ("%0.1f"%hp)
	bars.get_node("BatteryBar/TextureProgress").set_max(battery)
	bars.get_node("BatteryBar/Counter/Label").text = ("%d" % battery)	
func set_intial_packages_count():
	get_node("../../InterfaceLayer/Interface/counter/PackageCounter/Label").text = ("%d" % totalPackageCount)
func update_values_bars():
	bars = get_node("../../InterfaceLayer/Interface/bars")
	bars.get_node("HPBar/TextureProgress").value = hp
	bars.get_node("HPBar/Counter/Label").text = ("%0.1f"%hp)
	bars.get_node("BatteryBar/TextureProgress").value = battery
	if int(battery)%50==0:
		bars.get_node("BatteryBar/Counter/Label").text = ("%d" % battery)
func update_packages_count(i):
	packages = get_node("../../InterfaceLayer/Interface/counter/PackageCounter/Label")
	count = totalPackageCount - i
	packages.text = ("%d" % count)
	
func _ready():
	hp = maxHP
	battery = maxBattery
	set_initials_values_bars()
	set_intial_packages_count()
	dropZone = get_node("../../DropZone")
	var cam = get_node("Camera")
	cam.limit_left = Camera_left
	cam.limit_right = Camera_right
	cam.limit_bottom = Camera_bottom
	cam.limit_top = Camera_top
	
func _restart():
	get_tree().reload_current_scene()
	
func _physics_process(delta: float) -> void:	
	if Input.is_action_just_pressed("restart"):
		_restart()
	#if Input.is_action_just_pressed("pause"):
#		last_scene_path = get_tree().get_current_scene().get_name()
	#	get_tree().change_scene("res://src/ui/screens/SettingsScreen.tscn")
	
	acceleration = get_acceleration()
	velocity = update_velocity()
	rotation = update_rotation() 	
	battery -= 0.1 +  dischargeRate * velocity.length()
	
	if damageCooldown > 0:
		damageCooldown -= delta
	
	if battery<0:
		last_scene_path = get_tree().get_current_scene().get_name()
		prints("B0: " + last_scene_path)
		global.last_scene_path = "res://src/levels/" + last_scene_path + ".tscn"
		prints(global.last_scene_path)
		get_tree().change_scene("res://src/ui/screens/_B0Screen.tscn")
	
	if hp<0:
		last_scene_path = get_tree().get_current_scene().get_name()
		prints("HP0" + last_scene_path)
		global.last_scene_path = "res://src/levels/" + last_scene_path + ".tscn"
		prints("HP0:" + global.last_scene_path)
		get_tree().change_scene("res://src/ui/screens/_HP0Screen.tscn")
	
	var i = dropZone.item_count
	update_packages_count(i)
	if i == totalPackageCount:
		get_tree().change_scene("res://src/ui/screens/LevelFinish.tscn")
	update_values_bars()

	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)
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

func _on_DamageArea_body_entered(body: Node) -> void:
	if damageCooldown <= 0:
		hp -= 1* velocity.length()
		damageCooldown = 1

func _on_DamageArea_body_exited(body: Node) -> void:
	beingDamaged = false

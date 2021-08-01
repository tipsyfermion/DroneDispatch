extends Node2D

var item_count = 0

# Called when the node enters the scene tree for the first time.


func _physics_process(delta: float) -> void:
	item_count = 0
	for child in get_children():
		item_count += int(child.hasBox)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

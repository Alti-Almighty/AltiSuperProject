extends Node2D
signal health_changed

slave func setPosition(pos):
	position = pos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updateNetworkPosition(pos):
	if is_network_master():
		rpc_unreliable("setPosition", pos)
	

func emit_health_changed():
	emit_signal("health_changed")

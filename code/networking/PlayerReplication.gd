extends Node2D
class_name Player

signal health_changed

puppet func setPosition(pos):
	position = pos

puppet func setRotation(rot):
	rotation = rot

# Called when the node enters the scene tree for the first time.
func _ready():
	if not is_network_master():
		$RageTexture.hide()

func set_network_name(new_name):
	$Name.text = new_name

func set_rage(show):
	if not is_network_master():
		return
	if show:
		$RageTexture.show()
	else:
		$RageTexture.hide()

func updateNetworkPosition(pos):
	if is_network_master():
		rpc_unreliable("setPosition", pos)

func updateNetworkRotation(rot):
	if is_network_master():
		rpc_unreliable("setRotation", rot)

func emit_health_changed():
	emit_signal("health_changed")

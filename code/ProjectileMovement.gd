extends Node2D

var speed = 650
var damage = 30
var spawning_player = null

func _ready():
	pass # Replace with function body.

puppet func updatePosition(pos):
	position = pos

func _process(delta):
	position += transform.x * speed * delta
	if is_network_master():
		rpc_unreliable("updatePosition", position)

func _on_overlap(other):
	if other == spawning_player:
		return
	if other.get_parent() is Player:
		get_parent().remove_child(self)
		other.deal_damage(damage)
	

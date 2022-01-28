extends Node2D
var health = 100
var covid = false
const MAX_HEALTH = 100

slave func setPosition(pos):
	position = pos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updateNetworkPosition(pos):
	if is_network_master():
		rpc_unreliable("setPosition", pos)


func _on_OmicronCollectible_omicron_picked_up():
	make_ill()


func _on_SyringeCollectible_syringe_picked_up(health_change):
	add_health(health_change)
	cure()


func make_ill():
	print("ill!")
	covid = true
	
func cure():
	print("cure!")
	covid = false

func add_health(hp):
	health = max(MAX_HEALTH, health+hp)
	print("hp up!")
	
func remove_health(hp):
	health = max(0, health-hp)
	if health == 0:
		die()
		
func die():
	pass

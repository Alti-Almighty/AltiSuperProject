extends Node


var player_ids = []
var players = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func spawn_players():
	# Spawn host
	var host = preload("res://Player.tscn").instance()
	var hostId = get_tree().get_network_unique_id()
	host.set_name(str(hostId))
	host.set_network_master(hostId)
	get_tree().get_root().get_node("Game").add_child(host)
	print("Spawned host " + str(hostId))

	# Spawn players
	for playerId in player_ids:
		var newPlayer = preload("res://Player.tscn").instance()
		newPlayer.set_name(str(playerId))
		newPlayer.set_network_master(playerId)
		get_tree().get_root().get_node("Game").add_child(newPlayer)
		print("Spawned player" + str(playerId))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

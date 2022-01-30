extends Node


var player_ids = []
var players = []
var is_multi = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func spawn_players():
	if get_tree().get_root().get_node("Game") == null:
		return

	is_multi = true

	# Spawn players
	for playerId in player_ids:
		var newPlayer = preload("res://Player.tscn").instance()
		newPlayer.set_name(str(playerId))
		newPlayer.set_network_master(playerId)
		newPlayer.position = Vector2(250, 250)
		get_tree().get_root().get_node("Game").add_child(newPlayer)
		print("Spawned player" + str(playerId))
		players.push_back(newPlayer)
	
	#Spawn this player
	var host = preload("res://Player.tscn").instance()
	var hostId = get_tree().get_network_unique_id()
	host.set_name(str(hostId))
	host.set_network_master(hostId)
	get_tree().get_root().get_node("Game").add_child(host)
	players.push_back(host)
	print("Spawned host " + str(hostId))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

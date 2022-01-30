extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")


func create_game_map():
	var game = preload("res://MainScene.tscn").instance()
	game.set_name("Game")
	get_tree().get_root().add_child(game)

func _player_connected(id):
	print("Player " + str(id) + " connected to server!")
	Session.player_ids.push_back(id)
	create_game_map()

func hide_ui():
	$SinglePlayer.hide()
	$HostLobbyBtn.hide()
	$JoinLobbyBtn.hide()
	$JoinLobbyIp.hide()

func _on_single_player_pressed():
	_on_host_lobby_pressed()
	hide_ui()
	create_game_map()

func _on_host_lobby_pressed():
	print("Hosting lobby")
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(4242)
	if res != OK:
		print("Error creating server")
		return

	hide_ui()
	get_tree().set_network_peer(host)

func _on_join_lobby_pressed():
	print("Joining lobby")
	var host = NetworkedMultiplayerENet.new()
	var ip = $JoinLobbyIp.get_line(0)
	host.create_client(ip, 4242)
	get_tree().set_network_peer(host)
	hide_ui()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Node2D

const OmiPowerUp = preload("res://prefabs/collectibles/OmicronCollectible.tscn")
const SyrPowerUp = preload("res://prefabs/collectibles/SyringeCollectible.tscn")
const MaskPowerUp = preload("res://prefabs/collectibles/MaskCollectible.tscn")

func _ready():
	Session.spawn_players()
	#$RageTimer.set_speed($RageTimer.SPEED_BLAZING)
	#$RageTimer.start_timer()
	$EffectsController.restart()
	_play_music()
	
	powerup_random_spawn(OmiPowerUp, 10)
	powerup_random_spawn(SyrPowerUp, 5)
	powerup_random_spawn(MaskPowerUp, 15)


func _on_RageTimer_timer_kaboom():
	$EffectsController.kaboom()
	$AnimationNode/Playa.die()

func _play_music():
	SoundMixer.playChill()

func powerup_random_spawn(res: Resource, amount : int):
	var rng = RandomNumberGenerator.new()
	for i in range(amount):
		var ins = res.instance()
		rng.randomize()
		var rand_x = rng.randi_range(32, $TileMap.get_used_rect().size.x * $TileMap.cell_size.x * $TileMap.scale.x )
		var rand_y = rng.randi_range(32, $TileMap.get_used_rect().size.y * $TileMap.cell_size.y * $TileMap.scale.y )
		ins.transform.origin = Vector2(rand_x, rand_y)
		add_child(ins)

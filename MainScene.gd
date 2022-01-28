extends Node2D

const OmiPowerUp = preload("res://prefabs/collectibles/OmicronCollectible.tscn")
const SyrPowerUp = preload("res://prefabs/collectibles/SyringeCollectible.tscn")

func _ready():
	Session.spawn_players()
	#$RageTimer.set_speed($RageTimer.SPEED_BLAZING)
	#$RageTimer.start_timer()
	$EffectsController.restart()
	_play_music()
	
	powerup_random_spawn(OmiPowerUp)
	powerup_random_spawn(SyrPowerUp)


func _on_RageTimer_timer_kaboom():
	$EffectsController.kaboom()
	$AnimationNode/Playa.die()

func _play_music():
	SoundMixer.playChill()

func powerup_random_spawn(res: Resource):
	var ins = res.instance()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var rand_x = rng.randi_range(0, get_viewport_rect().size.x)
	var rand_y = rng.randi_range(0, get_viewport_rect().size.y)
	ins.transform.origin = Vector2(rand_x, rand_y)
	add_child(ins)

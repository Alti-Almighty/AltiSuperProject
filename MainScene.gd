extends Node2D

func _ready():
	Session.spawn_players()
	#$RageTimer.set_speed($RageTimer.SPEED_BLAZING)
	#$RageTimer.start_timer()	
	$EffectsController.restart()
	_play_music()


func _on_RageTimer_timer_kaboom():
	$EffectsController.kaboom()
	$AnimationNode/Playa.die()

func _play_music():
	SoundMixer.playChill()

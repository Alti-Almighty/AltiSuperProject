extends Node2D

func _ready():
	$RageTimer.set_speed($RageTimer.SPEED_BLAZING)
	$RageTimer.start_timer()	


func _on_RageTimer_timer_kaboom():
	print("kaboom !")

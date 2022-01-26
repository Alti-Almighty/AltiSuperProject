extends Node2D

###################################################
# Interface: 
# set_speed() - sets speed of the timer,  one of 4 - {SPEED_SLOW, SPEED_NEUTRAL, SPEED_FAST, SPEED_BLAZING}
# start_timer() - resets rage to max_rage and stars the timer based on speed
# set_rage(rage) - sets current rage
# @signal timer_started - you can connect to this event when timer starts
# @signal timer_kaboom - you can connect to this event when timer reaches 0
####################################################

var xtraverse = 0
var rotspeed = 2
var rotamt = 5

var scaletraverse = 0
var scalespeed = 0.8
var scaleamt = 0.4

enum {SPEED_SLOW, SPEED_NEUTRAL, SPEED_FAST, SPEED_BLAZING}

var _current_timer = null
var _is_running = false
var _current_rage = 0

export(int) var max_rage = 100
export(float) var speed_slow = 1.5
export(float) var speed_neutral = 1
export(float) var speed_fast = 0.2
export(float) var speed_blazing = 0.05

var _timer_speed = speed_neutral

signal timer_started
signal timer_kaboom

func _ready():
	_current_timer = Timer.new()
	add_child(_current_timer)
	_current_timer.connect("timeout", self, "_on_Timer_tick")

func set_speed(speed):
	# yeah yeah...
	if speed == SPEED_SLOW:
		_timer_speed = speed_slow
	elif speed == SPEED_NEUTRAL:
		_timer_speed = speed_neutral
	elif speed == SPEED_FAST:
		_timer_speed= speed_fast
	elif speed == SPEED_BLAZING:
		_timer_speed= speed_blazing		
	
func set_rage(rage):	
	_current_rage = min(rage, max_rage)
	$TimerUI.set_rage(_current_rage)

func start_timer():
	# reset timer	
	_is_running = true
	set_rage(max_rage)

	print(_timer_speed)

	_current_timer.set_wait_time(_timer_speed)	
	_current_timer.set_one_shot(false)
	_current_timer.start()
	
	emit_signal("timer_started")

func _on_Timer_tick():
	#naive	
	_current_rage -= 1
	$TimerUI.set_rage(_current_rage)	
	
	if _current_rage == 0:
		emit_signal("timer_kaboom")
		_current_timer.stop()

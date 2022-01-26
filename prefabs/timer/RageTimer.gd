extends Node2D

var xtraverse = 0
var rotspeed = 2
var rotamt = 5

var scaletraverse = 0
var scalespeed = 0.8
var scaleamt = 0.4

var _current_timer = null
var _is_running = false
var _current_rage = 0
export(int) var max_rage = 100

signal timer_started
signal timer_kaboom

func _ready():
	_current_timer = Timer.new()
	add_child(_current_timer)
	_current_timer.connect("timeout", self, "_on_Timer_tick")

func set_rage(rage):	
	_current_rage = min(rage, max_rage)
	$TimerUI.set_rage(_current_rage)

func startTimer():
	# reset timer	
	_is_running = true
	set_rage(max_rage)
	
	_current_timer.set_wait_time(1.0)
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

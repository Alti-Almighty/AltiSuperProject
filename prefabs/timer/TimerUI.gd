extends Control

var xtraverse = 0
var rotspeed = 2
var rotamt = 5

var scaletraverse = 0
var scalespeed = 0.8
var scaleamt = 0.2


func set_rage(hp):	
	$ProgressBar.value = hp

func _physics_process(delta):	
	rect_rotation = sin(xtraverse) * rotamt
	rect_scale = Vector2(abs(cos(scaletraverse)) * scaleamt, abs(cos(scaletraverse) * scaleamt) )
	
	rect_scale.x += 1;
	rect_scale.y += 1;
	
	xtraverse += rotspeed * delta
	scaletraverse += scalespeed * delta

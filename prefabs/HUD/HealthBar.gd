extends Control

var xtraverse = 0
var rotspeed = 3.2
var rotamt = 1.5

var scaletraverse = 0
var scalespeed = 1
var scaleamt = 0.2


func _physics_process(delta):	
	rect_rotation = sin(xtraverse) * rotamt
	rect_scale = Vector2(abs(cos(scaletraverse)) * scaleamt, abs(cos(scaletraverse) * scaleamt) )
	
	rect_scale.x += 1;
	rect_scale.y += 1;
	
	xtraverse += rotspeed * delta
	scaletraverse += scalespeed * delta


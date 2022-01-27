extends Node2D

var speed = 650

func _ready():
	pass # Replace with function body.

func _process(delta):
	position += transform.x * speed * delta

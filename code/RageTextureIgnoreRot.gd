extends TextureRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera_position = $"../KinematicBody2D".position
	camera_position.x -= get_viewport_rect().size.x/2
	camera_position.y -= get_viewport_rect().size.y/2
	self.set_position(camera_position)
	var viewport_size = get_viewport().size
	self.set_size( Vector2(viewport_size.x, viewport_size.y) )

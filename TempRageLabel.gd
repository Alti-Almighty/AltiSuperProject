extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Node2D_timeout():
	print(get_parent().name)
	if self.is_visible():
		self.hide()
		for player in Session.players:
			player.set_rage(false)
	else:
		self.show()
		for player in Session.players:
			player.set_rage(true)
	var a = get_node("../Timer").start(3)

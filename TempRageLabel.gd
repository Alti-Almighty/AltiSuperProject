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
	if self.is_visible():
		self.hide()
		get_node("../../Player/RageTexture").hide()
	else:
		self.show()
		get_node("../../Player/RageTexture").show()
	var a = get_node("../Timer").start(3)

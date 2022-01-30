extends CanvasLayer

func _ready():
	var player = get_parent().get_parent()
	set_willpower(player.get_node("PlayerKinematicBody2D").MAX_HEALTH)


func set_willpower(val):
	$HBoxContainer2/HealthBar/NinePatchRect/ProgressBar.value = val
	

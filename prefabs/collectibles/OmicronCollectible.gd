extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
export(int) var health = 10
signal omicron_picked_up
func _on_body_entered(body):
	emit_signal("omicron_picked_up")
	anim_player.play("fade_out")

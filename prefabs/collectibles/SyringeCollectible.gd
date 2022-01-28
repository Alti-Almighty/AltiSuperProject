extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
export(int) var health = 10
signal syringe_picked_up(health_change)

func _on_body_entered(body):
	emit_signal("syringe_picked_up", health)
	anim_player.play("fade_out")

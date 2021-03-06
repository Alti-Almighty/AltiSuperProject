extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
export(int) var health = 10
signal syringe_picked_up(health_change)

func _on_body_entered(body):
	if(body.name == 'PlayerKinematicBody2D'):
		body.syringe_picked_up()
		anim_player.play("fade_out")

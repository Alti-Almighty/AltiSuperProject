extends KinematicBody2D

export(int) var speed = 80
onready var state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	var motion = Vector2() 
	
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1
	if Input.is_action_pressed("ui_down"):
		motion.y += 1

	motion = motion.normalized()
	
	if motion == Vector2.ZERO:
		state_machine.travel("Idle")
	else:
		state_machine.travel("Walkin")
		$AnimationTree["parameters/Walkin/blend_position"] = motion

	motion = move_and_slide(motion * speed)
	

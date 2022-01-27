extends KinematicBody2D

export (int) var speed = 200
export (int) var boost = 300

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("Boost"):   #we can also use booster logic here
		velocity = velocity.normalized() * (speed + boost) 
	else:
		velocity = velocity.normalized() * speed 

func _physics_process(delta):
	# Process input only if we are network master of this player

	if not Session.is_multi or is_network_master():
		get_input()
		velocity = move_and_slide(velocity)
		get_parent().updateNetworkPosition(position)

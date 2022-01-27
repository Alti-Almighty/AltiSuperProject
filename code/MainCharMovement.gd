extends KinematicBody2D

const Projectile = preload("res://Projectile.tscn")
export (int) var speed = 200
export (int) var boost = 300

var velocity = Vector2()
var gunpoint = load("res://assets/textures/player/gunpoint.png")

func _ready():
	Input.set_custom_mouse_cursor(gunpoint)

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
	if Input.is_action_just_pressed("Shoot"):
		shoot()

func _physics_process(delta):
	# Process input only if we are network master of this player

	if not Session.is_multi or is_network_master():
		get_input()
		velocity = move_and_slide(velocity)
		get_parent().updateNetworkPosition(position)
		
		var look_at_vec2 = get_viewport().get_mouse_position()
		look_at(look_at_vec2)

func _input(event):
	if event is InputEventMouseButton:   #position we need for projectile to travel
		pass
		#print("Mouse Click/Unclick at: ", event.position)
	elif event is InputEventMouseMotion:    #position we need for ratating character towards aim
		pass
		#print("Mouse Motion at: ", get_viewport().get_mouse_position() )

func shoot():
	var projectile_instance = Projectile.instance()
	owner.add_child(projectile_instance)
	var projectile_spawn_position = self.transform
	projectile_instance.transform = projectile_spawn_position

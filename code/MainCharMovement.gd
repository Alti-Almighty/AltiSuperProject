extends KinematicBody2D
const MAX_HEALTH = 100
const NORMAL_SPEED = 200
const COVID_SPEED = NORMAL_SPEED*0.75
const Projectile = preload("res://Projectile.tscn")
export (int) var speed = 200
export (int) var boost = 300
var health = MAX_HEALTH
var covid = false

onready var _mixers = [
	get_parent().get_node("Sound/PlayerMixer"),
	get_parent().get_node("Sound/ShootingMixer")
]
enum { MIXER_0, MIXER_1 }

var velocity = Vector2()
var gunpoint = load("res://assets/textures/player/gunpoint.png")
var _boosted = false

func _ready():
	Input.set_custom_mouse_cursor(gunpoint, Input.CURSOR_ARROW, Vector2(26, 26))

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		if Input.is_action_just_pressed("right"):
			_play_sound(SoundMixer.PLAYER_WALK if !_boosted else SoundMixer.PLAYER_RUN, MIXER_0)			
		velocity.x += 1
	if Input.is_action_pressed("left"):
		if Input.is_action_just_pressed("left"):
			_play_sound(SoundMixer.PLAYER_WALK if !_boosted else SoundMixer.PLAYER_RUN, MIXER_0)			
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		if Input.is_action_just_pressed("down"):
			_play_sound(SoundMixer.PLAYER_WALK if !_boosted else SoundMixer.PLAYER_RUN, MIXER_0)			
		velocity.y += 1
	if Input.is_action_pressed("up"):
		if Input.is_action_just_pressed("up"):
			_play_sound(SoundMixer.PLAYER_WALK if !_boosted else SoundMixer.PLAYER_RUN, MIXER_0)			
		velocity.y -= 1
	if Input.is_action_pressed("Boost"):   #we can also use booster logic here
		_boosted = true
		velocity = velocity.normalized() * (speed + boost) 
	else:
		_boosted = false
		velocity = velocity.normalized() * speed
	if Input.is_action_just_pressed("Shoot"):
		rpc_unreliable("shoot")

func _physics_process(delta):
	# Process input only if we are network master of this player	
	if not Session.is_multi or is_network_master():
		get_input()
		velocity = move_and_slide(velocity)
		look_at(get_global_mouse_position())
		get_parent().updateNetworkRotation(rotation)
		get_parent().updateNetworkPosition(position)

func _input(event):
	if event is InputEventMouseButton:   #position we need for projectile to travel
		pass
		#print("Mouse Click/Unclick at: ", event.position)
	elif event is InputEventMouseMotion:    #position we need for ratating character towards aim
		pass
		#print("Mouse Motion at: ", get_viewport().get_mouse_position() )


sync func shoot():
	var projectile_instance = Projectile.instance()
	projectile_instance.spawning_player = self
	projectile_instance.set_network_master(get_network_master())
	get_tree().get_root().add_child(projectile_instance)
	
	var projectile_spawn_position = self.transform
	if not is_network_master():
		projectile_spawn_position = get_parent().transform
	projectile_instance.transform = projectile_spawn_position
	_play_sound(SoundMixer.PLAYER_SHOT,  MIXER_1)


# Helpers
func _play_sound(index, mix = 0):
	var mixer = _mixers[mix]
	mixer.stream = SoundMixer.getVoiceSound(index)
	mixer.play()

func deal_damage(amount):
	if is_network_master():
		rpc("remove_health", amount)

func omicron_picked_up():
	rpc("remove_health", 10)
	get_parent().get_node("UI/HUD").set_willpower(health)
	make_ill()
	
func syringe_picked_up():
	rpc("add_health", 10)
	get_parent().get_node("UI/HUD").set_willpower(health)

func mask_picked_up():
	_play_sound(SoundMixer.PLAYER_SHUFFLE,  MIXER_1)
	print("mask picked up")
	cure()
	
func make_ill():
	covid = true
	speed = COVID_SPEED
	
func cure():
	covid = false
	speed = NORMAL_SPEED

sync func add_health(hp):
	cure()
	health = max(MAX_HEALTH, health+hp)
	_play_sound(SoundMixer.PLAYER_GRUNT,  MIXER_1)
	
sync func remove_health(hp):
	health = max(0, health-hp)
	if(health > MAX_HEALTH/2):
		_play_sound(SoundMixer.PLAYER_COUGH,  MIXER_1)
	else:
		if health == 0:
			rpc("die")
		_play_sound(SoundMixer.PLAYER_HEAVY_COUGH,  MIXER_1)
	print("Removing " + str(hp) + "hp, remaining: " +  str(health))
	
sync func die():
	#_play_sound(SoundMixer.PLAYER_DIE,  MIXER_1)
	print("die")
	# Yeeees, I know, beautifull :D
	get_parent().get_parent().remove_child(get_parent())


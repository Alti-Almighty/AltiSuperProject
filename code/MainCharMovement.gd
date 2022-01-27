extends KinematicBody2D

const Projectile = preload("res://Projectile.tscn")
export (int) var speed = 200
export (int) var boost = 300

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
		shoot()

func _physics_process(delta):
	# Process input only if we are network master of this player

	if not Session.is_multi or is_network_master():
		get_input()
		velocity = move_and_slide(velocity)
		get_parent().updateNetworkPosition(position)				
		look_at(get_global_mouse_position())

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
	_play_sound(SoundMixer.PLAYER_SHOT,  MIXER_1)
	
	$Camera2D.shake(0.2,15,8)

# Helpers
func _play_sound(index, mix = 0):
	var mixer = _mixers[mix]
	mixer.stream = SoundMixer.getVoiceSound(index)
	mixer.play()

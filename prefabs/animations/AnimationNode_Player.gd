extends KinematicBody2D

export(int) var speed = 80
onready var state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	handle_movement()
	
	# fun with sounds
	if Input.is_action_pressed("ui_page_down"):
		SoundMixer.fadeToWar()
	if Input.is_action_pressed("ui_page_up"):
		SoundMixer.fadeToChill()		
	if Input.is_action_pressed("ui_home"):		
		$PlayerMixer.stream = SoundMixer.getVoiceSound(SoundMixer.PLAYER_COUGH)
		$PlayerMixer.play()
		
	
func handle_movement():
	var motion = Vector2() 
	
	if Input.is_action_pressed("ui_left"):
		if Input.is_action_just_pressed("ui_left"):
			play_sound(SoundMixer.PLAYER_RUN)			
		motion.x -= 1		
	if Input.is_action_pressed("ui_right"):
		if Input.is_action_just_pressed("ui_right"):		
			play_sound(SoundMixer.PLAYER_WALK)		
		motion.x += 1
	if Input.is_action_pressed("ui_up"):
		if Input.is_action_just_pressed("ui_up"):		
			play_sound(SoundMixer.PLAYER_SHUFFLE)		
		motion.y -= 1		
	if Input.is_action_pressed("ui_down"):
		if Input.is_action_just_pressed("ui_down"):		
			play_sound(SoundMixer.PLAYER_SPRAY)		
		motion.y += 1		
		
		
			
	motion = motion.normalized()
	
	if motion == Vector2.ZERO:
		state_machine.travel("Idle")
	else:
		state_machine.travel("Walkin")
		$AnimationTree["parameters/Walkin/blend_position"] = motion

	motion = move_and_slide(motion * speed)

func play_sound(index):
	$PlayerMixer.stream = SoundMixer.getVoiceSound(index)
	$PlayerMixer.play()
	
func stop_sound():
	$PlayerMixer.stop()

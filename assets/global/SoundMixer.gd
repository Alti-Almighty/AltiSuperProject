extends Node2D

##################################
# INTERFACE : 
# playChill() - just plays chill music
# playWar() - just plays war music
# fadeToWar() - smoothly fades from current to war
# fadeToChill() - smoothly fades from current to chill
##################################

var _music = []
var music_player = null
enum {CHILL_MUSIC, FIGHT_MUSIC}
export(int) var music_volume = 0
onready var tween_out = get_node("GlobalMixerTweenOut")
onready var tween_in = get_node("GlobalMixerTweenIn")

export var between_music_transition_duration = 1.00
export var between_music_transition_type = 1 # TRANS_SINE

func _ready():
	loadSounds()

func loadSounds():
	# Add loader here
	_music.append(load("res://assets/sounds/music/chill.mp3"))
	_music.append(load("res://assets/sounds/music/fight.mp3"))
	
func playChill():
	$GlobalMixer.stream = _music[CHILL_MUSIC]
	$GlobalMixer.play()
	
func playWar():	
	$GlobalMixer.stream = _music[FIGHT_MUSIC]
	$GlobalMixer.play()

####
# FADE IN AND OUT 
####
#smoothly translates between the tweens
func fadeToWar():
	fade_out_to(FIGHT_MUSIC)
	
func fadeToChill():
	fade_out_to(CHILL_MUSIC)

var __nextMusicToPlay = null;

func fade_out_to(newMusic):
	# tween music volume down to 0
	__nextMusicToPlay = newMusic;
	tween_out.interpolate_property($GlobalMixer, "volume_db", music_volume, -80, between_music_transition_duration, between_music_transition_type, Tween.EASE_IN, 0)	
	tween_out.start()
	# when the tween ends, the music will be stopped

#Tween out mixer stopped
func _on_GlobalMixerTweenOut_tween_completed(object, key):	
	object.stop()
	
	$GlobalMixer.stream = _music[__nextMusicToPlay]
	$GlobalMixer.play()
	
	tween_in.interpolate_property($GlobalMixer, "volume_db", -40, music_volume, between_music_transition_duration, between_music_transition_type, Tween.EASE_OUT, 0)	
	tween_in.start()
	



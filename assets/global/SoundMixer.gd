extends Node2D

##################################
# INTERFACE : 
# playChill() - just plays chill music
# playWar() - just plays war music
# fadeToWar() - smoothly fades from current to war
# fadeToChill() - smoothly fades from current to chill
# getVoiceSound() - gets a preloaded voice sound
##################################

var _music = []
var _player_voices = []

var music_player = null

enum {CHILL_MUSIC, FIGHT_MUSIC}
enum {PLAYER_GRUNT, PLAYER_RUN, PLAYER_WALK, PLAYER_SPRAY, PLAYER_SHUFFLE, PLAYER_DEATH, PLAYER_SHOT, PLAYER_COUGH, PLAYER_HEAVY_COUGH}

export(int) var music_volume = 0
onready var tween_out = get_node("GlobalMixerTweenOut")
onready var tween_in = get_node("GlobalMixerTweenIn")

export var between_music_transition_duration = 1.00
export var between_music_transition_type = 1 # TRANS_SINE

func _ready():
	_loadSounds()
	_loadVoices()

func _loadSounds():
	# Add loader here
	_music.append(load("res://assets/sounds/music/chill.mp3"))
	_music.append(load("res://assets/sounds/music/fight.mp3"))
	
func _loadVoices():
	# Add loader here
	_player_voices.append(load("res://assets/sounds/other/chrzakanie.wav"))
	_player_voices.append(load("res://assets/sounds/other/bieg.wav"))
	_player_voices.append(load("res://assets/sounds/other/chod.wav"))
	_player_voices.append(load("res://assets/sounds/other/psikniecie.wav"))
	_player_voices.append(load("res://assets/sounds/other/szuranie.wav"))
	_player_voices.append(load("res://assets/sounds/other/smierc.wav"))
	_player_voices.append(load("res://assets/sounds/other/shot.mp3"))
	_player_voices.append(load("res://assets/sounds/other/kaszel.wav"))
	_player_voices.append(load("res://assets/sounds/other/kaszel_mocny.wav"))
	
#Gets voice sound
func getVoiceSound(voiceIndex):
	return _player_voices[voiceIndex]
		
func playChill():
	$GlobalMixer.stream = _music[CHILL_MUSIC]
	#TODO: there must be easier/proper way of changing volume
	$GlobalMixer.volume_db = -6
	$GlobalMixer.play()
	
func playWar():	
	$GlobalMixer.stream = _music[FIGHT_MUSIC]
	#$GlobalMixer.play()

####
# FADE IN AND OUT 
####
#smoothly translates between the tweens
func fadeToWar():
	_fade_out_to(FIGHT_MUSIC)
	
func fadeToChill():
	_fade_out_to(CHILL_MUSIC)

var __nextMusicToPlay = null;

func _fade_out_to(newMusic):
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
	



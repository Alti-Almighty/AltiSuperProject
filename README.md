# AltiSuperProject

# Commit 26/01 @Jarek

## SoundMixer

Added sound mixer as a global singleton, at any time you can use in your sctipts following methods :

Method  | Comment
------------- | -------------
playChill()   | just plays chill music
playWar()   | just plays war music
fadeToWar() | smoothly fades from current to war mmusic 
fadeToChill() | smoothly fades from current to chill music 
getVoiceSound() | gets a preloaded voice sound

All sounds we can preload in SoundMixer and you can get access to the loaded sound through getVoiceSound(ENUM_INDEX),
see AnimationNode_Player.gd script for sample use 

```python
if Input.is_action_pressed("ui_home"):		
		$PlayerMixer.stream = SoundMixer.getVoiceSound(SoundMixer.PLAYER_COUGH)
		$PlayerMixer.play()
```

# Commit 26/01 @Jarek

## RageTimer

Added Rage Timer that you can use as a drop in. Following are the methods tbu : 

Method  | Comment
------------- | -------------
set_speed() | sets speed of the timer,  one of 4 - {SPEED_SLOW, SPEED_NEUTRAL, SPEED_FAST, SPEED_BLAZING}
start_timer() | resets rage to max_rage and stars the timer based on speed
set_rage(rage) | sets current rage
@signal timer_started | you can connect to this event when timer starts
@signal timer_kaboom | you can connect to this event when timer reaches 0

Sample use : 
```python
	$RageTimer.set_speed($RageTimer.SPEED_BLAZING)
	$RageTimer.start_timer()	
	
func _on_RageTimer_timer_kaboom():
	print("kaboom !")



```

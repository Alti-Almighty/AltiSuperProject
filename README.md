# AltiSuperProject

# Commit 26/01 @Jarek

Added sound mixer as a global singleton, at any time you can use in your sctipts following methods :

playChill() - just plays chill music
playWar() - just plays war music
fadeToWar() - smoothly fades from current to war mmusic
fadeToChill() - smoothly fades from current to chill music
getVoiceSound() - gets a preloaded voice sound

All sounds we can preload in SoundMixer and you can get access to the loaded sound through getVoiceSound(ENUM_INDEX),
see AnimationNode_Player.gd script for sample use 

if Input.is_action_pressed("ui_home"):		
		$PlayerMixer.stream = SoundMixer.getVoiceSound(SoundMixer.PLAYER_COUGH)
		$PlayerMixer.play()

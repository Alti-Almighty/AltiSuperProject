extends CanvasLayer

###################################################
# Interface: 
# kaboom() - sample "domain logic" function running some visual effects on shaders
# restart() - called on restart
####################################################

func kaboom():
	$ChromaticAberration.show()
	$Blur.show()
	
	$ChromaticAberration.pulse()
	$Blur.pulse()
	$Wiper.pulse_out()
	#$WiperTexture.pulse_out()

func restart():
	$Wiper.pulse_in()

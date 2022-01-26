extends CanvasLayer

func kaboom():
	$ChromaticAberration.show()
	$Blur.show()
	
	$ChromaticAberration.pulse()
	$Blur.pulse()
	$Wiper.pulse_out()

func restart():
	$Wiper.pulse_in()

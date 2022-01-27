extends ColorRect

export(bool) var enabled = true

func pulse_out():	
	if enabled:
		$AnimationPlayer.play("Kaboom")
	
func pulse_in():		
	if enabled:
		$AnimationPlayer.play("Restart")	

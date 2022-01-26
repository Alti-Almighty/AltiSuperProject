extends ColorRect

func pulse_out():	
	$AnimationPlayer.play("Kaboom")
	
func pulse_in():	
	$AnimationPlayer.play("Restart")	

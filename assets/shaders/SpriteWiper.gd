extends Sprite

func pulse_out():	
	$AnimationPlayer.play("Kaboom")
	
func pulse_in():		
	$AnimationPlayer.play("Reset")	

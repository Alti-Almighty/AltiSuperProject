extends ColorRect

export(bool) var enabled = true

func pulse():
	if enabled:
		$AnimationPlayer.play("Kaboom")

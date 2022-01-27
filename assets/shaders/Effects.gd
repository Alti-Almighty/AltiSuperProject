extends CanvasLayer

###################################################
# Interface: 
# kaboom() - sample "domain logic" function running some visual effects on shaders
# restart() - called on restart
####################################################

export(bool) var enabled = true

func _ready():
	print(enabled)
	_toggle_effects()
	
func deactivate():
	enabled = false
	_toggle_effects()

func _toggle_effects():
	for _i in self.get_children():
		_i.enabled = enabled

func kaboom():	
	if enabled:				
		$ChromaticAberration.show()
		$Blur.show()
		
		$ChromaticAberration.pulse()
		$Blur.pulse()
		#$Wiper.pulse_out()
		$WiperTexture.pulse_out()

func restart():
	if enabled:				
		#$Wiper.pulse_in()
		$WiperTexture.pulse_in()

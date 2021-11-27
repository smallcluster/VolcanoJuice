extends Spatial

var alert = false

func set_alert(boolean):
	if boolean:
		$lights_alert.play("alert")
		$Animator.play("open")
	elif not boolean and alert :
		$lights_alert.play("RESET")
		$Animator.play_backwards("open")
	else :
		$lights_alert.play("RESET")
		$Animator.play("RESET")
	alert = boolean
		
func _on_world_surprise():
	set_alert(true)

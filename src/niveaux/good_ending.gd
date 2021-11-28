extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/AnimationPlayer.play("fade_in")
	$AudioStreamPlayer.play()
	play_intro_anim()
	
func play_intro_anim():
	$perso_fin/AnimationPlayer.play("drink_ok", -1 , 0.5)
	yield($perso_fin/AnimationPlayer, "animation_finished")
	start_fade()
	
	
func fade_to_game():
	get_tree().change_scene("res://Menu/Menu.tscn")
	print("ok")
	
func start_fade():
	print("ok")
	$ColorRect/AnimationPlayer.play("fade_out")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

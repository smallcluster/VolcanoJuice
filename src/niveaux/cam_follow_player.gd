tool
extends Spatial

signal surprise()
signal panique()

onready var camera = $Camera
onready var player = $player



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.look_at(player.transform.origin, Vector3.UP)
	
	
func start_alarm():
	$AnimationPlayer.play("redlight_modulation")
	$alarm_audio.play()
	emit_signal("panique")
	

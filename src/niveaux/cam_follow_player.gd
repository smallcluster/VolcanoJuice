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
	if not Engine.editor_hint:
		$adventure_music.play()
	var pnjs = $pnjs.get_children()
	for pnj in pnjs:
		self.connect("panique", pnj, "_on_world_panique")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		camera.look_at(player.transform.origin, Vector3.UP)
	
	
func start_alarm():
	$adventure_music.stop()
	$AnimationPlayer.play("redlight_modulation")
	$alarm_audio.play()
	$action_music.play()
	emit_signal("panique")
	

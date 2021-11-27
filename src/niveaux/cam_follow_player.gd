tool
extends Spatial

signal surprise()
signal panique()

onready var camera = $Camera
onready var player = $player

onready var premier_diag = $dialogueIntro
onready var dernier_diag = $dialoguePanique
onready var billboard_anim = $start_diag/diaIndicator/AnimationPlayer

var in_area_diag = false



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
		self.connect("surprise", pnj, "_on_world_surprise")
		
	dernier_diag.set_process(false)
	dernier_diag.visible = false
	
	premier_diag.set_process(false)
	premier_diag.visible = false
	player.dialogue = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		camera.look_at(player.transform.origin, Vector3.UP)
		
	if in_area_diag:
		if Input.is_action_pressed("ui_accept"):
			in_area_diag = false
			$start_diag.set_process(false)
			$start_diag.visible = false
			player.dialogue = true
			premier_diag.set_process(true)
			premier_diag.visible = true
			
		
		
	
	
	
func start_alarm():
	if Engine.editor_hint:
		return
	$adventure_music.stop()
	$AnimationPlayer.play("redlight_modulation")
	$alarm_audio.play()
	$action_music.play()
	
	
func start_panic():
	if Engine.editor_hint:
		return
	$screams.play()
	emit_signal("panique")
	

func _on_dialogueIntro_fin_dialogue():
	emit_signal("surprise")
	$AnimationPlayer.play("redalert")
	dernier_diag.set_process(true)
	dernier_diag.visible = true


func _on_dialoguePanique_fin_dialogue():
	player.dialogue = false
	$screams.play()
	emit_signal("panique")


func _on_Area_body_entered(body):
	billboard_anim.play("focus")
	in_area_diag = true


func _on_Area_body_exited(body):
	billboard_anim.play_backwards("focus")
	in_area_diag = false

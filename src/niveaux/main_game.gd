tool
extends Spatial

signal surprise()
signal panique()
signal ok()

export var nb_sec : int = 35

onready var camera = $Camera
onready var camera_couloir = $Camera2
onready var player = $player

onready var premier_diag = $dialogueIntro
onready var dernier_diag = $dialoguePanique
onready var billboard_anim = $start_diag/diaIndicator/AnimationPlayer
onready var plop = $start_diag/plop
onready var maitre_pos = $pnjs/maitre_stage.transform.origin
onready var camera_epuration = $Camera3


var in_area_diag = false
var in_dialogue = false

var dalogue_accepte = false

var water_control_done = false
var water_control2_done = false
var water_control3_done = false



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.visible = false
	$Control/Label.text = str(nb_sec)+"s"
	
	if not Engine.editor_hint:
		$adventure_music.play()
		
	var pnjs = $pnjs.get_children()
	for pnj in pnjs:
		self.connect("panique", pnj, "_on_world_panique")
		self.connect("surprise", pnj, "_on_world_surprise")
		self.connect("ok", pnj,"_on_world_ok")
		
	var doors = $doors.get_children()
	for door in doors:
		self.connect("surprise", door, "_on_world_surprise")
		self.connect("ok", door,"_on_world_ok")
		
	var water_control = $water_control
	var water_control2 = $water_control2
	var water_control3 = $water_control3
	
	water_control.connect("playing", player, "_on_mini_game")
	water_control2.connect("playing", player, "_on_mini_game")
	water_control3.connect("playing", player, "_on_mini_game")
	
	water_control.connect("solved", self, "_on_water_control_finish")
	water_control2.connect("solved", self, "_on_water_control2_finish")
	water_control3.connect("solved", self, "_on_water_control3_finish")
		
	
		
	dernier_diag.set_process(false)
	dernier_diag.visible = false
	
	
	premier_diag.set_process(false)
	premier_diag.visible = false
	player.dialogue = false
	
	

func _on_water_control_finish():
	water_control_done = true
	go_back_to_normal()
	
func _on_water_control2_finish():
	water_control2_done = true
	go_back_to_normal()
	
func _on_water_control3_finish():
	water_control3_done = true
	go_back_to_normal()
	
func go_back_to_normal():
	if water_control_done and water_control2_done and water_control3_done:
		$AnimationPlayer.play_backwards("redalert")
		$screams.stop()
		$action_music.stop()
		$adventure_music.play()
		$alarm_audio.stop()
		emit_signal("ok")
		$fade/fade_anim.play("fade_in")
		$Control/Timer.stop()
		$Control.visible = false

func change_scene():
	if water_control_done and water_control2_done and water_control3_done:
		get_tree().change_scene("res://niveaux/good_ending.tscn")
	else:
		get_tree().change_scene("res://niveaux/bad_ending.tscn")

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		camera.look_at(player.transform.origin, Vector3.UP)
		camera_epuration.look_at(player.transform.origin, Vector3.UP)
		
	if in_area_diag:
		if Input.is_action_pressed("ui_accept"):
			in_area_diag = false
			$start_diag.set_process(false)
			$start_diag.visible = false
			player.dialogue = true
			premier_diag.set_process(true)
			premier_diag.visible = true
			in_dialogue = true
			dalogue_accepte = true
			
	if in_dialogue:
		player.turn_face(maitre_pos, 10, delta)
			
		
	
func start_alarm():
	if Engine.editor_hint:
		return
	if water_control_done and water_control2_done and water_control3_done:
		return
	$adventure_music.stop()
	$AnimationPlayer.play("redlight_modulation")
	$alarm_audio.play()
	var texture_error = load("res://WaterControl/error.png")
	$screen1.texture =texture_error
	$screen2.texture = texture_error
	

func _on_dialogueIntro_fin_dialogue():
	emit_signal("surprise")
	$AnimationPlayer.play("redalert")
	dernier_diag.set_process(true)
	dernier_diag.visible = true


func _on_dialoguePanique_fin_dialogue():
	player.dialogue = false
	$screams.play()
	$action_music.play()
	emit_signal("panique")
	in_dialogue = false
	$Control/Timer.start()
	$Control.visible = true
	


func _on_Area_body_entered(body):
	if dalogue_accepte:
		return
	billboard_anim.play("focus")
	in_area_diag = true
	plop.play()


func _on_Area_body_exited(body):
	if dalogue_accepte:
		return
	billboard_anim.play_backwards("focus")
	in_area_diag = false


func _on_couloir_body_entered(body):
	if body.is_in_group("player_group"):
		camera_couloir.current = true


func _on_salle_controle_body_entered(body):
	if body.is_in_group("player_group"):
		camera.current = true


func _on_salle_epuration_body_entered(body):
	if body.is_in_group("player_group"):
		camera_epuration.current = true


func _on_Timer_timeout():
	nb_sec = nb_sec-1
	
	if nb_sec < 0:
		$fade/fade_anim.play("fade_in")
		$Control/Timer.stop()
	else:
		$Control/Label.text = str(nb_sec)+"s"
	

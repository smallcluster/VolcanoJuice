extends Spatial

signal playing(is_playing)
signal solved()

export var target : float = 0.5 
export var target_width : float = 0.1 

var cursor : float = 0.0
var cursor_width : float = 0.01

var done = false
var in_area = false
var in_mini_game = false
var dir = 1;
export var speed = 0.1

onready var bg = $mini_game/bg
onready var cursor_rect = $mini_game/bg/cursor
onready var target_rect = $mini_game/bg/target

func update_cursor():
	var height = bg.rect_size.y
	cursor_rect.rect_size.y = height*cursor_width
	cursor_rect.rect_position.y = cursor*height - cursor_rect.rect_size.y/2


func update_target():
	var height = bg.rect_size.y
	target_rect.rect_size.y = height*target_width
	target_rect.rect_position.y = target*height - target_rect.rect_size.y/2


func set_target_width(new_width):
	target_width = new_width
	#update_target()

func set_target(new_target):
	target = new_target
	#update_target()
	


# Called when the node enters the scene tree for the first time.
func _ready():
	$mini_game.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if done :
		return
	
	if cursor >= 1 || cursor <= 0:
		dir *= -1
	cursor = cursor + speed * delta*dir	
	cursor = clamp(cursor, 0, 1)
	update_target()
	update_cursor()
	
	if in_area and not in_mini_game:
		if Input.is_action_just_pressed("ui_accept"):
			in_mini_game = true
			emit_signal("playing", true)
			$mini_game.visible = true
			cursor = 0
	elif in_mini_game:
		if Input.is_action_just_pressed("ui_accept"):
			# test si le curseur est dans la zone
			var test1 = cursor_rect.rect_position.y+cursor_rect.rect_size.y >= target_rect.rect_position.y
			var test2 = cursor_rect.rect_position.y <= target_rect.rect_position.y+target_rect.rect_size.y
		
			if  test1 and  test2:
				done = true
				emit_signal("playing", false)
				emit_signal("solved")
				$Sprite3D.visible = false
				$good.play()
			else:
				$wrong.play()
				emit_signal("playing", false)
				
			$mini_game.visible = false
			in_mini_game = false
			
				




func _on_Area_body_entered(body):
	if body.is_in_group("player_group") and not done:
		in_area = true
		$Sprite3D/AnimationPlayer.play("interract")
		$AudioStreamPlayer.play()


func _on_Area_body_exited(body):
	if body.is_in_group("player_group") and not done :
		in_area = false
		$Sprite3D/AnimationPlayer.play_backwards("interract")

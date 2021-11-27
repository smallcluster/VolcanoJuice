extends KinematicBody


var speed = 100
var dir = Vector3.FORWARD


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("ui_up"):
		move_and_slide(Vector3.FORWARD*speed*delta, Vector3.UP)
		dir.z = 1
	elif Input.is_action_pressed("ui_down"):
		move_and_slide(-Vector3.FORWARD*speed*delta, Vector3.UP)
		dir.z = -1
		
	if Input.is_action_pressed("ui_left"):
		move_and_slide(Vector3.LEFT*speed*delta, Vector3.UP)
		dir.x = 1
		
	elif Input.is_action_pressed("ui_right"):
		move_and_slide(Vector3.RIGHT*speed*delta, Vector3.UP)
		dir.x = -1
		
	transform.basis.slerp(dir.normalized(), 0.1)
		

		

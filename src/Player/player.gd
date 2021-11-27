extends KinematicBody


var speed = 125
onready var statemachine = $AnimationTree.get("parameters/playback")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var dir = Vector3.ZERO
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
	if dir != Vector3.ZERO:
		turn_face(transform.origin+dir, 10, delta)
		statemachine.travel("run")
	else:
		statemachine.travel("idle")
	
		

func turn_face(target, rotationSpeed, delta):
	var global_pos = global_transform.origin
	var wtransform = global_transform.looking_at(Vector3(target.x,global_pos.y,target.z),Vector3(0,1,0))
	var wrotation = Quat(global_transform.basis).slerp(Quat(wtransform.basis), rotationSpeed*delta)
	global_transform = Transform(Basis(wrotation), global_transform.origin)
		

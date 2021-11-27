extends KinematicBody

var speed = 2
var panique = false
var init_dir = Vector3(rand_range(0, 1), 0, rand_range(0, 1)) 

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	init_dir = Vector3(rand_range(0, 1), 0, rand_range(0, 1)) 
	init_dir = init_dir.normalized()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not panique:
		return
		
	turn_face(transform.origin-init_dir*10, 10, delta)
	
	var collide = move_and_collide(init_dir*speed*delta)
	if collide:
		init_dir = init_dir.bounce(collide.normal).normalized()
		
	


func _on_world_panique():
	$perso.set_suprised(true)
	$perso/AnimationPlayer.play("run_panic_track")
	panique = true

func turn_face(target, rotationSpeed, delta):
	var global_pos = global_transform.origin
	var wtransform = global_transform.looking_at(Vector3(target.x,global_pos.y,target.z),Vector3(0,1,0))
	var wrotation = Quat(global_transform.basis).slerp(Quat(wtransform.basis), rotationSpeed*delta)
	global_transform = Transform(Basis(wrotation), global_transform.origin)

	

tool
extends Spatial

# visual options
enum SEXE {homme, femme}
enum PEAU {noir, blanc, metice}
enum IDLE {standing, typing, speaking}
export(SEXE) var sexe = SEXE.homme setget set_sexe
export(PEAU) var peau = PEAU.blanc setget set_peau
export(IDLE) var idle_anim = IDLE.standing setget set_idle_anim

export var suprised : bool = false setget set_suprised
export var cravate : bool = true setget set_cravate
export var lunettes : bool = true setget set_lunettes
export var casque : bool = true setget set_casque

export var couleur_chemise : Color = Color.white setget set_couleur_chemise
export var couleur_chemise_random : bool = false setget set_couleur_chemise_random

export var couleur_jean : Color = Color(0,0.5,1,1) setget set_couleur_jean
export var couleur_jean_random : bool = false setget set_couleur_jean_random

export var couleur_cravate : Color = Color.red setget set_couleur_cravate
export var couleur_cravate_random : bool = false setget set_couleur_cravate_random

export var couleur_cheveux : Color = Color.darkgoldenrod setget set_couleur_cheveux
export var couleur_cheveux_random : bool = false setget set_couleur_cheveux_random

onready var step = load("res://perso/step2.wav")
onready var stepplayer : AudioStreamPlayer3D = $pas

onready var suprised_mat = load("res://perso/face_suprised.material")
onready var normal_mat  = load("res://perso/face.material")

func randomize_idle_anim():
	var animplayer = $AnimationPlayer
	var length;
	if idle_anim == IDLE.standing:
		length = animplayer.get_animation("stanfing_idle_track").length
		animplayer.play("stanfing_idle_track")
	elif idle_anim == IDLE.speaking:
		length = animplayer.get_animation("speaking_idle_track").length
		animplayer.play("speaking_idle_track")
	elif idle_anim == IDLE.typing:
		length = animplayer.get_animation("typing_idle_track").length
		animplayer.play("typing_idle_track")
		
	animplayer.seek(rand_range(0, length), true)

func set_idle_anim(new_idle_anim):
	idle_anim = new_idle_anim
	randomize_idle_anim()

func set_suprised(new_bool):
	suprised = new_bool
	if suprised:
		$Armature/Skeleton/body.set_surface_material(1, suprised_mat)
	else:
		$Armature/Skeleton/body.set_surface_material(1, normal_mat)


func set_peau(new_peau):
	peau = new_peau
	var mat = SpatialMaterial.new()
	if peau == PEAU.blanc:
		mat.albedo_color = Color(1.0, 0.8, 0.6, 1.0)
	elif peau == PEAU.noir:
		mat.albedo_color = Color(0.25, 0.8*0.25, 0.6*0.25, 1.0)
	elif peau == PEAU.metice:
		mat.albedo_color = Color(0.7, 0.8*0.5, 0.6*0.5, 1.0)
	
	$Armature/Skeleton/body.set_surface_material(0, mat)

func set_cravate(visibility):
	cravate = visibility
	$Armature/Skeleton/cravate.visible = visibility
	
func set_lunettes(visibility):
	lunettes = visibility
	$Armature/Skeleton/BoneAttachment2/lunettes.visible = visibility
	
func set_casque(visibility):
	casque = visibility
	$Armature/Skeleton/BoneAttachment/casque.visible = visibility
	
func set_sexe(new_sexe):
	sexe = new_sexe
	$Armature/Skeleton/cheveux_femme.visible = not sexe == SEXE.homme
	$Armature/Skeleton/cheveux_homme.visible = sexe == SEXE.homme
	
	
func set_couleur_chemise(new_couleur):
	couleur_chemise = new_couleur
	var mat = SpatialMaterial.new()
	mat.albedo_color = new_couleur
	$Armature/Skeleton/chemise.material_override = mat
	
func set_couleur_chemise_random(new_bool):
	if not new_bool:
		return
	couleur_chemise = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1), 1.0)
	var mat = SpatialMaterial.new()
	mat.albedo_color = couleur_chemise
	$Armature/Skeleton/chemise.material_override = mat
	
func set_couleur_jean(new_couleur):
	couleur_jean = new_couleur
	var mat = SpatialMaterial.new()
	mat.albedo_color = new_couleur
	$Armature/Skeleton/jean.material_override = mat
	
func set_couleur_jean_random(new_bool):
	if not new_bool:
		return
	couleur_jean = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1), 1.0)
	var mat = SpatialMaterial.new()
	mat.albedo_color = couleur_jean
	$Armature/Skeleton/jean.material_override = mat
	
	
func set_couleur_cravate(new_couleur):
	couleur_cravate = new_couleur
	var mat = SpatialMaterial.new()
	mat.albedo_color = new_couleur
	$Armature/Skeleton/cravate.material_override = mat
	
func set_couleur_cravate_random(new_bool):
	if not new_bool:
		return
	couleur_cravate = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1), 1.0)
	var mat = SpatialMaterial.new()
	mat.albedo_color = couleur_cravate
	$Armature/Skeleton/cravate.material_override = mat
	

func set_couleur_cheveux(new_couleur):
	couleur_cheveux = new_couleur
	var mat = SpatialMaterial.new()
	mat.albedo_color = new_couleur
	$Armature/Skeleton/cheveux_femme.material_override = mat
	$Armature/Skeleton/cheveux_homme.material_override = mat
	
func set_couleur_cheveux_random(new_bool):
	if not new_bool:
		return
	couleur_cheveux = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1), 1.0)
	var mat = SpatialMaterial.new()
	mat.albedo_color = couleur_cheveux
	$Armature/Skeleton/cheveux_femme.material_override = mat
	$Armature/Skeleton/cheveux_homme.material_override = mat
	
func play_pas_audio():

	stepplayer.stop()
	stepplayer.stream = step
	stepplayer.play()

func _ready():
	randomize_idle_anim()
		


func _process(delta):
	pass
		
		

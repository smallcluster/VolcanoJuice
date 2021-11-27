tool
extends Spatial

export var couleur : Color = Color.red setget set_couleur
export var couleur_random : bool = false setget set_couleur_random


func set_couleur(new_color):
	couleur = new_color
	var mat = SpatialMaterial.new()
	mat.albedo_color = couleur
	$button.set_surface_material(1, mat)
	
func set_couleur_random(new_color):
	couleur = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1), 1.0)
	var mat = SpatialMaterial.new()
	mat.albedo_color = couleur
	$button.set_surface_material(1, mat)

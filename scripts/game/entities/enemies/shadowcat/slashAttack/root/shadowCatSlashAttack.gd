extends Area2D
class_name ShadowCatSlash

func _on_anim_animation_finished(_slashAttack):
	queue_free()

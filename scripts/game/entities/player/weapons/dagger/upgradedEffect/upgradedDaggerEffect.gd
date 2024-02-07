extends AnimatedSprite2D
class_name UpgradedDaggerEffect

func _on_animation_finished():
	queue_free()

#funcao de verificar se a hitbox colidiu
func _on_hitbox_area_entered(area):
	#verifica se a area colidida e um inimigo
	if area.is_in_group("enemy"):
		#verifica se pode sofrer dano
		if area.has_method("Damage"):
			#define os parametros do ataque
			var attack = Attack.new()
			attack.attackDamage = 5
			#aplica 5 de dano
			area.Damage(attack)

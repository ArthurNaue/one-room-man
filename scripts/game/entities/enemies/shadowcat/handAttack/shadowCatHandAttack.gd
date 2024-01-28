extends StaticBody2D
class_name ShadowCatHand

#funcao que verifica se o objeto colidiu
func _on_hitbox_area_entered(area):
	#verifica se o objeto colidido e um inimigo
	if area.is_in_group("player"):
		#verifica se tem a funcao de tomar dano
		if area.has_method("Damage"):
			#define os parametros do ataque
			var attack = Attack.new()
			attack.attackDamage = 1
			#aplica o dano 
			area.Damage(attack)

func _on_despawn_timer_timeout():
	queue_free()


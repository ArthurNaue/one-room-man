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

#funcao que executa quando o timer de despawn acaba
func _on_despawn_timer_timeout():
	#destroi o objeto
	queue_free()


extends Area2D
class_name HitboxComponent

#variaveis
@export var health: HealthComponent
@export var damageIndicator: DamageIndicatorComponent

#funcao de aplicar dano
func Damage(attack: Attack):
	#faz aparecer o popup de dano
	damageIndicator.popup(attack.attackDamage)
	damageIndicator.get_node("anim").play("popup")
	await get_tree().create_timer(0.2).timeout
	#aplica o dano na vida
	health.Damage(attack)

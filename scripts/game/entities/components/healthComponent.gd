extends Node2D
class_name HealthComponent

#variaveis
@export var maxHealth: int
@export var healthBar: HealthBar
var health: int

func _ready():
	#muda a vida para o maximo de vida
	health = maxHealth

#funcao de tomar dano
func Damage(attack: Attack):
	#diminui a vida com base no dano sofrido
	health -= attack.attackDamage
	#diminui a barra de vida
	healthBar.value = health

	#verifica se a vida chegou a 0
	if health <= 0:
		#destroi o objeto
		get_parent().queue_free()

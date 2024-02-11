extends Node2D
class_name HealthComponent

#variaveis
@export var maxHealth: int
@export var healthBar: HealthBar
@export var deathParticleScene: PackedScene
@onready var game = get_parent().get_parent()
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
		spawnDeathParticle(global_position)
		if get_parent().is_in_group("enemy"):
			get_parent().queue_free()
			game.spawnCoin(global_position)

func spawnDeathParticle(location: Vector2):
	var deathParticle = deathParticleScene.instantiate() as CPUParticles2D
	game.add_child(deathParticle)
	deathParticle.global_position = location
	deathParticle.emitting = true

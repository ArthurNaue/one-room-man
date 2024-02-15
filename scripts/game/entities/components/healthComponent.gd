extends Node2D
class_name HealthComponent

#variaveis
@export var maxHealth: int
@export var healthBar: HealthBar
@export var deathParticleScene: PackedScene
@export var damageSoundScene: PackedScene
@onready var game = get_parent().get_parent()
var health: int

func _ready():
	#muda a vida para o maximo de vida
	health = maxHealth

#funcao de tomar dano
func Damage(attack: Attack):
	#executa a funcao de tocar o som de dano
	playDamageSound(damageSoundScene)
	#diminui a vida com base no dano sofrido
	health -= attack.attackDamage
	#diminui a barra de vida
	healthBar.value = health

	#verifica se a vida chegou a 0
	if health <= 0:
		#spawna a particula de morte
		spawnDeathParticle(global_position)
		#destroi o objeto
		get_parent().queue_free()
		#verifica se e um inimigo que morreu
		if get_parent().is_in_group("enemy"):
			#spawna uma moeda na posicao do inimigo
			game.spawnCoin(global_position)

#funcao de spawnar a particula de morte
func spawnDeathParticle(location: Vector2):
	#faz o objeto da particula de morte
	var deathParticle = deathParticleScene.instantiate() as CPUParticles2D
	#spawna o objeto da particula de morte
	game.add_child(deathParticle)
	#muda a posicao do objeto da particula de morte
	deathParticle.global_position = location
	#emite a particula de morte
	deathParticle.emitting = true

#funcao de tocar o som de dano
func playDamageSound(soundScene: PackedScene):
	#faz o objeto de som de dano
	var damageSound = soundScene.instantiate() as AudioStreamPlayer2D
	#spawna o objeto de som de dano
	game.add_child(damageSound)

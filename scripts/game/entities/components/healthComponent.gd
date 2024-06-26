extends Node2D
class_name HealthComponent

#variaveis
@export var maxHealth: int
@export var healthBar: HealthBar
@export var deathParticleScene: PackedScene
@export var damageSoundScene: PackedScene
@export var enemyType: int
@onready var game = get_parent().get_parent()

var health: int

func _ready():
	#muda a vida para o maximo de vida
	health = maxHealth

#funcao de regenerar vida
func Heal(amount: int):
	#aumenta a vida no valor desejado
	health += amount
	#atualiza a barra de vida
	updateHealthBar()

#funcao de regenerar toda a vida
func healMax():
	#regenera toda a vida
	health = maxHealth
	#atualiza a barra de vida
	updateHealthBar()

#funcao de tomar dano
func Damage(attack: Attack):
	#executa a funcao de tocar o som de dano
	playDamageSound(damageSoundScene)
	#diminui a vida com base no dano sofrido
	health -= attack.attackDamage
	#atualiza a barra de vida
	updateHealthBar()

	#verifica se a vida chegou a 0
	if health <= 0:
		#spawna a particula de morte
		spawnDeathParticle(global_position)
		#verifica se e um inimigo que morreu
		if get_parent().is_in_group("enemy"):
			#spawna uma moeda na posicao do inimigo
			game.spawnCoin(global_position, enemyType)
			#retira 1 da quantidade de entidades vivas
			game.entitiesAlive -= 1
			#destroi o objeto do inimigo
			get_parent().queue_free()
		#verifica se o player morreu
		elif get_parent().is_in_group("player"):
			#muda a cena para a de morte
			get_tree().change_scene_to_file("res://scenes/deathScreen/deathScreen.tscn")

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

#funcao de atualizar a barra de vida
func updateHealthBar():
	#atualiza a barra de vida
	healthBar.value = health

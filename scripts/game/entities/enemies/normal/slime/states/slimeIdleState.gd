extends State
class_name SlimeIdleState

#variaveis
@export var animation: AnimatedSprite2D
@export var enemy: CharacterBody2D

@onready var idleTimer = $idleTimer
@onready var jumpSound = enemy.get_node("jumpSound")

func Enter():
	#zera a velocidade do inimigo
	enemy.velocity = Vector2.ZERO
	#muda a animacao para a de tocar no chao
	animation.animation = "jumpGround"
	#toca a animacao
	animation.play()
	#randomiza o tempo de espera para trocar de estado
	idleTimer.wait_time = randi_range(1, 3)
	#comeca o timer pra mudar de estado
	idleTimer.start()

func Exit():
	#muda a animacao para a de carregar o pulo
	animation.animation = "jumpGround"
	#toca a animacao
	animation.play()
	#toca o som de pulo
	jumpSound.play()

func _on_idle_timer_timeout():
	#muda para o estado de pulo
	Transitioned.emit(self, "jump")

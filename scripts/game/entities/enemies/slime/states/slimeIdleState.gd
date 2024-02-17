extends State
class_name SlimeIdleState

@export var animation: AnimatedSprite2D
@export var enemy: CharacterBody2D
@onready var idleTimer = $idleTimer

func Enter():
	#zera a velocidade do inimigo
	enemy.velocity = Vector2.ZERO
	#reseta a animacao
	animation.frame = 0
	animation.stop()
	#comeca o timer pra mudar de estado
	idleTimer.start()

func _on_idle_timer_timeout():
	#muda para o estado de pulo
	Transitioned.emit(self, "jump")

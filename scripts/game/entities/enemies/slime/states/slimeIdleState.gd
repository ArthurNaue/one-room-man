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
	#randomiza o tempo de espera para trocar de estado
	idleTimer.wait_time = randi_range(1, 3)
	#comeca o timer pra mudar de estado
	idleTimer.start()

func _on_idle_timer_timeout():
	#muda para o estado de pulo
	Transitioned.emit(self, "jump")

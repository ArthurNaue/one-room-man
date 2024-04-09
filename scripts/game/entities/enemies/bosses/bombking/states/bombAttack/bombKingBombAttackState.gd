extends State
class_name bombKingBombAttack

#variaveis
@export var bombAttackScene: PackedScene
@export var direction: enemyDirection
@onready var enemy = get_parent().get_parent()

func Enter():
	#muda a direcao para apontar pro player
	direction.Direction()
	#faz o inimigo parar de andar
	enemy.velocity = Vector2.ZERO
	#muda a animacao para a de parado
	enemy.get_node("sprite").animation = "idle"
	#toca a animacao de parado
	enemy.get_node("sprite").play()
	#atira a bomba
	throwBomb()

func throwBomb():
	#cria o objeto de ataque
	var bombAttack = bombAttackScene.instantiate() as Area2D
	#spawna o objeto de ataque
	enemy.get_node("direction").add_child(bombAttack)
	#spawna a bomba
	Enemies.shoot(enemy.global_position, Enemies.player.global_position, "bomb", 150)
	#espera 0.5 segundos
	await get_tree().create_timer(0.5).timeout
	#deleta o objeto de ataque
	bombAttack.queue_free()
	#muda o estado para o de seguir
	Transitioned.emit(self, "follow")
	

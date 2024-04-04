extends State
class_name bombKingBombAttack

#variaveis
@export var bombAttackScene: PackedScene
@export var bombScene: PackedScene
@export var direction: enemyDirection
@onready var enemy = get_parent().get_parent()
@onready var game = get_tree().get_first_node_in_group("game")

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
	#cria o objeto da bomba
	var bomb = bombScene.instantiate() as CharacterBody2D
	#spawna o objeto de ataque
	enemy.get_node("direction").add_child(bombAttack)
	#muda a posicao da bomba
	bomb.global_position = enemy.global_position
	#spawna o objeto da bomba
	game.add_child(bomb)
	#espera 0.2 segundos
	await get_tree().create_timer(0.5).timeout
	#deleta o objeto de ataque
	bombAttack.queue_free()
	#muda o estado para o de seguir
	Transitioned.emit(self, "follow")
	

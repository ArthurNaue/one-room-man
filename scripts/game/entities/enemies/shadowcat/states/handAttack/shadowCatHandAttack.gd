extends State
class_name ShadowCatHandAttack

#variaveis
@export var handAttackScene: PackedScene
@onready var enemy = get_parent().get_parent()
@onready var game = get_parent().get_parent().get_parent()
@onready var player = get_tree().get_first_node_in_group("player")
@onready var attackTimer =  $attackTimer
var attackPosition: Vector2

func Enter():
	#muda a animacao para a de atacar
	enemy.get_node("sprite").animation = "handAttackEnter"
	#faz o inimigo ficar parado
	enemy.velocity = Vector2.ZERO
	#toca o timer de ataque
	attackTimer.start()
	#espera 0.45 segundos
	await get_tree().create_timer(0.45).timeout
	#toca o som de ataque da mao
	enemy.get_node("handAttackSound").play()
	#espera 5 segundos
	await get_tree().create_timer(5).timeout
	#para de tocar o timer de ataque
	attackTimer.stop()
	#espera 1 segundo
	await get_tree().create_timer(1).timeout
	#muda a animacao para a de sair do ataque
	enemy.get_node("sprite").animation = "handAttackExit"
	#toca a animacao 
	enemy.get_node("sprite").play()
	#espera 0.6 segundos
	await get_tree().create_timer(0.6).timeout
	#muda o estado para o de seguir
	Transitioned.emit(self, "follow")

#funcao de ataque
func attack(desiredAttackPosition: Vector2):
	#define o objeto de ataque
	var handAttack = handAttackScene.instantiate() as StaticBody2D
	#spawna o objeto de ataque
	game.add_child(handAttack)
	#muda a posicao do objeto de ataque
	handAttack.global_position = desiredAttackPosition

#funcao que executa ao fim do timer de ataque
func _on_attack_timer_timeout():
	#define a posicao do ataque
	attackPosition = player.global_position
	#espera 0.2 segundos
	await get_tree().create_timer(0.2).timeout
	#spawna o ataque
	attack(attackPosition)

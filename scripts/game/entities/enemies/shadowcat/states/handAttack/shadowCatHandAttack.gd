extends State
class_name ShadowCatHandAttack

#variaveis
@export var handAttackScene: PackedScene
@onready var enemy = get_parent().get_parent()
@onready var player = get_tree().get_first_node_in_group("player")
@onready var attackTimer =  $attackTimer
var attackPosition: Vector2

func Enter():
	#muda a animacao para a de atacar
	enemy.get_node("sprite").animation = "handAttackEnter"
	#comeca o timer do ataque
	attackTimer.start()
	enemy.velocity = Vector2.ZERO
	await get_tree().create_timer(0.45).timeout
	enemy.get_node("handAttackSound").play()
	await get_tree().create_timer(5).timeout
	attackTimer.stop()
	await get_tree().create_timer(1).timeout
	#muda a animacao para a de sair do ataque
	enemy.get_node("sprite").animation = "handAttackExit"
	enemy.get_node("sprite").play()
	await get_tree().create_timer(0.6).timeout
	Transitioned.emit(self, "follow")

func attack(desiredAttackPosition: Vector2):
	#spawna o objeto do ataque
	var handAttack = handAttackScene.instantiate() as StaticBody2D
	enemy.add_child(handAttack)
	handAttack.global_position = desiredAttackPosition
	
func _on_attack_timer_timeout():
	#define a posicao do ataque
	attackPosition = player.global_position
	#faz um tempo de espera para o ataque nao atingir o player
	await get_tree().create_timer(0.2).timeout
	#spawna o ataque
	attack(attackPosition)

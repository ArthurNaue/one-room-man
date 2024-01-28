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
	attackTimer.start()
	enemy.velocity = Vector2.ZERO
	await get_tree().create_timer(5).timeout
	attackTimer.stop()
	await get_tree().create_timer(1).timeout
	#muda a animacao para a de sair do ataque
	enemy.get_node("sprite").animation = "handAttackExit"
	enemy.get_node("sprite").play()
	await get_tree().create_timer(0.6).timeout
	Transitioned.emit(self, "follow")

func attack(attackPosition: Vector2):
	var handAttack = handAttackScene.instantiate() as StaticBody2D
	enemy.add_child(handAttack)
	handAttack.global_position = attackPosition
	
func _on_attack_timer_timeout():
	attackPosition = player.global_position
	await get_tree().create_timer(0.2).timeout
	attack(attackPosition)
	attackTimer.start()

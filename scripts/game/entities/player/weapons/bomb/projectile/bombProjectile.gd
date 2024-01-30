extends CharacterBody2D
class_name BombProjectile

#variaveis
@export var speed: int
@export var explosionScene: PackedScene
@onready var direction = (get_global_mouse_position() - position).normalized()

func _ready():
	#muda o angulo para a direcao do mouse
	look_at(get_global_mouse_position())

func _physics_process(_delta):
	#aplica movimento na bala
	velocity = direction * speed
	move_and_slide()

#funcao que verifica se o objeto colidiu
func _on_hitbox_area_entered(area):
	#verifica se o objeto colidido e um inimigo
	if area.is_in_group("enemy"):
		Explode()

#funcao de explodir
func Explode():
	#cria o objeto de explosao
	var explosion = explosionScene.instantiate() as StaticBody2D
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	queue_free()

func _on_explode_timer_timeout():
	Explode()

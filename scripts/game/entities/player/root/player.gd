extends CharacterBody2D
class_name Player

@export var speed: float
@export var weaponCooldown: float
@export var weaponPickupScene: PackedScene
@onready var sprite = $sprite
@onready var weaponsNode = $weapons
@onready var currentWeapon: Node2D
@onready var currentWeaponScene: PackedScene
@onready var currentWeaponImage: Texture
#faz um Vector2 zerado
var inputVector = Vector2.ZERO

func _process(delta: float):
	weaponCooldown -= delta
	if weaponCooldown < 0:
		weaponCooldown = 0
	
	sprite.play()

func _physics_process(_delta):
	#adiciona a direcao do player ao Vector2
	inputVector.x = Input.get_action_strength("D") - Input.get_action_strength("A")
	inputVector.y = Input.get_action_strength("S") - Input.get_action_strength("W")
	#estabiliza os numeros do Vector2
	inputVector = inputVector.normalized()
	
	#verifica se tem alguma direcao para ir
	if inputVector:
		#altera a velocidade do player baseado na direcao 
		velocity = inputVector * speed
		#muda a animacao para a de andar
		sprite.animation = "walk"
	else:
		#faz o player parar de andar
		velocity = Vector2.ZERO
		#muda a animacao para a de parado
		sprite.animation = "idle"

	#muda a direcao da sprite com base na direcao do player
	if Input.is_action_just_pressed("D"):
		sprite.flip_h = false
	elif Input.is_action_just_pressed("A"):
		sprite.flip_h = true
	
	move_and_slide()

#funcao de spawnar a arma
func spawnWeapon(weaponScene: PackedScene, weaponImage: Texture):
	#verifica se o player ja tem uma arma
	if currentWeapon != null:
		#spawna o pickup da arma
		spawnWeaponPickup()
		#deleta a arma
		currentWeapon.queue_free()
	#spawna a arma
	var weapon = weaponScene.instantiate() as Node2D
	currentWeapon = weapon
	currentWeaponScene = weaponScene
	currentWeaponImage = weaponImage
	weaponsNode.add_child(weapon)

#funcao de spawnar o objeto de pickup da arma
func spawnWeaponPickup():
	#faz o objeto de pickup 
	var weaponPickup = weaponPickupScene.instantiate() as StaticBody2D
	#define os parametros do objeto de pickup
	weaponPickup.weaponScene = currentWeaponScene
	weaponPickup.image = currentWeaponImage
	weaponPickup.global_position = global_position
	#spawna o objeto de pickup
	get_parent().add_child(weaponPickup)

#verifica se o player colidiu
func _on_hitbox_area_entered(area):
	#verifica se e um objeto de pickup de arma
	if area.is_in_group("weaponPickup"):
		area.get_parent().pickupText(true)

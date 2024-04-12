extends StaticBody2D
class_name Shop

#variaveis
@onready var interactText = $interactText
@onready var priceText = $priceText
@onready var game = get_tree().get_first_node_in_group("game")
@onready var buyAudio = $buyAudio
@onready var anim = $anim
@onready var weaponInteractText = $weaponInteractText
@onready var potionInteractText = $potionInteractText

var price: int
var weaponNumber: int
var potionNumber: int
var weaponScene : PackedScene
var weaponImg : Texture
var pickupPos = Vector2(150, 50)

func _ready():
	#roleta o preco
	rerollPrice()

func _process(_delta):
	#verifica se o texto de interacao esta visivel
	if interactText.visible == true:
		#verifica se o jogador clicou E
		if Input.is_action_just_pressed("E"):
			#toca a animacao de escolha do shop
			anim.play("optionsStart")

	#verifica se o texto de interacao da arma esta visivel
	if weaponInteractText.visible == true:
		#verifica se o jogador clicou E
		if Input.is_action_just_pressed("E"):
			#veririca se as moedas sao maior que o preco
			if game.coins >= price:
				#diminui sa moedas pelo preco
				game.coins -= price
				#toca o audio de compra
				buyAudio.play()
				#spawna a arma
				game.spawnWeaponPickup(weaponScene, weaponImg, pickupPos, false)
				#toca a animacao de fim da escolha do shop
				anim.play("optionsEnd")
				#roleta o preco
				rerollPrice()

	#verifica se o texto de interacao da pocao esta visivel
	elif potionInteractText.visible == true:
		#verifica se o jogador clicou E
		if Input.is_action_just_pressed("E"):
			#veririca se as moedas sao maior que o preco
			if game.coins >= price:
				#diminui sa moedas pelo preco
				game.coins -= price
				#toca o audio de compra
				buyAudio.play()
				#verifica qual o numero da pocao
				match potionNumber:
					1, 2, 3, 4:
						#spawna a pocao de vida
						game.spawnPotionPickup(pickupPos, Potions.health)
					5:
						#spawna a pocao de vida maxima
						game.spawnPotionPickup(pickupPos, Potions.maxHealth)
				#toca a animacao de fim da escolha do shop
				anim.play("optionsEnd")
				#roleta o preco
				rerollPrice()

#funcao de roletar o preco
func rerollPrice():
	#roleta um novo preco 
	price = randi_range(5, 10)
	#roleta qual a pocao e a arma
	weaponNumber = randi_range(1, 4)
	potionNumber = randi_range(1, 5)
	#verifica qual a arma roletada
	match weaponNumber:
		1:
			weaponScene = Weapons.dagger
			weaponImg = Weapons.daggerImg
		2:
			weaponScene = Weapons.pistol
			weaponImg = Weapons.pistolImg
		3:
			weaponScene = Weapons.bomb
			weaponImg = Weapons.bombImg
		4:
			weaponScene = Weapons.bow
			weaponImg = Weapons.bowImg
	#atualiza o texto de preco
	priceText.text = "-$" + str(price)

#funcao que executa quando uma area colideda entra no range da colisao
func _on_hitbox_area_entered(area):
	if area.is_in_group("player"):
		interactText.visible = true
		priceText.visible = true

#funcao que executa quando uma area colidida sai do range da colisao
func _on_hitbox_area_exited(_area):
	#faz o texto de interacao ficar visivel
	interactText.visible = false
	#faz o texto do preco ficar visivel
	priceText.visible = false

#funcao que executa quando uma area colidida sai do range da colisao
func _on_choices_hitbox_area_exited(_area):
	#toca a animacao de fim da escolha do shop
	anim.play("optionsEnd")

#funcao que executa quando uma area colideda entra no range da colisao
func _on_weapon_area_area_entered(area):
	#verifica se a area colidida e um player
	if area.is_in_group("player"):
		weaponInteractText.visible = true

#funcao que executa quando uma area colidida sai do range da colisao
func _on_weapon_area_area_exited(area):
	#verifica se a area colidida e um player
	if area.is_in_group("player"):
		weaponInteractText.visible = false

#funcao que executa quando uma area colideda entra no range da colisao
func _on_potion_area_area_entered(area):
	#verifica se a area colidida e um player
	if area.is_in_group("player"):
		potionInteractText.visible = true

#funcao que executa quando uma area colidida sai do range da colisao
func _on_potion_area_area_exited(area):
	#verifica se a area colidida e um player
	if area.is_in_group("player"):
		potionInteractText.visible = false

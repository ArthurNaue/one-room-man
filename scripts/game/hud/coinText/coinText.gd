extends Label
class_name CoinText

func _process(_delta):
	text = str(get_parent().coins)

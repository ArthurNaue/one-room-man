extends AudioStreamPlayer2D

#funcao que executa quando o som terminou de tocar
func _on_finished():
	#destroi o objeto do som
	queue_free()

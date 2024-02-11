extends CPUParticles2D

#funcao que executa quando a particula termina de emitir
func _on_finished():
	#destroi o objeto da particula
	queue_free()

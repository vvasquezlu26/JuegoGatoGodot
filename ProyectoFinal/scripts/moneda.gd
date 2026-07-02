extends Area3D




func _on_body_entered(body: jugador) -> void:
	if body.is_in_group("jugador"):
		body.AgregarMoneda()
		queue_free()

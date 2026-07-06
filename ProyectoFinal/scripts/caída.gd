extends Control
@onready var musica = $AudioStreamPlayer2D

func _ready() -> void:
	#video.play()
	musica.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ProyectoFinal/scenes/juego.tscn")
	
	
func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://ProyectoFinal/scenes/menu.tscn")

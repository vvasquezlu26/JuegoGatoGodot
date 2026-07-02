
extends Camera3D

var offset := Vector3(0,0,0)
@onready var Zombie: CharacterBody3D =$"../Ground/CharacterBody3D"
func _ready() -> void:
	offset = position


func _process(delta: float) -> void:
	position = Zombie.position + offset



var max_up := deg_to_rad(60)
var min_down := deg_to_rad(-60)
var sens:= 0.003
var pitch := 0.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		
		pitch -= event.relative.y * sens
		
		pitch = clamp(pitch, min_down, max_up)
		
		rotation.x = pitch

extends CharacterBody3D

@export var velocidad: float = 2.0

@export var punto_a: Node3D
@export var punto_b: Node3D

@onready var animation_player: AnimationPlayer = $Perro1/AnimationPlayer

var destino: Node3D

func _ready():

	destino = punto_b

	if animation_player:
		animation_player.play("Object_4|Take 001")


func _physics_process(delta):

	var direccion = destino.global_position - global_position
	direccion.y = 0

	if direccion.length() > 0.1:

		direccion = direccion.normalized()

		velocity.x = direccion.x * velocidad
		velocity.z = direccion.z * velocidad

		look_at(
			Vector3(destino.global_position.x, global_position.y, destino.global_position.z),
			Vector3.UP
		)

	else:

		if destino == punto_b:
			destino = punto_a
		else:
			destino = punto_b

	move_and_slide()

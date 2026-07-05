extends CharacterBody3D
class_name jugador
@onready var animation_player: AnimationPlayer =$animations/AnimationPlayer
var coins: int = 0

const SPEED = 6.5
const JUMP_VELOCITY = 6.5
const GRAVITY = 20.0

@export var sens: float = 0.001

func _ready() -> void:
	print("aqui ver error",animation_player)
	print("SOY EL PERSONAJE VERDE")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$CanvasLayer/Control/Label.text = "Coins: " + str(coins)

func _input(event):
	if event.is_action_pressed("salir"):
		get_tree().quit()
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sens)

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta
		ComprobarAltura()
		
		
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if animation_player.current_animation != "Armature|1SALTAR":
			animation_player.stop()
			animation_player.play("Armature|SAL1TAR")


	var input_dir := Input.get_vector("izquierda", "derecha", "adelante", "atras")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if input_dir != Vector2.ZERO:

		# Mover el personaje
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		# Animación de caminar
		if animation_player.current_animation != "Armature|CAMINANDO":
			animation_player.stop()
			animation_player.play("Armature|CAMINANDO")

	else:

		# Detener el movimiento suavemente
		velocity.x = move_toward(velocity.x, 0.0, SPEED * delta * 10)
		velocity.z = move_toward(velocity.z, 0.0, SPEED * delta * 10)

		# Animación Idle
		if animation_player.current_animation != "Armature|QUIETO":
			animation_player.stop()
			animation_player.play("Armature|QUIETO")


	move_and_slide()

func ComprobarAltura():
	if global_position.y <= -15.0:
		Die()


func Die():
	get_tree().reload_current_scene()
	

func AgregarMoneda():
	coins += 1
	$CanvasLayer/Control/Label.text = "Coins: " + str(coins)

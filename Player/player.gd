extends CharacterBody2D

@export var SPEED := 100 
@export var GRAVITY: int = 400
@export var TERMINAL_VELOCITY: int = 600
@export var JUMP_STRENGTH: int = -200


func _process(_delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * _delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = TERMINAL_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func attack() -> void :
	if (Input.is_action_just_pressed("attack")):
		$AnimatedSprite2D.play("Attacking")
		$AttackBox/CollisionShape2D.disabled = false


	move_and_slide()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Enemies")):
		$StatsComponents.HEALTH -=1

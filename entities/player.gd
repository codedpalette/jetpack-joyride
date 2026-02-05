extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _draw() -> void:
    var rect = collision_shape.shape.get_rect()
    draw_rect(rect, Color.GREEN)
    draw_rect(rect, Color.BLACK, false, 2.0)


func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    # Handle jump.
    if Input.is_action_pressed("ui_accept"):
        velocity.y = JUMP_VELOCITY # TODO: Acceleration

    # Move until reaching fixed position, afterwards the background will move.
    if position.x < 0:
        velocity.x = SPEED
    else:
        velocity.x = 0
    move_and_slide()

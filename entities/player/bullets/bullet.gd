class_name Bullet
extends CharacterBody2D

const SPEED := 800.0
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
signal collided

func _draw() -> void:
    var shape: CircleShape2D = collision_shape.shape
    draw_circle(Vector2.ZERO, shape.radius, Color.WHITE)
    draw_circle(Vector2.ZERO, shape.radius, Color.BLACK, false, 1.0, true)


func _physics_process(delta: float) -> void:
    var collision = move_and_collide(velocity * SPEED * delta)
    if collision:
        collided.emit()

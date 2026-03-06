class_name Player
extends CharacterBody2D

@export_range(500, 2000, 1) var gravity := 1000.0
@export_range(500, 2000, 1) var jump := 1200.0

func _physics_process(delta: float) -> void:
    var acceleration := Vector2.DOWN * gravity
    if Input.is_action_pressed("shoot"):
        acceleration = Vector2.UP * jump
    velocity += acceleration * delta
    move_and_slide()

func die() -> void:
    print("Player died")
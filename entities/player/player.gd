class_name Player
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
const JUMP_FORCE := 2000.0
const GRAVITY := 2000.0
const MAX_VELOCITY := 800.0

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("shoot"):
        velocity.y = 0

func _process(_delta: float) -> void:
    if is_on_floor():
        animated_sprite.play("walk")
    elif Input.is_action_pressed("shoot"):
        animated_sprite.play("fly")
    else:
        animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
    var acceleration := Vector2.ZERO
    if Input.is_action_pressed("shoot"):
        acceleration = Vector2.UP * JUMP_FORCE
    elif not is_on_floor():
        acceleration = Vector2.DOWN * GRAVITY
    velocity += acceleration * delta
    velocity.y = clamp(velocity.y, -MAX_VELOCITY, MAX_VELOCITY)
    move_and_slide()

func die() -> void:
    print("Player died")
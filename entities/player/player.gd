class_name Player
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var bullet_timer: Timer = $BulletTimer
@onready var bullet_emitter: Node2D = $BulletEmitter
var bullet_scene := preload("res://entities/player/bullets/bullet.tscn")
var bullets: Array[Bullet] = []

const JUMP_FORCE := 2000.0
const GRAVITY := 2000.0
const MAX_VELOCITY := 800.0

func die() -> void:
    print("Player died")

func _ready() -> void:
    for i in range(5):
        _create_bullet()
    bullet_timer.timeout.connect(func(): _shoot_bullet())

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("shoot"):
        velocity.y = 0
        _shoot_bullet()
        bullet_timer.start()
    elif event.is_action_released("shoot"):
        bullet_timer.stop()

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

func _shoot_bullet() -> void:
    var bullet := _try_get_bullet()
    bullet.position = (get_parent() as Node2D).to_local(to_global(bullet_emitter.position))
    #bullet.position = bullet_emitter.position
    bullet.velocity = Vector2.DOWN.rotated(deg_to_rad(randf_range(-15, 15)))
    #add_child(bullet)
    add_sibling(bullet)

func _try_get_bullet() -> Bullet:
    if bullets.is_empty():
        _create_bullet()
    return bullets.pop_front()

func _create_bullet() -> Bullet:
    var bullet: Bullet = bullet_scene.instantiate()
    bullet.collided.connect(func(): bullet.get_parent().remove_child(bullet))
    bullet.tree_exited.connect(func(): bullets.append(bullet))
    bullets.append(bullet)
    return bullet
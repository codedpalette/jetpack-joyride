class_name Player
extends CharacterBody2D

signal died
const JUMP_FORCE := 2000.0
const GRAVITY := 2000.0
const MAX_VELOCITY := 800.0
var bullet_scene := preload("res://entities/player/bullets/bullet.tscn")
var bullets_pool: Array[Bullet] = []
var _dead := false
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var bullet_timer: Timer = $BulletTimer
@onready var bullet_emitter: Node2D = $BulletEmitter

func _ready() -> void:
    for i in range(5):
        _create_bullet()
    bullet_timer.timeout.connect(func(): _shoot_bullet())

func _process(_delta: float) -> void:
    if _dead: return
    if is_on_floor():
        animated_sprite.play("walk")
    elif Input.is_action_pressed("shoot"):
        animated_sprite.play("fly")
        if bullet_timer.is_stopped():
            velocity.y = 0
            _shoot_bullet()
            bullet_timer.start()
    else:
        animated_sprite.play("idle")
        if not bullet_timer.is_stopped():
            bullet_timer.stop()

func _physics_process(delta: float) -> void:
    var acceleration := Vector2.ZERO
    if Input.is_action_pressed("shoot") and not _dead:
        acceleration = Vector2.UP * JUMP_FORCE
    elif not is_on_floor():
        acceleration = Vector2.DOWN * GRAVITY
    velocity += acceleration * delta
    velocity.y = clamp(velocity.y, -MAX_VELOCITY, MAX_VELOCITY)
    move_and_slide()

func reset() -> void:
    _dead = false
    position = Vector2.ZERO
    velocity = Vector2.ZERO
    var parent := get_parent()
    for sibling in parent.get_children():
        if sibling is Bullet:
            parent.remove_child(sibling)

func die() -> void:
    if _dead: return
    _dead = true
    animated_sprite.play("dead")
    bullet_timer.stop()
    died.emit()

func _shoot_bullet() -> void:
    var bullet := _try_get_bullet()
    add_sibling(bullet)
    bullet.global_position = bullet_emitter.global_position
    bullet.velocity = Vector2.DOWN.rotated(deg_to_rad(randf_range(-15, 15)))

func _try_get_bullet() -> Bullet:
    if bullets_pool.is_empty():
        _create_bullet()
    return bullets_pool.pop_front()

func _create_bullet() -> Bullet:
    var bullet: Bullet = bullet_scene.instantiate()
    bullet.collided.connect(func(): bullet.get_parent().remove_child(bullet))
    bullet.tree_exited.connect(func(): bullets_pool.append(bullet))
    bullets_pool.append(bullet)
    return bullet
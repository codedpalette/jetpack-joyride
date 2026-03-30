class_name Obstacle
extends Area2D

signal exited_screen
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

enum ObstacleType {SMALL, MEDIUM, LARGE}
const BASE_LINEAR_SPEED := 400.0
const BASE_ROTATION_SPEED := 180.0 # degrees per second

var type: ObstacleType
var linear_speed: float
var rotation_speed: float

func _ready() -> void:
    if not type:
        type = ObstacleType.SMALL
    var scale_factor := 1.0
    match type:
        ObstacleType.SMALL:
            linear_speed = BASE_LINEAR_SPEED * 1.5
            rotation_speed = BASE_ROTATION_SPEED * 2.0
            scale_factor = 0.75
        ObstacleType.MEDIUM:
            linear_speed = BASE_LINEAR_SPEED
            rotation_speed = BASE_ROTATION_SPEED
        ObstacleType.LARGE:
            linear_speed = BASE_LINEAR_SPEED * 0.75
            rotation_speed = BASE_ROTATION_SPEED * 0.5
            scale_factor = 1.5
    (collision_shape.shape as CircleShape2D).radius *= scale_factor
    sprite.scale *= scale_factor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    position.x -= linear_speed * delta
    sprite.rotation_degrees -= rotation_speed * delta

func _on_body_entered(body: Node2D) -> void:
    if body is Player:
        (body as Player).die()
    elif body is Bullet:
        (body as Bullet).collided.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    exited_screen.emit()

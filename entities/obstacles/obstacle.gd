class_name Obstacle
extends Area2D

signal exited_screen
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
const speed := 400.0
const rotation_speed := 360.0 # degrees per second

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    position.x -= speed * delta
    sprite.rotation_degrees -= rotation_speed * delta
    

func _on_body_entered(body: Node2D) -> void:
    if body is Player:
        (body as Player).die()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    exited_screen.emit()

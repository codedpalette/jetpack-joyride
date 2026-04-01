class_name Background
extends Polygon2D

var speed := Obstacle.BASE_LINEAR_SPEED
var is_moving := false

func _process(delta: float) -> void:
    if is_moving:
        texture_offset.x += speed * delta

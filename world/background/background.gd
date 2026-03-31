class_name Background
extends Polygon2D

var speed := 300.0
var is_moving := false

func _process(delta: float) -> void:
    if is_moving:
        texture_offset.x += speed * delta

class_name Background
extends Polygon2D

var speed := 300.0
var is_moving := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if is_moving:
        texture_offset.x += speed * delta

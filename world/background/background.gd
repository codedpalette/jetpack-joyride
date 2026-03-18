extends Polygon2D

var speed := 300.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    texture_offset.x += speed * delta

extends CharacterBody2D

@export_range(500, 2000, 1) var gravity := 1000.0
@export_range(500, 2000, 1) var jump := 1200.0
#@onready var collision_shape: CollisionShape2D = $CollisionShape2D

# func _draw() -> void:
#     var rect := collision_shape.shape.get_rect()
#     draw_rect(rect, Color.GREEN)
#     draw_rect(rect, Color.BLACK, false, 2.0)

func _physics_process(delta: float) -> void:
    var acceleration := Vector2.DOWN * gravity
    if Input.is_action_pressed("ui_accept"):
        acceleration = Vector2.UP * jump
    velocity += acceleration * delta
    move_and_slide()

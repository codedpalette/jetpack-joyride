@tool
extends StaticBody2D

@export var normal: Vector2 = Vector2.UP
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
    _set_normal()

func _process(_delta: float) -> void:
    if Engine.is_editor_hint():
        _set_normal()

func _set_normal():
    var shape: WorldBoundaryShape2D = collision_shape.shape
    shape.normal = normal
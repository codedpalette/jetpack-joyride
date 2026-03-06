extends Path2D

@onready var path_follow: PathFollow2D = $PathFollow2D
var obstacle_scene := preload("res://entities/obstacles/obstacle.tscn")
var obstacle_pool: Array[Obstacle] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for i in range(5):
        var obstacle: Obstacle = obstacle_scene.instantiate()
        obstacle.exited_screen.connect(_on_obstacle_exited_screen.bind(obstacle))
        obstacle_pool.append(obstacle)

func _on_obstacle_exited_screen(obstacle: Obstacle) -> void:
    remove_child(obstacle)
    obstacle_pool.append(obstacle)

func _on_timer_timeout() -> void:
    path_follow.progress_ratio = randf()
    var obstacle: Obstacle = obstacle_pool.pop_front()
    obstacle.position = path_follow.position
    add_child(obstacle)

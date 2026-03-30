class_name ObstacleSpawner
extends Path2D

@onready var path_follow: PathFollow2D = $PathFollow2D
@onready var timer: Timer = $Timer
var obstacle_scene := preload("res://entities/obstacles/obstacle.tscn")
var obstacle_pool: Array[Obstacle] = []
var obstacle_types: Array[Obstacle.ObstacleType] = [
    Obstacle.ObstacleType.SMALL,
    Obstacle.ObstacleType.MEDIUM,
    Obstacle.ObstacleType.LARGE
]

func start() -> void:
    for child in get_children():
        if child is Obstacle:
            remove_child(child)
    timer.start()

func stop() -> void:
    timer.stop()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for i in range(5):
        _create_obstacle()

func _on_timer_timeout() -> void:
    path_follow.progress_ratio = randf()
    var obstacle := _try_get_obstacle()
    obstacle.position = path_follow.position
    obstacle.type = obstacle_types.pick_random()
    add_child(obstacle)
    timer.wait_time = randf_range(0.5, 1.5)

func _try_get_obstacle() -> Obstacle:
    if obstacle_pool.is_empty():
        _create_obstacle()
    return obstacle_pool.pop_front()

func _create_obstacle() -> Obstacle:
    var obstacle: Obstacle = obstacle_scene.instantiate()
    obstacle.exited_screen.connect(func(): remove_child(obstacle))
    obstacle.tree_exited.connect(func(): obstacle_pool.append(obstacle))
    obstacle_pool.append(obstacle)
    return obstacle
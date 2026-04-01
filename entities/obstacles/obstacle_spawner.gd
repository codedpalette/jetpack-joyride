class_name ObstacleSpawner
extends Path2D

const OBSTACLE_SPACING := 0.2
var obstacle_scene := preload("res://entities/obstacles/obstacle.tscn")
var obstacle_pool: Array[Obstacle] = []
var obstacle_types: Array[Obstacle.ObstacleType] = [
    Obstacle.ObstacleType.SMALL,
    Obstacle.ObstacleType.MEDIUM,
    Obstacle.ObstacleType.LARGE
]
var prev_path_position: float = 0.0
var random: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var path_follow: PathFollow2D = $PathFollow2D
@onready var timer: Timer = $Timer

func _ready() -> void:
    for i in range(5):
        _create_obstacle()

func start() -> void:
    for child in get_children():
        if child is Obstacle:
            remove_child(child)
    timer.start()

func stop() -> void:
    timer.stop()

func _on_timer_timeout() -> void:
    path_follow.progress_ratio = _get_next_spawn_position()
    var obstacle := _try_get_obstacle()
    obstacle.position = path_follow.position
    obstacle.type = obstacle_types[random.rand_weighted([0.5, 1, 1])]
    add_child(obstacle)
    timer.wait_time = randf_range(0.5, 1)


func _get_next_spawn_position() -> float:
    while true:
        var candidate_position := clampf(randf_range(0.0, 1.25), 0.0, 1.0) # Bias towards the bottom
        if abs(candidate_position - prev_path_position) > OBSTACLE_SPACING:
            prev_path_position = candidate_position
            return candidate_position
    return 0.0

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
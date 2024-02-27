extends Path2D

const METEOR = preload("res://Hazards/meteor.tscn")

@export var speed := 1000.0

@onready var player: Player = $".."
@onready var enemy_spawn_location: PathFollow2D = $EnemySpawnLocation

var random_meteor := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_rotation = 0
		
func spawn_meteor() -> void:	
	var meteor := METEOR.instantiate()
	
	enemy_spawn_location.progress_ratio = randf()
		
	meteor.global_position = enemy_spawn_location.global_position
	meteor.linear_velocity = meteor.global_position.direction_to(player.global_position) * speed
	meteor.connect("player_hit", on_meteor_player_hit)	
	
	add_child(meteor)
	
func on_meteor_player_hit() -> void:
	player.damage()
	

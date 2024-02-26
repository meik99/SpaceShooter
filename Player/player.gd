extends RigidBody2D
class_name Player

@export var speed := 1000.0
@export var torgue := PI * 2
@export var deacceleration := 1
@export var acceleration := 1
@export var turn_speed := 1
@export var projectile: PackedScene	

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var projectile_spawn: Node2D = $ProjectileSpawn

func _process(delta: float) -> void:
	if Input.is_action_pressed("player_action"):
		animation_player.play("shot")

func shoot():
	if projectile != null:
		var shot := projectile.instantiate() as Shot
		
		if shot != null:
			animation_player.get_animation("shot").length = shot.fire_rate
			shot.shoot(self)
		

func _physics_process(delta: float) -> void:	
	if Input.is_action_pressed("player_accelerate"):
		linear_velocity = lerp(linear_velocity, transform.y.normalized() * -speed, acceleration * delta)
	elif Input.is_action_pressed("player_deaccelerate"):
		linear_velocity = lerp(linear_velocity, transform.y.normalized() * speed, deacceleration * delta)		
	
	if Input.is_action_pressed("player_left"):
		angular_velocity = lerp(angular_velocity, angular_velocity - torgue, turn_speed * delta)
	elif Input.is_action_pressed("player_right"):
		angular_velocity = lerp(angular_velocity, angular_velocity + torgue, turn_speed * delta)


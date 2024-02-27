extends RigidBody2D
class_name Player

@export var speed := 1000.0
@export var torgue := PI * 2
@export var deacceleration := 1
@export var acceleration := 1
@export var turn_speed := 1
@export var projectile: PackedScene	
@export var max_health := 3

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var projectile_spawn: Node2D = $ProjectileSpawn
@onready var slightly_damaged: Sprite2D = $Damage/SlightlyDamaged
@onready var damaged: Sprite2D = $Damage/Damaged
@onready var very_damaged: Sprite2D = $Damage/VeryDamaged
@onready var explosion: AnimatedSprite2D = $Explosion

@onready var thruster: AudioStreamPlayer2D = $Thruster
@onready var shot_sound: AudioStreamPlayer2D = $Shot

@onready var health := max_health

func _process(delta: float) -> void:
	if Input.is_action_pressed("player_action"):
		animation_player.play("shot")

func shoot():
	if projectile != null:
		var shot := projectile.instantiate() as Shot
		
		if shot != null:
			shot_sound.play()
			animation_player.get_animation("shot").length = shot.fire_rate
			shot.shoot(self)

func damage() -> void:
	health -= 1
	explosion.play("explosion")
	slightly_damaged.visible = health < max_health * 0.75
	damaged.visible = health < max_health * 0.5
	very_damaged.visible = health < max_health * 0.25
		
	

func _physics_process(delta: float) -> void:	
	if Input.is_action_pressed("player_accelerate"):
		thruster_play()
		linear_velocity = lerp(linear_velocity, transform.y.normalized() * -speed, acceleration * delta)
	elif Input.is_action_pressed("player_deaccelerate"):
		thruster_play()
		linear_velocity = lerp(linear_velocity, transform.y.normalized() * speed, deacceleration * delta)		
	else:
		thruster.stop()
	
	if Input.is_action_pressed("player_left"):
		angular_velocity = lerp(angular_velocity, angular_velocity - torgue, turn_speed * delta)
	elif Input.is_action_pressed("player_right"):
		angular_velocity = lerp(angular_velocity, angular_velocity + torgue, turn_speed * delta)

func thruster_play():
	if not thruster.playing:
		thruster.play()

extends RigidBody2D

signal player_hit

@onready var explosion: AnimatedSprite2D = $Explosion
@onready var sprite: Sprite2D = $Sprite

@onready var explosion_sound: AudioStreamPlayer2D = $ExplosionSound

var rotation_speed := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation_speed = PI * randf_range(-2, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	angular_velocity = rotation_speed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:	
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and sprite.visible:
		player_hit.emit()
		explode()
	if area.get_parent() is Shot:
		explode()
		area.get_parent().queue_free()

func explode():
	sprite.visible = false
	explosion_sound.play()
	explosion.play("explosion")
	explosion.animation_finished.connect(free)
	
func free():
	queue_free()
	

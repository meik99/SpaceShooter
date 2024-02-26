extends RigidBody2D
class_name Shot

@export var fire_rate := 1 / 10.0
@export var projectile_speed := 1000

func shoot(player: Player) -> void:
	player.add_child(self)
	
	global_position = player.projectile_spawn.global_position
	linear_velocity = -player.transform.y.normalized() * projectile_speed + player.linear_velocity
	rotation = player.rotation


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
		

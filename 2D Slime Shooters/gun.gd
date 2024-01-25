extends Area2D


func _ready():
	Signals.connect("FasterShootingPowerUp",FasterShootingPowerUp)
	Signals.connect("FasterShootingCooldown", FasterShootingCooldown)
	
func FasterShootingCooldown():
	%ShootTimer.wait_time = 0.7
	
func FasterShootingPowerUp():
	%ShootTimer.wait_time = 0.1

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)


func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()	###creates a copy of the preload scene (in this case BULLET)
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)


func _on_timer_timeout():
	shoot()

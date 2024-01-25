extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		queue_free()
		Signals.emit_signal("FasterShootingPowerUp")



func _on_power_up_cooldown_timer_timeout():
	Signals.emit_signal("FasterShootingCooldown")

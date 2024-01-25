extends Node2D

signal mob_spawned

func _process(delta):
	if Input.is_action_pressed("Esc"):
		pause_game()

func pause_game():
	$PausedScreen.visible = true
	get_tree().paused = true

func resume_game():
	$PausedScreen.visible = false
	get_tree().paused = false

func spawn_faster_shooting_powerup():
	var faster_shooting_powerup = preload("res://faster_shooting.tscn").instantiate()
	%PowerUpFollow.progress_ratio = randf()
	faster_shooting_powerup.global_position = %PowerUpFollow.global_position
	add_child(faster_shooting_powerup)
	
func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_timer_timeout():
	spawn_mob()
	mob_spawned.emit()

func _on_player_health_depleted():
	$GameOver.visible = true
	get_tree().paused = true

func _on_resume_pressed():
	### To make the resume work I went to the PauseCanvas layer. Then the inspector panel and in the
	### process, mode 'Always'
	resume_game()
	
func _on_quit_button_pressed():
	get_tree().quit()

func _on_powerup_timer_timeout():
	spawn_faster_shooting_powerup()

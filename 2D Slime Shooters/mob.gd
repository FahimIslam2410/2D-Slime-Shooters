extends CharacterBody2D

var health = 2
const SPEED = 400

### This is a hardcoded way of get the information from player node using #Remote' tab ->
### in the scene component and working from /root
	### var player
	
	### The _ready function waits for all the nodes to be created first
	### func _ready():
	### player = get_node("/root/Game/Player")

	### Alternative way to do the same thing on one line
@onready var player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk()


func _physics_process(delta):
	### global_position where the sprite(mob in this case) is in the world
	### .direction_to() calculates direction point to "player"
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * SPEED
	move_and_slide()

func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		queue_free()

		const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		Signals.emit_signal("MobDeaths")

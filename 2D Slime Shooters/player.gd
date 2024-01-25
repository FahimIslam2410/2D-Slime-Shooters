extends CharacterBody2D

signal health_depleted

var health = 100.0
var mob_spawned = 0
var mob_killed = 0
const DAMAGE_RATE = 20.0

func _ready():
	Signals.connect("MobDeaths",MobDeaths)


func MobDeaths():
	mob_killed += 1
	%MobDeathLabel.text = "Mobs Killed: " + str(mob_killed)

func _physics_process(delta):
	var directon = Input.get_vector("Left","Right","Up","Down")
	velocity = directon * 600	### Moves in the input direction for x pixels per second
	move_and_slide() ### Calls builtin function to move the character

	### Using get_node calls the HappyBoo Node and then can call funcions in that node
	### for example get_node("HappyBoo").play_walk_animation()
	
	if velocity.length() > 0.0:
	### Adding a unqiue modify name (prefixed with %) only give access to that node within the given scene
		%HappyBoo.play_walk_animation()	
	else:
		%HappyBoo.play_idle_animation()
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()


func _on_game_mob_spawned():
	mob_spawned += 1
	%MobSpawnedLabel.text = "Mob Spawned: " + str(mob_spawned)

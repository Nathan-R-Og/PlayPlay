extends CharacterBody3D
class_name Pet
@onready var navigation:NavigationAgent3D = $nav
var SPEED = 2
var timer:SceneTreeTimer = null

enum behaviors {
	None = 0,
	Wander = 1,
	Interact = 2,
}
var behavior = behaviors.Wander

func _physics_process(delta):
	match behavior:
		behaviors.Wander:
			var current = position
			var next = navigation.get_next_path_position()
			var newV = (next - current).normalized() * SPEED
			if navigation.is_navigation_finished():
				var s = Vector2(velocity.x, velocity.z).move_toward(Vector2.ZERO, .1)
				velocity = Vector3(s.x, velocity.y, s.y)
			else: velocity = newV
			move_and_slide()
	physInteract()

func _process(delta):
	match behavior:
		behaviors.Wander:
			if timer == null or timer.time_left == 0.0:
				navigation.target_position = Vector3(randf_range(-4, 4),0,randf_range(-4, 4))
				timer = get_tree().create_timer(randf_range(1, 5))

## Applies impulse to RigidBodies if colliding with the collision.
func physInteract():
	for col_id in get_slide_collision_count():
		var col := get_slide_collision(col_id)
		if col.get_collider() is RigidBody3D:
			var pushPower = 0.0075
			col.get_collider().apply_central_impulse(-col.get_normal() * pushPower)
			col.get_collider().apply_impulse(-col.get_normal() * pushPower, col.get_position())

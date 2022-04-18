extends KinematicBody2D

var vector = Vector2()
func _physics_process(delta):
	var space = get_world_2d().direct_space_state
	var result = space.intersect_ray(global_position, Vector2.ZERO , [self])
	if result:
		print("colisiono", result.collider)

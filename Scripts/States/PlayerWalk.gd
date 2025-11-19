extends State
class_name Walk

func Enter():
	state_machine.anim.play("Run")

func Physics_Update(delta):
	var input_dir = Input.get_action_strength("ui_right") \
				  - Input.get_action_strength("ui_left")

	# Gravity
	if not player.is_on_floor():
		player.velocity.y = min(
			player.velocity.y + player.gravity * delta,
			player.max_fall_speed
		)
	else:
		player.velocity.y = 0

	# Transition back to Idle
	if input_dir == 0:
		Transitioned.emit(self, "Idle")
		return

	# Smooth 1D movement
	var target_speed = input_dir * player.move_speed

	if input_dir != 0:
		player.velocity.x = move_toward(
			player.velocity.x, target_speed,
			player.accel_ground * delta
		)
	else:
		player.velocity.x = move_toward(
			player.velocity.x, 0,
			player.decel_ground * delta
		)

	# Flip sprite
	if input_dir != 0:
		player.scale.x = -1 if input_dir < 0 else 1

	player.move_and_slide()

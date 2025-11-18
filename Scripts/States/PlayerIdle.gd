extends State
class_name Idle

func Enter():
	state_machine.anim.play("idle")

func Physics_Update(delta):
	var input_dir = Input.get_action_strength("ui_right") \
				  - Input.get_action_strength("ui_left")

	# Gravity (reading from Player)
	if not player.is_on_floor():
		player.velocity.y = min(
			player.velocity.y + player.gravity * delta,
			player.max_fall_speed
		)
	else:
		player.velocity.y = 0

	if input_dir != 0:
		Transitioned.emit(self, "Walk")

	player.move_and_slide()

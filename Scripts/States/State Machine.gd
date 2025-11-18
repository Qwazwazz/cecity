extends Node
class_name StateMachine

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

var player: Player
var anim: AnimationPlayer

func _ready():
	player = get_parent() as Player
	anim = player.get_node("AnimationPlayer")
	
	# assign states by name
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			child.player = get_parent()
			child.state_machine = self
	
	# enter starting state
	if initial_state:
		current_state = initial_state
		current_state.Enter()

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name):
	# ignore transitions from inactive states
	if state != current_state:
		return
	
	# find new state
	var new_state: State = states.get(new_state_name.to_lower())
	if new_state == null:
		return
	
	# perform transition
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	
	current_state = new_state

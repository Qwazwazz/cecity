extends Node
class_name State

signal Transitioned(state, new_state_name)

var player : Player
var state_machine

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass

func  handle_input(event: InputEvent):
	pass

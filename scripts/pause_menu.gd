extends Control

signal pause(node_to_unpause)
signal unpause
signal any_action
signal menu

func _ready() -> void:
	pause.connect(f_pause)
	unpause.connect(func(): any_action.emit())
	menu.connect(func(): any_action.emit())
	%menu_button.pressed.connect(func(): menu.emit())
	%continue_button.pressed.connect(func(): unpause.emit())

func f_pause(node):
	self.visible = true
	await any_action
	self.visible = false
	node.process_mode = Node.PROCESS_MODE_INHERIT
	

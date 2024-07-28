extends CharacterBody2D

@onready var interaction_area = $InteractionArea

const lines = [
	"HELLOOO!",
	"HOW YOU DOING?",
	"WHICH UPGRADE DO YOU WANT TO BUY?\n    [1] +ATTACK\n    [2] +SPEED\n    [3] +HEALTH\n    [E] NONE"
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished

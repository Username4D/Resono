extends BasicMenu

signal next
signal menu
signal retry

@export var coins = 0
@export var max_coins = 0

func post_ready() -> void:
	%menu_button.pressed.connect(func(): menu.emit())
	%next_button.pressed.connect(func(): next.emit())
	%retry_button.pressed.connect(func(): retry.emit())

func _process(delta: float) -> void:
	$menu/content/coins.text = "Coins: %d / %d" % [coins, max_coins]

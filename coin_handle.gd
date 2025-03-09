extends RichTextLabel
@export var coins: int
var score = 0

func _process(delta):
	coins = 0
	var coinamount = str(coins)
	text = "Coins:" + coinamount

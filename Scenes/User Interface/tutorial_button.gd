extends RichTextLabel

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Tutorial/Tutorial.tscn")

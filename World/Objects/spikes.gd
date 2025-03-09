extends StaticBody2D

signal touching_spikes

func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		touching_spikes.emit()

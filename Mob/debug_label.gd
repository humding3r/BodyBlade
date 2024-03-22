extends Label

func _on_base_hit_taken(area):
	if not area: return
	text = str("Owie! I took ",  area.owner.damage_value, " damage!")
	show()
	await get_tree().create_timer(1).timeout
	hide()

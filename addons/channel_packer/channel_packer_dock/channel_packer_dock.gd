tool
extends Control

signal texture_packed(texture)

var selected_size := Vector2(1024, 1024)

onready var size_option_button := $VBoxContainer/TopBar/SizeOptionButton
onready var channel_packer_viewport := $ChannelPackerViewport
onready var red_texture_slot := $VBoxContainer/PanelContainer/TextureSlotContainer/RedTextureSlot
onready var green_texture_slot := $VBoxContainer/PanelContainer/TextureSlotContainer/GreenTextureSlot
onready var blue_texture_slot := $VBoxContainer/PanelContainer/TextureSlotContainer/BlueTextureSlot

func _ready() -> void:
	# Generate result size options.
	for index in 8:
		var size := pow(2, index + 4)
		size_option_button.add_item(str(size))
		size_option_button.set_item_metadata(index, Vector2.ONE * size)
	size_option_button.select(6)


func _on_SizeOptionButton_item_selected(index : int) -> void:
	selected_size = size_option_button.get_item_metadata(index)


func _on_PackButton_pressed() -> void:
	var result : Image = yield(channel_packer_viewport.pack(
			red_texture_slot.texture, green_texture_slot.texture,
			blue_texture_slot.texture, selected_size), "completed")
	emit_signal("texture_packed", result)

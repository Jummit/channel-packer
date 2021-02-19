tool
extends ColorRect

export var channel_name : String setget set_channel_name

var texture : Texture setget set_texture

func can_drop_data(_position : Vector2, data) -> bool:
	return "type" in data and data.type == "files"


func drop_data(_position : Vector2, data) -> void:
	set_texture(load(data.files[0]))


func set_texture(to):
	texture = to
	$VBoxContainer/ImageTexture.texture = texture


func set_channel_name(to) -> void:
	channel_name = to
	$VBoxContainer/Label.text = channel_name

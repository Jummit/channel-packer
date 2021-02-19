tool
extends EditorPlugin

var channel_packer_dock := preload("res://addons/channel_packer/channel_packer_dock/channel_packer_dock.tscn").instance()
var file_dialog := EditorFileDialog.new()

func _enter_tree() -> void:
	channel_packer_dock.connect("texture_packed", self, "_on_ChannelPackerDock_texture_packed")
	add_control_to_bottom_panel(channel_packer_dock, "Channel Packer")
	get_editor_interface().get_base_control().add_child(file_dialog)


func _exit_tree() -> void:
	remove_control_from_bottom_panel(channel_packer_dock)
	file_dialog.queue_free()


func _on_ChannelPackerDock_texture_packed(texture : Image) -> void:
	file_dialog.mode = EditorFileDialog.MODE_SAVE_FILE
	file_dialog.add_filter("*.png; Images")
	file_dialog.popup_centered_ratio()
	var path : String = yield(file_dialog, "file_selected")
	texture.save_png(path)
	get_editor_interface().get_resource_filesystem().scan()

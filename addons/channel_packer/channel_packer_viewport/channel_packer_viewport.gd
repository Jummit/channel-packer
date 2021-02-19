tool

extends Viewport
onready var material : ShaderMaterial = $PackedTexture.material

func pack(r : Texture, g : Texture, b : Texture,
		result_size : Vector2) -> ViewportTexture:
	size = result_size
	material.set_shader_param("r", r)
	material.set_shader_param("g", g)
	material.set_shader_param("b", b)
	render_target_update_mode = Viewport.UPDATE_ONCE
	yield(VisualServer, "frame_post_draw")
	# Convert image to opaque format manually, because the format is RGBA8 even
	# though `transparent_bg` is false.
	var image := get_texture().get_data()
	image.convert(Image.FORMAT_RGB8)
	return image

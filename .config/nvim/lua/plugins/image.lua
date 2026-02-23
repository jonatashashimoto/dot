return {
	"3rd/image.nvim",
	build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
	opts = {
		backend = "kitty",
		processor = "magick_cli",

		max_width = 10,
		max_height = 10,

		-- max_width_window_percentage = nil,
		-- max_height_window_percentage = nil,
		scale_factor = 1.0,
		-- 3. BLOQUEIO DE ATUALIZAÇÃO (Evita recalcular ao mudar painel/janela)
		window_overlap_clear_enabled = false,
		editor_only_render_when_focused = true,

		integrations = {
			markdown = {
				enabled = true,
				download_remote_images = true,
				only_render_image_at_cursor = true,
				only_render_image_at_cursor_mode = "popup", -- Mantém o popup
				floating_windows = true,
				max_width = 10,
				max_height = 10,
			},
		},
	},
}

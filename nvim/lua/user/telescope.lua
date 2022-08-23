local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then
  return
end

telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    layout_config = {
      flex = {
        prompt_position = 'bottom',
        flip_columns = 180,
        flip_lines = 60,
        horizontal = {
          preview_width = 0.6,
        },
        vertical = {
          preview_height = 0.45,
        },
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  }
}

telescope.load_extension('fzy_native')

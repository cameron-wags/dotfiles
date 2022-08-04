local telescope_ok, telescope = pcall(require, 'telscope')
if not telescope_ok then
  return
end

telescope.setup {
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  }
}

telescope.load_extension('fzy_native')


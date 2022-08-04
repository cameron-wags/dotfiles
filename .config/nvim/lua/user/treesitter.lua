local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "bash",
    "c",
    "css",
    "go",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "lua",
    "python",
    "regex",
    "rust",
    "typescript",
    "vim",
    "yaml",
  },
  sync_install = false,
  auto_intall = true,
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  matchup = { enable = true },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 1000,
  },
  refactor = {
    smart_rename = { enable = true, keymaps = { smart_rename = "grr" } },
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    navigation = {
      enable = true,
      goto_definition = "gnd",
      list_definitions = "gnD",
      list_definitions_toc = "gO",
      goto_next_usage = "<a-*>",
      goto_previous_usage = "<a-#>",
    },
  },
  -- playground = {
  --   enable = false,
  --   persist_queries = false, -- Whether the query persists across vim sessions
  --   keybindings = {
  --     toggle_query_editor = "o",
  --     toggle_hl_groups = "i",
  --     toggle_injected_languages = "t",
  --     toggle_anonymous_nodes = "a",
  --     toggle_language_display = "I",
  --     focus_language = "f",
  --     unfocus_language = "F",
  --     update = "R",
  --     goto_node = "<cr>",
  --     show_help = "?",
  --   },
  -- },
})

return {
	{
		'echasnovski/mini.sessions',
		lazy = false,
		enabled = true,
		config = function()
			require 'mini.sessions'.setup()

			local select_session = function()
				local pickers = require 'telescope.pickers'
				local finders = require 'telescope.finders'
				local conf = require('telescope.config').values
				local actions = require 'telescope.actions'
				local action_state = require 'telescope.actions.state'

				local results = vim.tbl_values(MiniSessions.detected)
				table.sort(results, function(l, r)
					-- intentionally reversed sort for MRU session
					if l.modify_time >= r.modify_time then
						return true
					end
					return false
				end)
				local max_width = 0
				for index, value in ipairs(results) do
					value.idx = index - 1
					if #value.name > max_width then
						max_width = #value.name
					end
				end

				pickers.new({}, {
					layout_strategy = 'center',
					layout_config = {
						center = {
							height = #results + 5,
							width = math.max(max_width + 10, 40),
							prompt_position = 'bottom',
						},
					},
					results_title = 'Sessions',
					prompt_title = '',
					finder = finders.new_table {
						results = results,
						entry_maker = function(entry)
							return {
								value = entry,
								display = entry.idx .. ' ' .. entry.name,
								ordinal = entry.idx .. ' ' .. entry.name,
							}
						end,
					},
					sorter = conf.generic_sorter {},
					attach_mappings = function(prompt_bufnr, map)
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							MiniSessions.read(selection.value.name)
						end)
						return true
					end,
				}):find()
			end

			vim.api.nvim_create_autocmd('VimEnter', {
				callback = function()
					if vim.fn.argc() == 0 and vim.fn.line('$') == 1 and string.find(vim.fn.getline('.'), [[^%s*$]]) ~= nil then
						vim.schedule(select_session)
					end
				end
			})

			vim.api.nvim_create_user_command('Sesh', function()
				local name = string.gsub(vim.fn.getcwd(-1, -1), vim.env.HOME .. '/g/', '')
				local name_clean = string.gsub(name, '/', '_')
				MiniSessions.write(name_clean)
			end, {})

			vim.api.nvim_create_user_command('Seshd', function(opts)
				local name = opts.args
				MiniSessions.delete(name)
			end, {
				nargs = 1,
				complete = function(arg_lead)
					return vim.iter.map(function(t)
						if string.find(t.name, arg_lead, 1, true) ~= nil then
							return t.name
						end
						return nil
					end, vim.tbl_values(MiniSessions.detected))
				end
			})

			vim.api.nvim_create_user_command('Seshs', select_session, {})
		end
	}
}

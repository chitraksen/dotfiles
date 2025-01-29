-- maybe change unix icon to mac - display correctly

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand '%:t') ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand '%:p:h'
          local gitdir = vim.fn.finddir('.git', filepath .. ';')
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      local filesize = {
        -- filesize component
        'filesize',
        cond = conditions.buffer_not_empty,
      }

      local branch = {
        -- change branch icon
        'branch',
        icon = '',
        -- color = { fg = colors.violet, gui = 'bold' },
      }

      local time = {
        function()
          return os.date ' %I:%M%p'
        end,
      } -- get current time

      local lsp_name = {
        -- Lsp server name .
        function()
          local msg = 'No Active Lsp'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = '',
      }

      local diff = {
        'diff',
        diff_color = {
          added = { fg = '#00cc66' },
          modified = { fg = '#70c0c2' },
          removed = { fg = '#ec5f67' },
        },
      }

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 100,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { branch, diff, 'diagnostics' },
          lualine_c = { 'filename', filesize },
          lualine_x = { 'encoding', 'fileformat', 'filetype', lsp_name },
          lualine_y = { 'progress', 'location' },
          lualine_z = { time },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
}

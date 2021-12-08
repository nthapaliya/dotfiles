return require("packer").startup({
  function()
    use({ "wbthomason/packer.nvim", opt = true })

    use("AndrewRadev/splitjoin.vim")
    use("airblade/vim-rooter")
    use("christoomey/vim-tmux-navigator")
    use("justinmk/vim-dirvish")
    use({ "rbgrouleff/bclose.vim", disable = true })
    use("rstacruz/vim-closer")
    use({ "sheerun/vim-polyglot", disable = true })
    use("tommcdo/vim-lion")
    use({ "tpope/vim-commentary", disable = true })
    use("tpope/vim-fugitive")
    use("tpope/vim-repeat")
    use("tpope/vim-rhubarb")
    use("tpope/vim-surround")
    use("tpope/vim-unimpaired")
    use("unblevable/quick-scope")
    use({ "vim-scripts/BufOnly.vim", opt = true, cmd = { "BufOnly" } })
    use("wincent/terminus")
    use("nvim-lua/plenary.nvim")

    use({
      "mhartington/formatter.nvim",
      opt = true,
      cmd = { "FormatWrite" },
      config = function()
        require("formatter").setup({
          filetype = {
            jsonc = {
              function()
                return {
                  exe = "jq",
                  args = { "." },
                  stdin = true,
                }
              end,
            },
            fish = {
              function()
                return {
                  exe = "fish_indent",
                  stdin = true,
                }
              end,
            },
            typescriptreact = {
              function()
                return {
                  exe = "prettier",
                  args = {
                    "--stdin-filepath",
                    vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                    "--single-quote",
                  },
                  stdin = true,
                }
              end,
            },
            lua = {
              function()
                return {
                  exe = "stylua",
                  args = { "--indent-type", "Spaces", "--indent-width", 2, "-" },
                  stdin = true,
                }
              end,
            },
          },
        })
      end,
    })

    use({
      "numToStr/Comment.nvim",
      opt = true,
      requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
      keys = { { "n", "gcc" }, { "n", "gcb" }, { "v", "gc" } },
      config = function()
        require("Comment").setup({
          pre_hook = function(ctx)
            -- Only calculate commentstring for tsx filetypes
            if vim.bo.filetype == "typescriptreact" then
              local U = require("Comment.utils")

              -- Detemine whether to use linewise or blockwise commentstring
              local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

              -- Determine the location where to calculate commentstring from
              local location = nil
              if ctx.ctype == U.ctype.block then
                location = require("ts_context_commentstring.utils").get_cursor_location()
              elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                location = require("ts_context_commentstring.utils").get_visual_start_location()
              end

              return require("ts_context_commentstring.internal").calculate_commentstring({
                key = type,
                location = location,
              })
            end
          end,
        })
      end,
    })

    use({
      "williamboman/nvim-lsp-installer",
      requires = {
        { "neovim/nvim-lspconfig", before = "nvim-lsp-installer" },
        { "hrsh7th/cmp-nvim-lsp", before = "nvim-lsp-installer" },
      },
      config = function()
        -- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
        local on_attach = function(_, bufnr)
          local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
          end
          local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
          end

          -- Enable completion triggered by <c-x><c-o>
          buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

          -- Mappings.
          local opts = {
            noremap = true,
            silent = true,
          }

          buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
          buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
          buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
          buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
          buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
          -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts) -- this!!
          buf_set_keymap("n", "<leader>k", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
          buf_set_keymap("n", "<leader>j", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
          buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
          buf_set_keymap("n", "<leader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

          vim.cmd([[
          augroup Hover
            autocmd!
            autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false})
          augroup end
          ]])
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

        local lsp_installer = require("nvim-lsp-installer")
        lsp_installer.on_server_ready(function(server)
          local opts = {
            on_attach = on_attach,
            flags = {
              debounce_text_changes = 150,
              capabilities = capabilities,
            },
            handlers = {
              ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false,
                underline = false,
              }),
            },
          }

          if server.name == "sumneko_lua" then
            opts.settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                  path = runtime_path,
                },
                diagnostics = {
                  globals = {
                    "runtime_path",
                    "use",
                    "vim",
                  },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                  enable = false,
                },
              },
            }
          end

          server:setup(opts)
        end)
      end,
    })

    use({
      "lewis6991/gitsigns.nvim",
      opt = true,
      before = { "nvim-lua/plenary.nvim" },
      event = "VimEnter",
      config = function()
        require("gitsigns").setup({
          signs = {
            add = { text = "+" },
            change = { text = "~" },
          },
          keymaps = {
            ["n ]c"] = {
              expr = true,
              "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'",
            },
            ["n [c"] = {
              expr = true,
              "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",
            },
            ["n <leader>hr"] = "<cmd>Gitsigns undo_stage_hunk<CR>",
            ["n <leader>hs"] = "<cmd>Gitsigns stage_hunk<CR>",
            ["n <leader>hu"] = "<cmd>Gitsigns reset_hunk<CR>",
            ["v <leader>hs"] = "<cmd>Gitsigns stage_hunk<CR>",
            ["v <leader>hu"] = "<cmd>Gitsigns reset_hunk<CR>",
          },
        })
      end,
    })

    use({
      "nvim-lualine/lualine.nvim",
      opt = true,
      event = "VimEnter",
      config = function()
        require("lualine").setup({
          options = {
            icons_enabled = false,
            theme = "tokyonight",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
          },
          tabline = {
            lualine_a = { "filename" },
            lualine_y = { "buffers" },
            lualine_z = { "tabs" },
          },
        })
      end,
    })

    use({
      "nvim-telescope/telescope.nvim",
      opt = true,
      before = { "nvim-lua/plenary.nvim" },
      cmd = { "Telescope" },
      config = function()
        require("telescope").setup({
          defaults = {
            layout_strategy = "flex",
          },
          pickers = {
            find_files = {
              hidden = true,
              -- path_display = {'shorten'},
            },
            file_browser = {
              hidden = true,
              dir_icon = ">>",
            },
          },
        })
      end,
    })

    use({
      "folke/tokyonight.nvim",
      opt = true,
      event = "VimEnter",
      branch = "main",
      config = function()
        vim.g.tokyonight_colors = {
          gitSigns = {
            add = "#00ff00",
            change = "#00eeff",
            delete = "#ff4b2b",
          },
        }
        vim.cmd([[colorscheme tokyonight]])
      end,
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      run = ":TSUpdate",
    })

    use({
      "andymass/vim-matchup",
      after = "nvim-treesitter",
      config = function()
        require("nvim-treesitter.configs").setup({ matchup = { enable = true } })
      end,
    })

    use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

    use({
      "folke/trouble.nvim",
      opt = true,
      cmd = { "Trouble", "TroubleToggle" },
      config = function()
        require("trouble").setup({
          icons = false,
          fold_open = "v",
          fold_closed = ">",
          indent_lines = false,
          signs = {
            error = "error",
            warning = "warn",
            hint = "hint",
            information = "info",
          },
          use_lsp_diagnostic_signs = false,
        })
      end,
    })

    use({
      { "L3MON4D3/LuaSnip", before = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
    })

    use({
      "hrsh7th/nvim-cmp",
      opt = true,
      event = "InsertEnter *",
      config = function()
        -- Set completeopt to have a better completion experience
        vim.o.completeopt = "menuone,noselect"

        -- luasnip setup
        local luasnip = require("luasnip")

        -- nvim-cmp setup
        local cmp = require("cmp")
        cmp.setup({
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          mapping = {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
            ["<Tab>"] = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end,
            ["<S-Tab>"] = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end,
          },
          sources = {
            { name = "buffer" },
            { name = "luasnip" },
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "path" },
          },
        })
      end,
    })
  end,
  config = {
    display = { open_fn = require("packer.util").float },
    profile = { enable = true },
  },
})

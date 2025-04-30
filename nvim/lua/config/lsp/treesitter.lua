-- Treesitter Configuration
-- Although related to code understanding, often kept separate from pure LSP config.

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
  indent = {
    enable = true,
    -- disable = { "yaml" },
  },
  autotag = {
    enable = true,
  },
  -- Ensure parsers are installed
  ensure_installed = {
    "bash", "c", "cmake", "cpp", "css", "dart", "dockerfile", "go", "html",
    "javascript", "json", "lua", "make", "markdown", "python", "query",
    "rust", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml"
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  auto_install = true,
}

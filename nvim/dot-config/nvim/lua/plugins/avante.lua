return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    provider = "claude",
    auto_suggestions_provider = "claude",
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0,
          max_tokens = 20480,
        },
      },
      --openai = {
      --  endpoint = "https://api.openai.com/v1/chat/completions", -- OpenAI API endpoint
      --  model = "gpt-3.5-turbo", -- Specify the OpenAI model
      --  extra_request_body = {
      --    temperature = 0.7, -- Adjust creativity
      --    max_tokens = 4096, -- Maximum response token limit
      --  },
      --  api_key = vim.env.OPENAI_API_KEY, -- Use an environment variable for security
      --},
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

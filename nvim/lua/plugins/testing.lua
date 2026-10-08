vim.g.neotest_vstest = {
  broad_recursive_discovery = false,
}

local excluded_dirs = {
  node_modules = true,
  ['.git'] = true,
  coverage = true,
  dist = true,
  build = true,
  bin = true,
  obj = true,
}

require('neotest').setup {
  adapters = {
    require 'neotest-jest' {
      -- Uses the existing test script and its project-specific setup.
      jestCommand = 'yarn test --watch=false --watchAll=false --runInBand',

      -- Resolve from the test file, including tests under SPA/client.
      cwd = function(path)
        return vim.fs.root(path, 'package.json') or vim.uv.cwd()
      end,

      env = {
        CI = 'true',
      },

      -- Let the adapter discover the existing Jest configuration.
      -- Do not specify a made-up jest.config.js path.
    },

    require 'neotest-vstest',
  },

  discovery = {
    enabled = true,
    concurrent = 1,
    filter_dir = function(name)
      return not excluded_dirs[name]
    end,
  },

  running = {
    concurrent = false,
  },

  -- Open results when requested.
  output = {
    open_on_run = true,
  },

  -- Preserve your existing quickfix workflow.
  quickfix = {
    enabled = false,
  },

  summary = {
    open = 'botright vsplit | vertical resize 45',
  },

  output_panel = {
    open = 'botright split | resize 15',
  },
}

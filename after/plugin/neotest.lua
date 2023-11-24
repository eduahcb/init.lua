require("neotest").setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = "npm test --"
    }),
    require('neotest-vitest'),
    require("neotest-playwright").adapter({
      options = {
        persist_project_selection = true,
        enable_dynamic_test_discovery = true,
      }
    }),
    require("neotest-rspec")
  },
})

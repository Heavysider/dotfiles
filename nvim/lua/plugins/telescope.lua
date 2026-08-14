-- fzf-native defaults to smart_case: any uppercase in the query forces
-- case-sensitive matching, so CamelCase class names (RecordManagerService)
-- never match their snake_case file paths. Ignore case entirely instead.
return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions = {
        fzf = {
          case_mode = "ignore_case",
        },
      },
    },
  },
}

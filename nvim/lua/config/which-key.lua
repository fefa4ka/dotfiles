local wk = require("which-key")
local gen = require("gen")
-- As an example, we will create the following mappings:
--  * <leader>ff find files
--  * <leader>fr show recent files
--  * <leader>fb Foobar
-- we'll document:
--  * <leader>fn new file
--  * <leader>fe edit file
-- and hide <leader>1

wk.register({
  a = {
    name = "AI", -- optional group name
    m = { function() gen.select_model() end, "Select model" },
    g = { "<cmd>Gen Generate<CR>", "Generate" },
  },
}, { prefix = "<leader>", mode = "n" })

wk.register({
  a = {
    name = "AI", -- optional group name
    s = { "<cmd>'<,'>Gen Summarize<CR>", "Summarize" },
    r = { "<cmd>'<,'>Gen Review_Code<CR>", "Review" }, 
    g = { "<cmd>'<,'>Gen Enhance_Grammar_Spelling<CR>", "Grammar" }, 
    w = { "<cmd>'<,'>Gen Enhance_Wording<CR>", "Wording" }, 
    s = { "<cmd>'<,'>Gen Make_Concise<CR>", "Simple and consise" }, 
    e = { "<cmd>'<,'>Gen Enhance_Code<CR>", "Enhance" }
  },
}, { prefix = "<leader>", mode = "v" })


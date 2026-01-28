return {
  dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h") .. "/trees",
  sep = "-",
  ext = ".tree",
  index = nil,
  notions = nil,
  notations = "macros.tree",
  scratchpad = "scratch.tree",
  id_max = 46655,  -- 4 base36 digits: ZZZZ
  id_size = 4
}



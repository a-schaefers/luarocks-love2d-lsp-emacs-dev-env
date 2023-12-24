package = "lua-starter-example"
version = "dev-1"
source = {
   url = "*** please add URL for source tarball, zip or repository here ***"
}
description = {
   homepage = "https://github.com/a-schaefers/luarocks-love2d-lsp-emacs-dev-env",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.2",
   -- If you depend on other rocks, add them here
   "lume >= 2.3",
   "classic >= 0.1"
}
build = {
   type = "builtin",
   modules = {}
}

-- Use luarocks per project libraries
-- Now both e.g. `lua main.lua` OR simply `love .` will be using the per-project libs from lua-dev-1.rockspec
-- credit: https://leafo.net/guides/customizing-the-luarocks-tree.html#the-install-locations/using-a-custom-directory/quick-guide
-- They say not to do it this way, but they don't give a clear reason why not, and it seems the easiest way to share the libs with love.
-- Atleast during development, this makes a lot of sense... Shipping a finished product might where their warning comes in to play.

local version = _VERSION:match("%d+%.%d+")
package.path = 'lua_modules/share/lua/' .. version .. '/?.lua;lua_modules/share/lua/' .. version .. '/?/init.lua;' .. package.path
package.cpath = 'lua_modules/lib/lua/' .. version .. '/?.so;' .. package.cpath

-- DBG
-- print(package.path)
-- print(package.cpath)

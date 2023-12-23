## luarocks-love2d-lsp-emacs-dev-env

Lua is the programming language.

Luarocks is the lua package manager.

Emacs is the editor.

lua-language-server is the LSP protocol for e.g. linting, findef, and autocompletion.

Love2d is a game engine.

The goal of this setup is to provide the minimal skeleton to:

- Get a lua + love project running with **per-project** managed deps by luarocks available on the PATH to both lua AND `love .`
- Setup lua-language-server and Emacs,  working together in harmony

## SETUP

- Install spartan Emacs, ideally using an Emacs compiled with native-comp and json-serialize support.

```bash
git clone https://github.com/a-schaefers/spartan-emacs.git ~/.emacs.d
cp ~/.emacs.d/spartan-library/spartan-lua.el ~/.emacs.d/spartan.d # Enable the spartan-lua.el library.
```

restart emacs

- Add luarocks global and user-wide libs (and ~/bin ...) to PATH

.bash_profile

```bash
PATH="$HOME/bin:$PATH"
eval "$(luarocks path)" # This bit here is going to get global and user-wide luarocks deps working, but not per-project.
```

Setup terminal to run the shell as a "login shell." From here forward, open Emacs from that terminal, to ensure it gets the environment settings from bash.

So restart Emacs again.

- Install lua luajit luarocks love

```bash
apt install apt install lua luarocks luajit love # pacman should work, too, if that's your thing.
```

- Install lua-language-server from source

```bash
mkdir -p ~/repos
cd ~/repos
git clone https://github.com/LuaLS/lua-language-server.git
cd lua-language-server
./make.sh
```

- Create ~/bin/lua-language-server wrapper on PATH,

```bash
#!/bin/bash
exec "$HOME/repos/lua-language-server/bin/lua-language-server" "$@"
```

- Clone this repo

```
git clone https://github.com/a-schaefers/luarocks-love2d-lsp-emacs-dev-env.git
cd luarocks-love2d-lsp-emacs-dev-env
luarocks init --output /dev/null
luarocks make
```

- Add some library

```
# From within the project root...
luarocks install foo
# ... update .rockspec file by hand ?!?! Luarocks is bad on this part, currently.
```

Now, if `foo` were a library, both `love .` and plain `lua main.lua` will pick it up and know where to find it, in the gitignored project library paths.

But at least, now we have per-project managed dependencies instead of system-wide or user-wide

woof

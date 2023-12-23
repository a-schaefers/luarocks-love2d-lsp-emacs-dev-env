## luarocks-love2d-lsp-emacs-dev-env

The goal of this setup is to provide the minimal skeleton to:

- Get a lua + love project running with **per-project** managed deps by luarocks available on the PATH to both lua AND `love .`
- Setup lua-language-server and Emacs,  working together in harmony

## SETUP

- Install spartan Emacs, ideally using an Emacs compiled with native-comp and json-serialize support.

```bash
git clone https://github.com/a-schaefers/spartan-emacs.git ~/.emacs.d
cp ~/.emacs.d/spartan-library/spartan-lua.el ~/.emacs.d/spartan.d # Enable the spartan-lua.el library.
```

- Setup luver (lua version manager)

https://github.com/MunifTanjim/luver

```bash
export LUVER_DIR="${HOME}/.local/share/luver"
mkdir -p "${LUVER_DIR}"
git clone https://github.com/MunifTanjim/luver.git "${LUVER_DIR}/self"
```

Add to ~/.bashrc

```bash
source "${LUVER_DIR}/self/luver.bash"
```

Setup a lua version

```bash
luver install 5.1.5
luver use 5.1.5
luver install luarocks 3.9.2
```

Helpful tips:

```
luver list-remote # see available lua vers
luver list-remote luarocks # see available luarocks vers
```

So, one thing I found about `luver` is it does not remember your last selection. So what you must do is
every time you want to work on a lua project, in the terminal first you should run: `luver use 5.1.5` for example.

From there, go ahead and open up Emacs with that environment, for sanity, for now.

- Install lua-language-server from source

```bash
mkdir -p ~/repos
cd ~/repos
git clone https://github.com/LuaLS/lua-language-server.git
cd lua-language-server
./make.sh
```

`.bash_profile`,

```bash
PATH="$HOME/bin:$PATH"
```

Setup terminal to run the shell as a "login shell." From here forward, open Emacs from that terminal, to ensure it gets the environment settings from bash.

- Create ~/bin/lua-language-server wrapper on PATH,

```bash
#!/bin/bash
exec "$HOME/repos/lua-language-server/bin/lua-language-server" "$@"
```

Restart emacs now from a new terminal, now finally the dev environment PATH is going to set up the we need.

- Clone this repo

```
git clone https://github.com/a-schaefers/luarocks-love2d-lsp-emacs-dev-env.git
cd luarocks-love2d-lsp-emacs-dev-env
luarocks init --output /dev/null # trying to bootstrap an already started project is tricky, this I found, works.
luarocks make

love .
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

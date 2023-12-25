## luarocks-love2d-lsp-emacs-dev-env

In following all of these arcane steps, I am able to:

1. Switch lua and luarocks (package manager) versions easily
2. Pin luarocks libs to a .rockspec file, and bootstrap it on another machine
3. Have luarocks libraries be installed **per project**, instead of per user or per system
4. Have CLI `lua` be able to find the luarocks project libraries
5. Have `love .` also be able to find the luarocks project libraries
6. Emacs / language-server-protocol is able to make use of both the luarocks project libraries and the love libraries for making solid completion options

Emacs is the least relevant part of all this, it's just how *I* do it.

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

Add to ~/.bashrc AND ~/.bash_profile,

We put it in both because luver and various terminals shell sourcing is janky and we don't have time for this.

```bash
export LUVER_DIR="${LUVER_DIR:-"${XDG_DATA_HOME:-"${HOME}/.local/share"}/luver"}"
source "${LUVER_DIR}/self/luver.bash"
eval "$(luarocks path)"
```

Close / Reopen terminal.

Setup a lua version

```bash
luver install 5.1.5
luver use 5.1.5
luver alias 5.1.5 default
luver install luajit 2.1.ROLLING
luver install luarocks 3.9.2
```

Note that after installing luajit, luver requires you execute a symlink command provided by the stdout.

Regarding versions, lua 5.1.x is to be preferred because that is basically where it seems luajit has ended up.
As we're targeting the love framework, which uses luajit, there we have it.

Helpful tips:

```bash
luver list-remote          # see available lua versions
luver list-remote luarocks # see available luarocks versions
luver list-remote luajit   # see available luajit versions
```

Note: Configuring PATH within Emacs is a pain, and it really just makes a lot sense to be in the habit of opening
Emacs from a separate terminal, which is going to provide the environment in to Emacs from the other terminal.

- Install lua-language-server from source

```bash
mkdir -p ~/repos
cd ~/repos
git clone https://github.com/LuaLS/lua-language-server.git
cd lua-language-server
./make.sh
```

By the way, we're going to use this hardcoded `~/repos/lua-language-server/meta/3rd/love2d/library/love` path in .luarc.json to feed it completions for the love framework. See .luarc.json - It sucks, but oh well.

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

Don't forget `chmod +x ~/bin/lua-language-server`

Completely close both Emacs and the terminal. Restart emacs now from a new terminal, but don't forget to `luver use 5.1.5` in in the terminal before. Haha.

- Install love

```
apt install love
```

- clone this repo

```
git clone https://github.com/a-schaefers/luarocks-love2d-lsp-emacs-dev-env.git
cd luarocks-love2d-lsp-emacs-dev-env
luarocks init --output /dev/null # trying to bootstrap an already started project is tricky, this I found, works.
luarocks make

love .
```

- A typical process to add some new library

```
cd ~/repos/luarocks-love2d-lsp-emacs-dev-env
luver use 5.1.5
# From within the project root...
luarocks install foo
# ... update .rockspec file by hand ?!?! Luarocks is bad on this part, currently. Seriously.
emacs
#  dev dev dev
love . # run game
```

Now, if `foo` were a library, both `love .` and plain `lua main.lua` will pick it up and know where to find it, in the gitignored project library paths.
Likewise language-server-protocol is going to pick up on foo and offer foo.bar.baz types of smart completions.

woof

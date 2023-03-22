
# Nix configuration

- [Nix](#orgcaadaed)
  - [Install Nix](#org7f24ab8)
  - [Run a program with Nix](#orgb716936)
  - [Extra experimental features](#org4a21103)
- [Home Manager](#orgb1b97a3)
  - [Set up Home Manager](#org8de4c29)
  - [Installing packages](#orgcf2d865)
- [Modules](#org5695cd5)
  - [home-manager](#orgbccf5ed)
  - [direnv](#org912a629)
  - [emacs](#org169405d)
  - [git](#org420dd36)
  - [tmux](#org5a7ac06)
  - [zsh](#org520ab5c)
- [Summary](#org5621d3f)



<a id="orgcaadaed"></a>

# Nix


<a id="org7f24ab8"></a>

## Install Nix

Follow the [install instructions for macOS](https://nixos.org/download.html#nix-install-macos), which guides you through the installation:

```shell
sh <(curl -L https://nixos.org/nix/install)
```

```shell
nix --version
```

    nix (Nix) 2.13.3


<a id="orgb716936"></a>

## Run a program with Nix

Use `nix run` to run a program with Nix. For example, to try [fish](https://fishshell.com):

```shell
nix run nixpkgs#fish\
    --extra-experimental-features nix-command \
    --extra-experimental-features flakes
```

This fetches the fish package from [nixpkgs](https://github.com/NixOS/nixpkgs), downloads it to the Nix store and starts it. Although some fish files are found in the Nix store, fish isn't isnstalled on the main system after the Nix shell running it exits.

```shell
ls /nix/store/ | grep fish
```

    61zcpdy6dxr582jwzjnzi2vm8hyw97p6-fish-3.6.0.tar.xz.drv
    6h7nvjphylacsmqjxz9cz3jab835ga68-fish-3.6.0.drv
    9sbayh5pr3r8c9dh1navixin3psgvvyh-completion.fish
    d9r2150gr3b605pnsn5hydjc4zjxxsfc-config.fish.appendix.drv
    igsjkga6f9x3xd4l86phypx2jh4k92ks-completion.fish
    rwscd4qmlsmxc1idj9pxc5ab8543nfww-__fish_build_paths_suffix.fish.drv
    s1nbl9wxn68m846apki35iyiqrh4bkg5-fish-3.6.0

```shell
which fish
```

    fish not found


<a id="org4a21103"></a>

## Extra experimental features

The `nix run` command relies on the `nix-command` and `flakes` features. Both of these are experimental and disabled by default, but they're enabled using the `--extra-experimental-features` flag:

```shell
nix run nixpkgs#fish
```

    error: experimental Nix feature 'nix-command' is disabled; use '--extra-experimental-features nix-command' to override

```shell
nix run nixpkgs#fish\
    --extra-experimental-features nix-command
```

    error: experimental Nix feature 'flakes' is disabled; use '--extra-experimental-features flakes' to override

```shell
nix run nixpkgs#fish\
    --extra-experimental-features nix-command \
    --extra-experimental-features flakes
```

To enable these features globally, set `experimental-featurs` in `nix.conf`:

```shell
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

```nix
experimental-features = nix-command flakes
```


<a id="orgb1b97a3"></a>

# Home Manager


<a id="org8de4c29"></a>

## Set up Home Manager

Set up a flake with the Home Manager template by running `flake new`:

```shell
nix flake new ~/.config/nixpkgs -t github:nix-community/home-manager
```

```shell
cat ~/.config/nixpkgs/flake.nix
```

Then, update the output system and username and remove the boilerplate:

```nix
{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.jeffkreeftmeijer = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;

	modules = [
	  ./home.nix
	];
      };
    };
}
```

For Home Manager's configuration, create `home.nix`. It lists your use name and home directory, but also the `stateVersion`, which determines the Home Manager release the configuration is compatible with. The `home.nix` file also sets up Home Manager to install and manage itself:

```nix
{ config, pkgs, ... }:

{
  home = {
    username = "jeffkreeftmeijer";
    homeDirectory = "/Users/jeffkreeftmeijer";
    stateVersion = "22.11";
  };

  programs.home-manager = {
    enable = true;
  };
}
```

Finally, install Home Manager and apply the configuration:

```shell
nix run ~/.config/nixpkgs#homeConfigurations.jeffkreeftmeijer.activationPackage
```

Running the `activationPackage` generates a `flake.lock` file, which locks all packages to their currently installed versions for reproducability. It only lists Home Manager now, but installed packages will be added to the list when they're added.


<a id="orgcf2d865"></a>

## Installing packages

To install a package, add it to `home.packages` in `home.nix`:

```diff
diff --git a/home.nix b/home.nix
index 6f6f86d..12f9efe 100644
--- a/home.nix
+++ b/home.nix
@@ -5,6 +5,7 @@
     username = "jeffkreeftmeijer";
     homeDirectory = "/Users/jeffkreeftmeijer";
     stateVersion = "22.11";
+    packages = [ pkgs.git ];
   };

   programs.home-manager = {
```

Then, update the environment by running `home-manager switch`:

```shell
home-manager switch
```

```
Starting Home Manager activation
Activating checkFilesChanged
Activating checkLaunchAgents
Activating checkLinkTargets
Activating writeBoundary
Activating copyFonts
Activating installPackages
replacing old 'home-manager-path'
installing 'home-manager-path'
Activating linkGeneration
Cleaning up orphan links from /Users/jeffkreeftmeijer
Creating profile generation 2
Creating home file links in /Users/jeffkreeftmeijer
Activating onFilesChange
Activating setupLaunchAgents
```


<a id="org5695cd5"></a>

# Modules


<a id="orgbccf5ed"></a>

## home-manager

Home manager added itself to `home.nix`, but we're moving it to a module to keep program-specific settings out of the main file:

```nix
{ pkgs, ... }:

{
  programs.home-manager.enable = true;
}
```

With the new module in place, import it in `home.nix` and remove the now duplicate `programs.home-manager`:

```diff
diff --git a/home.nix b/home.nix
index 6f6f86d..09e001a 100644
--- a/home.nix
+++ b/home.nix
@@ -1,13 +1,13 @@
 { config, pkgs, ... }:

+imports = [
+  ./modules/home-manager.nix
+];
+
 {
   home = {
     username = "jeffkreeftmeijer";
     homeDirectory = "/Users/jeffkreeftmeijer";
     stateVersion = "22.11";
   };
-
-  programs.home-manager = {
-    enable = true;
-  };
 }
```


<a id="org912a629"></a>

## direnv

[Direnv](https://direnv.net) loads and unloads packages based on the curent directory to create per-project development environments.

```shell
direnv --version
```

    2.32.2


### Nix configuration

The direnv program depends on a shell being enabled for it to hook in. This module enables zsh for that purpose:

```nix
{
  programs.direnv.enable = true;
  programs.zsh.enable = true;
}
```


<a id="org169405d"></a>

## emacs

Emacs, built from source from the master branch:

```emacs-lisp
(concat
 "GNU Emacs "
 emacs-version
 " (" emacs-repository-branch " @ " emacs-repository-version ")")
```

    GNU Emacs 30.0.50 (master @ dec09aaeb616e7648f4694d76090cc8e269471e0)

My current version was built with the following options:<sup><a id="fnr.1" class="footref" href="#fn.1" role="doc-backlink">1</a></sup>

```shell
./configure --disable-build-details \
--with-modules \
--with-ns \
--disable-ns-self-contained \
--with-native-compilation
```


### Nix configuration

Use [emacs-overlay](https://github.com/nix-community/emacs-overlay) to install Emacs from source, based on the latest version on the master branch. To do this, add the overlay to the inputs in `flake.nix`:

```diff
	index 3e15177..7e7eebc 100644
--- a/flake.nix
+++ b/flake.nix
@@ -7,12 +7,16 @@
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
+    emacs-overlay = {
+      url = "github:nix-community/emacs-overlay";
+      inputs.nixpkgs.follows = "nixpkgs";
+    };
   };

-  outputs = { nixpkgs, home-manager, ... }:
+  outputs = { nixpkgs, home-manager, emacs-overlay, ... }:
     let
       system = "x86_64-darwin";
-      pkgs = nixpkgs.legacyPackages.${system};
+      pkgs = nixpkgs.legacyPackages.${system}.extend(emacs-overlay.overlay);
     in {
       homeConfigurations.jeffkreeftmeijer = home-manager.lib.homeManagerConfiguration {
	 inherit pkgs;
```

Then, add the Emacs module, which enables the program and switches the package to `emacsGit-nox`:

```nix
{ pkgs, ... }:
{
  programs.emacs.enable = true;
  programs.emacs.package = pkgs.emacsGit;
}
```


<a id="org420dd36"></a>

## git

```shell
git --version
```

    git version 2.39.2


### Settings

1.  Set the user name and email fields

    ```nix
    programs.git.userName = "Jeff Kreeftmeijer";
    programs.git.userEmail = "jeff@kreeft.me";
    ```

2.  Use "main" as the default branch

    ```nix
    programs.git.extraConfig.init.defaultBranch = "main";
    ```

3.  Ignore `.DS_Store` files

    ```nix
    programs.git.ignores = ["DS_Store"];
    ```


### Nix configuration

```nix
{
  programs.git.enable = true;
  programs.git.userName = "Jeff Kreeftmeijer";
  programs.git.userEmail = "jeff@kreeft.me";
  programs.git.extraConfig.init.defaultBranch = "main";
  programs.git.ignores = ["DS_Store"];
}
```


### Generated configuration file

```gitconfig
[init]
	defaultBranch = "main"

[user]
	email = "jeff@kreeft.me"
	name = "Jeff Kreeftmeijer"
```


<a id="org5a7ac06"></a>

## tmux

```shell
tmux -V
```

    tmux 3.3a


### Settings

-   Install an updated version of ncurses to [fix issues with `tmux-256color` terminals](https://jeffkreeftmeijer.com/tmux-ncurses/).
    
    ```nix
    home.packages = [ pkgs.ncurses ];
    ```

-   Remove tmux-sensible from [Nix tmux defaults](https://jeffkreeftmeijer.com/nix-home-manager-tmux-defaults/):
    
    ```nix
    programs.tmux.sensibleOnTop = false;
    ```

-   [Set `escape-time` to 0](https://jeffkreeftmeijer.com/tmux-escape-time/):
    
    ```nix
    programs.tmux.escapeTime = 0;
    ```

-   Use vi-style key bindings:
    
    ```nix
    programs.tmux.keyMode = "vi";
    ```


### Nix configuration

```nix
{ pkgs, ... }:
{
  home.packages = [ pkgs.ncurses ];
  programs.tmux.enable = true;
  programs.tmux.sensibleOnTop = false;
  programs.tmux.escapeTime = 0;
  programs.tmux.keyMode = "vi";
}
```


### Generated configuration file

```shell
cat ~/.config/tmux/tmux.conf
```


<a id="org520ab5c"></a>

## zsh

```shell
zsh --version
```

    zsh 5.9 (x86_64-apple-darwin22.3.0)


### Settings

1.  [Disable command completion](https://jeffkreeftmeijer.com/nix-home-manager-zsh-defaults/)

    ```nix
    programs.zsh.enableCompletion = false;
    ```

2.  Enable [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)

    ```nix
    programs.zsh.historySubstringSearch.enable = true;
    ```

3.  [Add current git repository status to shell prompt](https://jeffkreeftmeijer.com/nix-home-manager-git-prompt/)

    ```nix
    programs.zsh.initExtra =
    ''
    source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
    setopt PROMPT_SUBST
    export PS1='%~ $(__git_ps1 "(%s) ")%# '
    '';
    ```
    
    Since this depends on git, we'll also add git to this module's `home.packages` list:
    
    ```nix
    home.packages = [ pkgs.git ];
    ```


### Nix configuration

```nix
{ pkgs, ... }:
{
  home.packages = [ pkgs.git ];
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false;
  programs.zsh.historySubstringSearch.enable = true;
  programs.zsh.initExtra =
  ''
  source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
  setopt PROMPT_SUBST
  export PS1='%~ $(__git_ps1 "(%s) ")%# '
  '';
}
```


### Generated configuration file

```zsh

typeset -U path cdpath fpath manpath

for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/prgvdaam2gnp7is5mraq25rhrrj76rw0-zsh-5.9/share/zsh/$ZSH_VERSION/help"





# Oh-My-Zsh/Prezto calls compinit during initialization,
# calling it twice causes slight start up slowdown
# as all $fpath entries will be traversed again.










# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY


source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
setopt PROMPT_SUBST
export PS1='%~ $(__git_ps1 "(%s) ")%# '

eval "$(/nix/store/l372b7br02g12dp5lxys8s4zw629g3cq-direnv-2.32.2/bin/direnv hook zsh)"


# Aliases


# Named Directory Hashes



source /nix/store/rbphvmksmhq97431yfsc710xmmi9qsan-zsh-history-substring-search-1.0.2/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
```


<a id="org5621d3f"></a>

# Summary

Finally, the `home.nix` main configuration file imports all modules:

```nix
{ config, pkgs, ... }:

{
  imports = [
    ./modules/home-manager.nix
    ./modules/direnv.nix
    ./modules/emacs.nix
    ./modules/git.nix
    ./modules/tmux.nix
    ./modules/zsh.nix
  ];

  home = {
    username = "jeffkreeftmeijer";
    homeDirectory = "/Users/jeffkreeftmeijer";
    stateVersion = "22.11";
  };
}
```

## Footnotes

<sup><a id="fn.1" class="footnum" href="#fnr.1">1</a></sup> In reality, Nix also sets a `--prefix` because it installs Emacs in a custom location, like `/nix/store/x6nsbfr31nphxzn2f9c8iyc66rxvmi7d-emacs-git-20230321.0`. I consider that a Nix artifact, and not an Emacs configuration setting.

Another option I did include above is `--disable-build-details`, which is also set by Nix [for a more reproducable build](https://github.com/NixOS/nixpkgs/commit/496f9309480b22173e25885bc7c128c30fbd4da3). In practice, that means the host names and build times are omitted from the built program to keep its hash stable for Nix's cache.
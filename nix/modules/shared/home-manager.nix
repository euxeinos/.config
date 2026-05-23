{ config, pkgs, lib, ... }:

let
    name = "echepolus";
    user = "alexeykotomin";
    email = "a.kotominn@gmail.com";
in
{
  direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ls     = "ls -la --color=auto";
      diff   = "difft";
      search = "rg -p --glob '!node_modules/*' --glob '!vendor/*'";
      nr     = "cd $HOME/.config/nix && nix run .#build-switch";
      cd     = "z";
      ga     = "git add .";
      gs     = "git status";
      gd     = "git diff";
      gdc    = "git diff --cached";
    };

    initExtra = ''
      # nix daemon
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # PATH
      export PATH=$HOME/.local/share/bin:$HOME/bin:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.composer/vendor/bin:$PATH

      # Environment
      export ALTERNATE_EDITOR=""
      export EDITOR="emacsclient -t"
      export VISUAL="emacsclient -c -a emacs"
      export HISTIGNORE="pwd:ls:cd"
      export PKG_CONFIG_PATH="$HOME/.nix-profile/lib/pkgconfig:$HOME/.nix-profile/share/pkgconfig:$HOME/.nix-profile/lib"
      export CLICOLOR=1
      export LSCOLORS=ExFxCxDxBxegedabagacad

      # Restore last directory on startup
      _save_last_dir() { echo "$PWD" > "$HOME/.bash_last_dir"; }
      PROMPT_COMMAND+=(_save_last_dir)
      if [[ -f "$HOME/.bash_last_dir" && -r "$HOME/.bash_last_dir" ]]; then
        _ld="$(cat "$HOME/.bash_last_dir")"
        [[ -d "$_ld" ]] && builtin cd "$_ld"
        unset _ld
      fi

      # Functions
      TERM=xterm-256color
      e()     { emacsclient -t "$@"; }
      gc()    { git commit -m "$*"; }
      shell() { nix-shell '<nixpkgs>' -A "$1"; }

      # FZF
      source ${pkgs.fzf}/share/fzf/key-bindings.bash
      source ${pkgs.fzf}/share/fzf/completion.bash
      export FZF_COMPLETION_TRIGGER='**'
      export FZF_DEFAULT_OPTS="--bind=tab:accept --height 60% --border sharp --layout reverse --prompt '> ' --pointer '▶'"
      export FZF_CTRL_T_OPTS="--preview '(bat --paging=never --color=always --style=plain {} 2>/dev/null || tree -C {}) 2>/dev/null | head -200'"
      export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

      eval "$(${pkgs.zoxide}/bin/zoxide init bash)"

      # History search on arrow keys — type a prefix, then ↑/↓ to filter history
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      bind '"\e[C": forward-char'
      bind '"\e[D": backward-char'

      if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
  };

  git = {
    enable = true;

    settings = {
      user = {
        name = name;
        email = email;
      };

      extraConfig = {
        init.defaultBranch = "main";
        gpg.format = "openpgp";
        user.signingkey = "8EF70D99CF2ACEE8";
        commit.gpgsign = true;

        core = {
          editor = "vim";
          autocrlf = "input";
        };
        pull.rebase = true;
        rebase.autoStash = true;
      };
    };
    ignores = [ "*.swp" ];
    lfs.enable = true;
  };

  ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
  };

  starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      format = "$directory$git_branch$git_status$character";
      add_newline = false;

      character = {
        success_symbol = "[❯](bold blue)";
        error_symbol   = "[❯](bold red)";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo  = true;
        style             = "bold blue";
      };

      git_branch = {
        symbol = " ";
        format = "[$symbol$branch]($style) ";
        style  = "bold red";
      };

      git_status = {
        format   = "([$all_status$ahead_behind]($style) )";
        style    = "bold red";
        ahead    = "⇡\${count}";
        behind   = "⇣\${count}";
        modified = "!\${count}";
        staged   = "+\${count}";
        untracked = "?\${count}";
      };
    };
  };

  yazi = {
    enable = true;
    enableBashIntegration = true;
    shellWrapperName = "y";
  };
}

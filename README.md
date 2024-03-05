# minimal dotfiles

## Install
```
curl -Lks https://raw.githubusercontent.com/jojoyuji/dot/master/installDots.sh | /bin/bash
```

## Dependencies

### zsh 

>  ```brew install zsh```

sets default terminal

> ``` chsh -s /bin/zsh ```

https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH

### zplug

>  ``` curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh ```

### rust

> ``` curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh ```

### alacritty 

> ``` git clone https://github.com/alacritty/alacritty.git ~/alacritty```

### prezto

> ```git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"```

https://github.com/sorin-ionescu/prezto

### tmux

>  ```brew install tmux```

### tmuxinator

> ```gem install tmuxinator```

### tpm 

>  ``` git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm```

after installing tpm, open tmux and run <prefix> + I to install

https://github.com/tmux-plugins/tpm

### neovim ALEs

- luafmt, eslint, prettier

>  ``` pnpm install -g lua-fmt eslint prettier ```


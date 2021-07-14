FROM archlinux:latest

RUN pacman -Syu \
      zsh \
      curl \
      mtr \
      bat \
      jq \
      dog \
      curlie \
      neovim \
      yq

ENTRYPOINT [ "/bin/zsh" ]

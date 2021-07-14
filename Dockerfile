FROM archlinux:latest

RUN pacman -Syu --needed --noconfirm \
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

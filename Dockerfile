FROM alpine:latest
RUN apk update
RUN apk add neovim git build-base nodejs --update
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
RUN git clone https://github.com/tluijken/.dotfiles $HOME/.dotfiles
RUN mkdir $HOME/.config
RUN ln -s $HOME/.dotfiles/nvim/.config/nvim $HOME/.config/nvim 
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
RUN nvim --headless +TSUpdateSync +qa

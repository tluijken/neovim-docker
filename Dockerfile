FROM alpine:latest
RUN apk update
RUN apk add neovim git build-base curl fzf ripgrep tree xclip python3 nodejs npm tzdata gettext libtool autoconf automake cmake g++ zip unzip tar gcc gzip nodejs --update
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.local/bin:/root/.cargo/bin:${PATH}"
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
RUN git clone https://github.com/tluijken/.dotfiles $HOME/.dotfiles
RUN mkdir $HOME/.config
RUN ln -s $HOME/.dotfiles/nvim/.config/nvim $HOME/.config/nvim 
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
RUN nvim --headless +TSUpdateSync +"sleep 40" +qa

CMD ["nvim"]

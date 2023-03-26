FROM alpine:latest

ARG ssh_pub_key
# Installe les dépendances de Neovim
RUN apk add --update lua cmake ninja bash make neovim git go nodejs npm python3 python3-dev build-base py3-pip util-linux

RUN apk add fish curl
RUN pip3 install neovim

RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

 # install lua-language-server
RUN git clone https://github.com/sumneko/lua-language-server
WORKDIR /lua-language-server
RUN ./make.sh
RUN cp ./bin/lua-language-server /usr/local/bin/

# Install gopls
ENV GO111MODULE=on
RUN go install golang.org/x/tools/gopls@latest

# Expose la socket de Neovim
ENV NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

#Config ssh
# create user SSH configuration
RUN mkdir -p /root/.ssh \
    && chmod 0700 /root/.ssh
RUN echo "$ssh_pub_key" > /root/.ssh/authorized_keys

# install ssh
RUN apk add openrc openssh \
    && ssh-keygen -A \
    && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config

RUN rc-status \
    # touch softlevel because system was initialized without openrc
    && touch /run/openrc/softlevel \
    && rc-service sshd stop

RUN sed -i 's/\/bin\/ash/\/usr\/bin\/fish/g' /etc/passwd

COPY ./entrypoint.sh /root/.
WORKDIR /root

# Exécute Neovim en mode listen start ssh
ENTRYPOINT [ "sh", "./entrypoint.sh" ]

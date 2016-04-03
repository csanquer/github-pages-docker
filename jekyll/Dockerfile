FROM ruby:2.3.0

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    apt-utils

ENV NODEJS_VERSION 5.x

RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://deb.nodesource.com/node_$NODEJS_VERSION jessie main" > /etc/apt/sources.list.d/nodesource.list && \
    echo "deb-src https://deb.nodesource.com/node_$NODEJS_VERSION jessie main" >> /etc/apt/sources.list.d/nodesource.list

RUN apt-get update && apt-get install -y \
    build-essential \
    acl \
    less \
    sudo

RUN apt-get install -y \
    nodejs

RUN npm install -g bower gulp

RUN gem install \
    bundler \
    jekyll \
    github-pages

RUN echo "Europe/Paris" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

RUN sed -i 's#^\(Defaults\s\+secure_path\)=\"\(.\+\)\"#\1=\"/usr/local/bundle/bin:\2\"#g' /etc/sudoers

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /root/.ssh
COPY config/ssh_config /root/.ssh/config

COPY config/.gitconfig /root/.gitconfig
COPY config/.gitignore /root/.gitignore

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh && chown root:root /entrypoint.sh

VOLUME /srv/apps
WORKDIR /srv/apps

EXPOSE 4000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["jekyll", "serve", "-H", "0.0.0.0"]

FROM mgryniak/mgr-dev-base
LABEL maintainer "Michał Gryniak <mgryniak@gmail.com>"
ENV TZ UTC
ARG DEBIAN_FRONTEND=noninteractive
#-------------------------------------------------
# Clean packages
RUN apt-get clean autoclean && apt-get purge -y --auto-remove && rm -rf /var/lib/{apt,dpkg,cache,log}/
#-------------------------------------------------
# Install xfce4 and x2go
RUN apt-get update && \
    apt-get install --yes xfce4 arc-theme terminator x2goserver x2goclient x2goserver-xsession
#-------------------------------------------------
# Install Chromium
RUN apt-get install --yes chromium
#-------------------------------------------------
# Configure xfce4
ADD dev /home/dev/
#-------------------------------------------------
# Change owner
RUN chown -R dev:dev /home/dev
#-------------------------------------------------
# Configure supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#-------------------------------------------------
# Install and configure VSCode
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    rm -f packages.microsoft.gpg

RUN apt-get update && \
    apt-get install --yes code

USER dev
RUN code --install-extension ms-vscode-remote.remote-ssh && \
    code --install-extension ms-vscode-remote.remote-ssh-edit
USER root
#-------------------------------------------------
# Clean image
RUN apt-get clean autoclean && apt-get purge -y --auto-remove && rm -rf /var/lib/{apt,dpkg,cache,log}/
EXPOSE 22
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
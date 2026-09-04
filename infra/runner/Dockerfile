FROM archlinux:base-devel

RUN pacman -Syu --noconfirm --needed --quiet git jq nodejs sudo \
 && pacman -Scc --noconfirm \
 && sed -i 's/^#MAKEFLAGS=.*/MAKEFLAGS="-j$(nproc)"/' /etc/makepkg.conf \
 && useradd -m builder \
 && echo 'builder ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/builder \
 && install -d -o builder -g builder /repo

USER builder
RUN git clone -q https://aur.archlinux.org/paru-bin.git /tmp/paru \
 && cd /tmp/paru && makepkg -si --noconfirm && rm -rf /tmp/paru ~/.cache

USER root
RUN sed -i 's/^#LocalRepo$/LocalRepo/' /etc/paru.conf \
 && printf '\n[aur]\nSigLevel = Optional TrustAll\nServer = file:///repo\n' >>/etc/pacman.conf

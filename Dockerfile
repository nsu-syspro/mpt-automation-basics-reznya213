FROM archlinux:latest
RUN yes | pacman -Syu
RUN yes | pacman -S gcc make jq diffutils
WORKDIR /workspace
COPY . .
RUN make check
ENTRYPOINT ["./build/wordcount"]

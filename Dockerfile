FROM golang:bullseye

RUN apt update -y
RUN apt install curl wget unzip -y

RUN wget https://github.com/ledgerwatch/erigon/archive/refs/tags$(curl -s -L https://github.com/ledgerwatch/erigon/releases/latest | egrep -m 1 -o '/v(.*).zip')
RUN unzip $(ls | egrep -o 'v(.*).zip') \
    cd $(ls | egrep -o 'erigon-(.*)') \
    go build ./cmd/erigon && go build ./cmd/rpcdaemon \
    mkdir /erigon \
    chmod +x erigon && chmod +x rpcdaemon \
    mv erigon /erigon && mv rpcdaemon /erigon
RUN rm -rf $(ls | egrep -o 'v(.*).zip')
RUN rm -rf $(ls | egrep -o 'erigon-(.*)')

WORKDIR /erigon
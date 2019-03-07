FROM ethereum/solc:0.5.4-alpine

RUN apk add --no-cache --virtual .build-deps \
        git \
        bash \
        python \
        make \
        g++ \
	autoconf \
	gifsicle \
    	automake \
    	libc6-compat \
    	libjpeg-turbo-dev \
    	libpng-dev \
    	nasm

RUN apk add --update nodejs nodejs-npm

WORKDIR /doc_govapp

RUN echo "Copying shell script to image"
COPY ./docusaurus.sh /doc_govapp

RUN echo "List, after copying"
RUN ls

RUN    chmod +x ./docusaurus.sh &&\
    git clone https://github.com/ledgerium/governanceapp.git

RUN echo "List, after clonig governanceapp"
RUN ls

RUN npm install -g solidity-docgen

RUN npm install --g docusaurus-init

#RUN npm install --unsafe-perm -g  solc

# RUN which solc

RUN npm --version

RUN ./docusaurus.sh

WORKDIR /doc_govapp/docusaurus/docs

RUN ls

WORKDIR /doc_govapp/docusaurus/website

RUN ls

# CMD ["node","docusaurus-start"]
ENTRYPOINT ["tail", "-f", "/dev/null"]

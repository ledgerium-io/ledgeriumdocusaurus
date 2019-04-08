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

RUN    	chmod +x ./docusaurus.sh &&\
    	git clone https://github.com/ledgerium/governanceapp.git

RUN echo "List, after clonig governanceapp"

RUN npm install -g solidity-docgen
RUN npm install --g docusaurus-init

RUN npm --version
RUN ls -latr

RUN ./docusaurus.sh

COPY ./sidebars.js /doc_govapp/docusaurus/website

WORKDIR /doc_govapp/docusaurus/website

# CMD ["node","docusaurus-start"]
ENTRYPOINT ["tail", "-f", "/dev/null"]

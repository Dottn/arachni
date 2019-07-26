FROM debian:buster

LABEL Author="Jerry Cai" Modified="Sivert Solem"

ARG ARACHNI_VERSION=arachni-1.5.1-0.5.12
ENV ARACHNI_USERNAME arachni
ENV ARACHNI_PASSWORD password
ENV DB_ADAPTER sqlite

RUN apt-get update && apt-get -y install \
    wget \
    curl \
    supervisor \
    unzip \
    rubygem-full

RUN mkdir -p /var/log/supervisor && \
    mkdir -p /etc/supervisor/conf.d

#COPY "$PWD"/${ARACHNI_VERSION}-linux-x86_64.tar.gz ${ARACHNI_VERSION}-linux-x86_64.tar.gz
RUN wget https://github.com/Arachni/arachni/releases/download/v1.5.1/${ARACHNI_VERSION}-linux-x86_64.tar.gz && \
    tar xzvf ${ARACHNI_VERSION}-linux-x86_64.tar.gz && \
    mv ${ARACHNI_VERSION}/ /usr/local/arachni && \
    rm -rf *.tar.gz

COPY "$PWD"/files /
EXPOSE 7331 9292

CMD entrypoint.sh

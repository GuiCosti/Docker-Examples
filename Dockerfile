FROM ubuntu:18.04

## Conda setup
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local  
   
ENV PATH /opt/conda/bin:$PATH

##Setup
ENV PORT 80
EXPOSE ${PORT}


COPY . /main
WORKDIR /main
RUN mkdir /main/model
ENV PATH /root/.local/bin:$PATH

RUN chmod +x install && ./install

ENTRYPOINT ["/bin/sh", "-c", "python main.py ${PORT}"]


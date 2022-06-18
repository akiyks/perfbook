# Ubuntu based container for building perfbook.
# build ARGs:
#    rel: Ubuntu release, default: "latest"
#    uid: user id, default: 0
#    gid: group id, default: 0
#    user: user name, default: "perfbook"
#    group: group name, default: "perfbook"
#
# build example:
#    docker build -t <image tag> [--build-arg rel=<release tag>] \
#                 [--build-arg uid=1000 --build-arg gid=1000] .
# run example:
#    docker run --rm -it -v <perfbook Git dir (abs)>:/work <image tag>
# , or
#    podman run --rm -it -v <perfbook Git dir (abs)>:/work:z <image tag>
ARG rel=latest
FROM ubuntu:$rel
ARG rel
ENV REL $rel
RUN apt-get update && apt-get install -y locales && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*
ENV LANG en_US.utf8
RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=UTC apt-get install -y tzdata && \
    apt-get install -y fig2ps inkscape xfig graphviz psutils \
    texlive-publishers texlive-pstricks texlive-science texlive-fonts-extra \
    make nano vim git curl gnuplot-nox time && \
    rm -rf /var/lib/apt/lists/*
COPY steel-city-comic.regular.ttf /usr/local/share/fonts/
RUN mkdir -p /etc/fonts/conf.avail && cd /etc/fonts/conf.avail && \
    echo '<?xml version="1.0"?>\n\
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">\n\
<fontconfig>\n\
  <dir>/usr/share/texlive/texmf-dist/fonts/opentype</dir>\n\
</fontconfig>' > 09-texlive-fonts.conf && \
    ln -sf /etc/fonts/conf.avail/09-texlive-fonts.conf /etc/fonts/conf.d/ && \
    fc-cache -sf
WORKDIR /opt
RUN if [ $REL = "bionic" ] ; then \
    curl https://mirrors.ctan.org/macros/latex/contrib/cleveref.zip -L -O && unzip cleveref.zip && \
    curl https://mirrors.ctan.org/macros/latex/contrib/epigraph.zip -L -O && unzip epigraph.zip && \
    curl https://mirrors.ctan.org/macros/latex/contrib/glossaries-extra.zip -L -O && unzip glossaries-extra.zip && \
    cd cleveref && latex cleveref.ins && cd .. && \
    mkdir -p /usr/local/share/texmf/tex/latex/cleveref && \
    cp cleveref/cleveref.sty /usr/local/share/texmf/tex/latex/cleveref && \
    cd epigraph && latex epigraph.ins && cd .. && \
    mkdir -p /usr/local/share/texmf/tex/latex/epigraph && \
    cp epigraph/epigraph.sty /usr/local/share/texmf/tex/latex/epigraph && \
    cd glossaries-extra && latex glossaries-extra.ins && cd .. && \
    mkdir -p /usr/local/share/texmf/tex/latex/glossaries-extra && \
    cp glossaries-extra/*.sty /usr/local/share/texmf/tex/latex/glossaries-extra && \
    texhash /usr/local/share/texmf && \
    curl https://mirrors.ctan.org/graphics/a2ping.zip -L -O && unzip a2ping.zip && \
    cp a2ping/a2ping.pl /usr/local/bin/a2ping ; \
    else \
    curl https://gitlab.com/latexpand/latexpand/-/archive/v1.3/latexpand-v1.3.tar.gz -o - | tar xfz - && \
    sed -i -e 's/@LATEXPAND_VERSION@/v1.3/' latexpand-v1.3/latexpand && \
    cp latexpand-v1.3/latexpand /usr/local/bin ; \
    fi
ARG uid=0
ARG gid=0
ARG user=perfbook
ARG group=perfbook
RUN if [ $uid -ne 0 ] ; then \
    groupadd -g $gid $group && \
    useradd -u $uid -g $gid -m $user ; \
    fi
VOLUME /work
USER $uid:$gid
WORKDIR /work
CMD /bin/bash

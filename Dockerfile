FROM apache/hadoop:3
USER root
RUN yum update -y && yum upgrade -y
RUN yum groupinstall "Development Tools" -y
RUN wget https://www.nasm.us/pub/nasm/releasebuilds/2.16.02/nasm-2.16.02.tar.gz \
    && tar -xvzf nasm-2.16.02.tar.gz \
    && cd nasm-2.16.02 \
    && ./configure \
    && make \
    && make install
RUN git clone https://github.com/intel/isa-l.git
RUN cd isa-l \ 
    && ./autogen.sh \
    && ./configure --prefix=/usr --libdir=/usr/lib64 \
    && make \
    && make install

# RUN cp /usr/local/lib/libisal.so /usr/lib/hadoop/lib/native/
# RUN cp /usr/local/lib/libisal.so.2 /usr/lib/hadoop/lib/native/

RUN echo $(hadoop checknative)
# ./configure --prefix=/usr --libdir=/usr/lib64

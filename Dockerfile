FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y \
    default-jre \
    default-jdk \
    unzip \
    curl

ENV workdir /usr/src/myapp
RUN mkdir -p $workdir
WORKDIR $workdir

RUN curl -o $workdir/apache-opennlp-1.8.2-bin.zip http://apache.claz.org/opennlp/opennlp-1.8.2/apache-opennlp-1.8.2-bin.zip

RUN mkdir /models
RUN curl -o /models/en-sent.bin http://opennlp.sourceforge.net/models-1.5/en-sent.bin
RUN curl -o /models/en-ner-person.bin http://opennlp.sourceforge.net/models-1.5/en-ner-person.bin
RUN curl -o /models/en-ner-organization.bin http://opennlp.sourceforge.net/models-1.5/en-ner-organization.bin

ADD KEYS $workdir/KEYS
ADD apache-opennlp-1.8.2-bin.zip.asc $workdir/apache-opennlp-1.8.2-bin.zip.asc
RUN gpg --import KEYS
RUN gpg --verify apache-opennlp-1.8.2-bin.zip.asc apache-opennlp-1.8.2-bin.zip

RUN unzip apache-opennlp-1.8.2-bin.zip
RUN rm apache-opennlp-1.8.2-bin.zip
RUN mv apache-opennlp-1.8.2/ /usr/bin/

ENTRYPOINT ["/usr/bin/apache-opennlp-1.8.2/bin/opennlp"]

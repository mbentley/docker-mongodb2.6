FROM debian:jessie
MAINTAINER Matt Bentley <mbentley@mbentley.net>
RUN (echo "deb http://http.debian.net/debian/ jessie main contrib non-free" > /etc/apt/sources.list && echo "deb http://http.debian.net/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list)
RUN apt-get update

RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y wget &&\
	wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.6.2.tgz -O /tmp/pkg.tar.gz &&\
	mkdir -p /data/db &&\
	ln -s /opt/mongodb/bin/mongo /usr/local/bin/mongo &&\
	ln -s /opt/mongodb/bin/mongod /usr/local/bin/mongod &&\
	cd /tmp &&\
	tar zxf pkg.tar.gz &&\
	mv mongodb-* /opt/mongodb &&\
	rm -rf /tmp/*)

ADD run.sh /usr/local/bin/run

EXPOSE 27017
EXPOSE 28017
CMD ["/usr/local/bin/run"]

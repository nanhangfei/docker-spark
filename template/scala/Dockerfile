FROM bde2020/spark-submit:2.4.0-hadoop3.1

MAINTAINER Cecile Tonglet <cecile.tonglet@tenforce.com>
MAINTAINER Gezim Sejdiu <g.sejdiu@gmail.com>

# RUN apt-get-install apt-transport-https
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      apt-transport-https \
      dirmngr \
    && rm -rf /var/lib/apt/lists/*

RUN echo "deb https://dl.bintray.com/sbt/debian /" > /etc/apt/sources.list.d/sbt.list \
      && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823

# RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
#       sbt \
#     && rm -rf /var/lib/apt/lists/
RUN apt-get-install sbt

WORKDIR /app

ADD repositories ~/.sbt/repositories

# Pre-install base libraries
ADD build.sbt /app/
ADD plugins.sbt /app/project/
RUN sbt update -Dsbt.override.build.repos=true

COPY template.sh /

ENV SPARK_APPLICATION_MAIN_CLASS Application

# Copy the build.sbt first, for separate dependency resolving and downloading
ONBUILD COPY build.sbt /app/
ONBUILD COPY project /app/project
ONBUILD RUN sbt update

# Copy the source code and build the application
ONBUILD COPY . /app
ONBUILD RUN sbt clean assembly

CMD ["/template.sh"]

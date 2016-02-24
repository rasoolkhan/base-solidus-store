FROM lorcanoeire/base-vivid
MAINTAINER Lorcan O'Flynn <lorcan.oflynn@gmail.com>

# Install the application
RUN mkdir -p /home/app
RUN cd /home/app && git clone https://github.com/lorcanoeire/base-solidus-store.git --single-branch store
RUN cd /home/app/store && bundle install --no-cache

WORKDIR /home/app/store
EXPOSE 8080

ENTRYPOINT ["./run.sh"]

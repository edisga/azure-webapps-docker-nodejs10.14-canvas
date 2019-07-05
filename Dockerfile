FROM node:10.16.0-stretch
RUN mkdir /app

#Install dependencies for canvas check this better documentation: https://www.npmjs.com/package/canvas#compiling
RUN apt-get update \
        && apt-get install -y --no-install-recommends python g++ make build-essential libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev

COPY . /app
WORKDIR /app

#Need to build from source for specific processor architure check this for better documentation: https://www.npmjs.com/package/canvas#compiling
RUN npm install --build-from-source

#Giving access to application folder
RUN chmod 755 /app

#For SSH
ENV SSH_PASSWD "root:Docker!" 
RUN apt-get install -y --no-install-recommends openssh-server \
	&& echo "$SSH_PASSWD" | chpasswd 

COPY sshd_config /etc/ssh/
COPY init.sh /usr/local/bin/

EXPOSE 2222 3000
ENTRYPOINT ["/usr/local/bin/init.sh"]
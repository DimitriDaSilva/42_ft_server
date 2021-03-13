# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dda-silv <dda-silv@student.42lisboa.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/09 14:28:54 by dda-silv          #+#    #+#              #
#    Updated: 2021/03/13 19:20:59 by dda-silv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Install the base OS container
# Docker syntax: FROM <image name>:<tag> 
# In this case, the tag is the version of the image as buster is debian's 
# v10 code name
FROM debian:buster

# Update package list
# Docker syntax: RUN <shell command>
# The directive RUN creates a shell terminal to run the command
RUN apt-get update

# Install services required by the project
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN apt-get -y install mariadb-server \ 
			php \
			php-cli \
	 		php-cgi \
			php-mbstring \
			php-fpm \
			php-mysql \
			nginx \
			openssl

# Install auxiliary tools
RUN apt-get -y install vim wget libnss3-tools


# Copy srcs files over to our container and make it our work directory
COPY srcs ./root/
WORKDIR /root/

# Command to be execute after running the container. It executes the command
# in /root/ so it's important to define the WORKDIR as the directory where
# the start_container.sh script is located
ENTRYPOINT ["bash", "start_container.sh"]

# Among others things, start_container.sh runs the cmd "service nginx start".
# We can't simply add "RUN service nginx start" in the Dockerfile because
# the RUN allow to build an image. We only want to start the nginx server when
# we run an instance of that image (aka container)

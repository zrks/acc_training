#!/bin/bash

# Read short wiki page about style: http://wiki.bash-hackers.org/scripting/style
#
# Then proceed with checking out ShellCheck - already installed on workstation.
# https://github.com/koalaman/shellcheck


# Read about functions in bash - http://tldp.org/LDP/abs/html/functions.html


# TODO Add varaibles to define:
#+ 1) app install directory - /srv/helloapp
#+ 2) nginx user and user group - www-data

APP_INSTALL_DIRECTORY=/srv/helloapp
NGINX_USER=www-data
NGINX_USER_GROUP=www-data

CONFIG_FILE=../app/configuration/helloapp.ini
CONFIG_FILE_INSTALL_DIRCTORY=/etc/uwsgi-emperor/vassals


set_u_example() {
#    set -u
    echo $1
}

set_e_example() {
#    set -e
    rm yo
    echo 'This happened...'

    # Notice how exit code changes with flag changes.
    echo $?
}

set_e_example2() {
    set -e

#    rm yo
    echo 'inside -e'

    set +e
    
    rm yo
    echo 'inside +e'
 
    set -e
}

read_file() {
    # Read on command substitution, e.g., $(command)
    #+ http://wiki.bash-hackers.org/syntax/expansion/cmdsubst#specialities
    value=$(<packages_list.txt)
    echo $value
}

array_example() {
    # Explicitly declare variable type.
    # Read about it: http://tldp.org/LDP/abs/html/declareref.html
    declare -a array=( $(read_file) )

    for i in "${array[@]}";
    do
        echo "$i"
        # TODO Add install line.
        apt-get install "$i" -y
    done
}

# TODO Add deploy function which will:
#+ 1) execute: 'virtualenv -p /usr/bin/python3 $APP_INSTALL_DIRECTORY'
#+ 2) change ownership of $APP_INSTALL_DIRECTORY to www-data user and group

deploy_app() {

    if [ ! -d "${APP_INSTALL_DIRECTORY}" ]; then
        echo "Creating virtualenv..."
        virtualenv -p /usr/bin/python3 "${APP_INSTALL_DIRECTORY}"
    fi

    echo "Changing ${APP_INSTALL_DIRECTORY} ownership..."
    chown -R "${NGINX_USER}:${NGINX_USER_GROUP}" "${APP_INSTALL_DIRECTORY}"

    echo "Configuring app..."
    cp "${CONFIG_FILE}" "${CONFIG_FILE_INSTALL_DIRCTORY}/"

}

"$@"


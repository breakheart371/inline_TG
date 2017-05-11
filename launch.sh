#!/usr/bin/env bash
cd $HOME/tgAPI
aa() {
 sudo apt-get install
}

logo() {
    declare -A logo
    seconds="0.004"
logo[-1]="  _//             _//       _//_////////_//       _//_// _//   _////////_///////   "
logo[0]="  _//             _/ _//   _///_//      _/ _//   _///_/    _// _//      _//    _//  "
logo[1]="_/_/ _/   _//     _// _// _ _//_//      _// _// _ _//_/     _//_//      _//    _//  "
logo[2]="  _//   _//  _//  _//  _//  _//_//////  _//  _//  _//_/// _/   _//////  _/ _//      "
logo[3]="  _//  _//   _//  _//   _/  _//_//      _//   _/  _//_/     _//_//      _//  _//    "
logo[4]="  _//   _//  _//  _//       _//_//      _//       _//_/      _/_//      _//    _//  "
logo[5]="   _//      _//   _//       _//_////////_//       _//_//// _// _////////_//      _//"
logo[6]="         _//                                                                        "     
    printf "\e[38;5;213m\t"
    for i in ${!logo[@]}; do
        for x in `seq 0 ${#logo[$i]}`; do
            printf "${logo[$i]:$x:1}"
            sleep $seconds
        done
        printf "\n\t"
    done
printf "\n"
}

tg() {
 echo -e "\e[38;5;105mremove old telegram-cli\e"
    rm -rf ../.telegram-cli
    
 echo -e "\e[38;5;099minstall telegram-cli\e"
    cd api
    chmod +x api.sh
    cd ../bot
    wget https://valtman.name/files/telegram-cli-1222
    mv telegram-cli-1222 telegram-cli
    chmod +x bot.sh
    chmod +x telegram-cli
    cd ..
 }

is() {
 echo -e "\e[38;5;035mUpdating packages\e"
    sudo apt-get update -y
 
 echo -e "\\e[38;5;036mUpgrade packages\e"
    sudo apt-get upgrade -y
 
 echo -e "\\e[38;5;129mInstalling dependencies\e"
    sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev lua-socket lua-sec lua-expat libevent-dev make unzip git redis-server autoconf g++ libjansson-dev libpython-dev expat libexpat1-dev -y
 
 echo -e "\e[38;5;034mInstalling more dependencies\e"
    sudo apt-get install lua-lgi -y
    sudo apt-get install software-properties-common -y
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
    sudo apt-get install libstdc++6 -y
		sudo apt-get install luarocks -y
}

lu() {
echo -e "\e[38;5;142mInstalling LuaRocks\e"
  git clone https://github.com/keplerproject/luarocks.git
  cd luarocks
  git checkout tags/v2.3.0-rc2 # Release Candidate

  PREFIX="$tgAPI/.luarocks"

  ./configure --prefix=$PREFIX --sysconfdir=$PREFIX/luarocks --force-config

  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  make build && make install
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting.";exit $RET;
  fi

    rocks="luasocket luasec redis-lua lua-term serpent dkjson Lua-cURL multipart-post lanes"
    for rock in $rocks; do
        sudo luarocks install $rock
    done
		
  cd ..	
}

py() {
 sudo apt-get install python-setuptools python-dev build-essential -y 
 sudo easy_install pip -y
 sudo pip install redis -y
}

install() {
logo
clear
is
clear
tg
clear
lu
clear
py
clear
logo
echo -e "\e[38;5;046mInstalling packages successfully\e[39m"
}


if [ ! -f ./bot/telegram-cli ]; then
    echo -e "\033[38;5;208mError! telegram-cli not found, Please reply to this message:\033[1;208m"
    read -p "Do you want to install and config? [y/n] = "
	if [ "$REPLY" == "y" ] || [ "$REPLY" == "Y" ]; then
        install
    elif [ "$REPLY" == "n" ] || [ "$REPLY" == "N" ]; then
        exit 1
  fi
fi

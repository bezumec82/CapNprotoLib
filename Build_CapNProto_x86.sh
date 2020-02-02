reset
export NORM="\e[39m"    ; #echo -e "${NORM}Normal output";
export RED="\e[31m"     ; #echo -e "${RED}Red output";
export GRN="\e[32m"     ; #echo -e "${GRN}Green output";
export CYN="\e[36m"     ; #echo -e "${CYN}Cyan output";
export MAG="\e[35m"     ; #echo -e "${MAG}Magenta output";
export YEL="\e[33m"     ; #echo -e "${YEL}Yellow output";
export BLU="\e[34m"     ; #echo -e "${BLU}Blue output";

if [ ! -f ./config.json ]; then
    echo -e "${RED}Configuration doesn't provided.${NORM}"
    exit 1
fi 

export LIB_NAME=`jq --raw-output '.x86compile.LibName' ./config.json`
export       CC=`jq --raw-output '.x86compile.CC'      ./config.json`
export      CXX=`jq --raw-output '.x86compile.CXX'     ./config.json`

##############
### Get source
##############
if [ ! -f ./${LIB_NAME}.tar.gz ]; then
    echo -e "${YEL}Downloading CnP library : ${NORM}"
    curl -O https://capnproto.org/${LIB_NAME}.tar.gz    
else
    echo -e "${YEL}CnP already downloaded : ${NORM}"
    stat ./${LIB_NAME}.tar.gz
fi

rm -rf ${LIB_NAME}
tar zxf ${LIB_NAME}.tar.gz
cd  ./${LIB_NAME}
./configure
make -j8 check
sudo make install
cd ..
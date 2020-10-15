#! /bin/bash

dirname=mirror-download
downloadlist=downloadlist.json

if [ ! -d $dirname ];then
    mkdir $dirname
    echo $dirname created successfully!
else
    echo $dirname exist
fi


if [ ! -f $downloadlist ];then
    continue
else
    rm $downloadlist
fi

wget https://mirror-download.xcpcio.com/downloadlist.json
sudo apt-get install jq

arr=( $(jq -r '.' $downloadlist) )

cd $dirname

for (( i = 1; i + 1 < ${#arr[@]}; i += 2))
do
    key=${arr[i]:1:${#arr[i]} - 3}
    value=${arr[i + 1]:1:${#arr[i + 1]} - 3}
    if [ ! -f $key ];then
        wget -O $key $value
    fi
done
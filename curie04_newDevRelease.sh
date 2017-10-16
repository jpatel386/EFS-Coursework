#!/bin/bash

META=$1
PROJECT=$2


path_so_far=/efs/dev/${META}/${PROJECT}

#echo $path_so_far


currentRelNum="$(ls -v $path_so_far | grep 'curie04_[0-9]' | tail -1 |cut -d'_' -f2 )"
currentString="$(ls -v $path_so_far | grep 'curie04_[0-9]' | tail -1 |cut -d'_' -f1)"
currentVers="${currentString}_${currentRelNum}"


source ./curie04_increment.sh

newDir=`increment $currentVers`
path_to_src="${path_so_far}/$newDir/src"
#echo $path_to_src

efs create release $META $PROJECT $newDir

cd $path_to_src

git clone https://MthreeDelegate:AlumniTrain%40M3%2FT1@bitbucket.org/mthree_consulting/javademos.git

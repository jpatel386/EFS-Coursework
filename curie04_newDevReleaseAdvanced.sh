#!/bin/bash


if [[ -z $1 ]]
        then
        echo 'You did not specify an argument. Please give two arguments.'
        elif [[ $# -ne 2 ]]
        then
        echo 'You supplied too many/few arguments. Please give two arguements.'
        else
		META=$1
		PROJECT=$2
		path_so_far=/efs/dev/${META}/${PROJECT}
		#echo $path_so_far
		currentRelNum="$(ls -v $path_so_far | grep 'curie04_[0-9]' | tail -1 | cut -d'_' -f2 )"
		currentVers="curie04_${currentRelNum}"
		source ./curie04_increment.sh
		RELEASE=`increment $currentVers`
		path_to_src="${path_so_far}/$RELEASE/src"
		path_to_install="${path_so_far}/$RELEASE/install"
		#echo $path_to_src
		efs create release $META $PROJECT $RELEASE
		cd $path_to_src
		git clone https://MthreeDelegate:AlumniTrain%40M3%2FT1@bitbucket.org/mthree_consulting/javademos.git
		efs create install $META $PROJECT $RELEASE common
		path_to_common="${path_so_far}/$RELEASE/install/common"
		cp -rf ${path_to_src}/javademos $path_to_common
		efs dist release $META $PROJECT $RELEASE
		efs create releaselink $META $PROJECT $RELEASE curie04_DEV
fi

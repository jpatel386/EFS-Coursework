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
		RELEASE="$(readlink $path_so_far/curie04_DEV)"	
                efs checkpoint $META $PROJECT $RELEASE
                efs dist releaselink $META $PROJECT curie04_DEV
                efs create releaselink $META $PROJECT $RELEASE curie04_UAT
                efs dist releaselink $META $PROJECT curie04_UAT
fi




increment() {
        if [[ -z $1 ]]
        then
        echo 'You did not specify an argument. Please give one argument.'
        elif [[ $# -gt 1 ]]
        then
        echo 'You supplied too many arguments. Please give one argument.'
        else
                string="$(cut -d '_' -f1 <<< $1)"
                num="$(cut -d '_' -f2 <<< $1)"
                numfinal=$[num+1]
                finalversion=${string}_$numfinal
                echo $finalversion
        fi
}


#ncrement $@



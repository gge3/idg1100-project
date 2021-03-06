#!/bin/bash

currentDate=`date +%d-%m-%y-%H`
dir=$(echo news-$currentDate)

declare -A infoVar=()

function chkDir(){

    if [ ! -d "/var/www/html/pages/$dir" ]; then
        mkdir -p pages/$dir
    fi
}

function createPages(){
    for (( i=1; i<4; ++i )) do

        n=1
        while read line; do
            infoVar[$n]=$line
            n=$((n+1))
        done < /var/www/html/$dir/news$i.txt

        echo "INFO1: ${infoVar[1]}"
        echo "INFO2: ${infoVar[2]}"
        echo "INFO3: ${infoVar[3]}"
        echo "INFO4: ${infoVar[4]}"
        echo "INFO5: ${infoVar[5]}"
        echo "INFO6: ${infoVar[6]}"

        #createWeb"${infoVar[1]}" "${infoVar[2]}" "${infoVar[3]}" "${infoVar[4]}" "$i"

        HTML=$(
            echo "<!DOCTYPE html> 
            <html lang="no">
            <head> 
            <meta charset="UTF-8">
            <title>${infoVar[4]}</title> 
            </head> 
            <body> 
            <h1>${infoVar[4]}</h1>
            <h3>${infoVar[2]}</h3>
            <div><img src="${infoVar[6]}"/></div> 
            <p>Fetched on ${infoVar[5]} <a href="${infoVar[3]}">Original article</a></p>
            </body>
            </html>"
        )

        echo $HTML > /var/www/html/htmlTemp.txt

        cat /var/www/html/htmlTemp.txt > /var/www/html/pages/$dir/news$i.html

        infoVar[6]=
        

    done

    rm /var/www/html/htmlTemp.txt

    
}

function testT(){
    HTMR=$(
        echo "Hello $1 lets test this $2"
    )

    echo $HTMR
}

chkDir
createPages
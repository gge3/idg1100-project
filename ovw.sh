#!/bin/bash

currentDate=`date +%d-%m-%y-%H-%M`
dir=$(echo news-$currentDate)

rm /var/www/html/index.html

function createIndex() {

    FILE=/var/www/html/index.html
    if test -f "$FILE"; then
        echo "$FILE exists."
    else
        HTML=$(
        echo "<!DOCTYPE html> 
        <html lang="no"> 
        <head> 
        <meta charset="UTF-8">
        <title>List of news</title> 
        </head> 
        <body> 
        <h1>List of news</h1> 
        <ul>
        "
        )

        echo $HTML > /var/www/html/htmlTemp.txt

        cat /var/www/html/htmlTemp.txt > /var/www/html/index.html
    fi
}

function addEntry() {
    for (( i=1; i<4; ++i )) do
        n=1
        while read line; do
            infoVar[$n]=$line
            n=$((n+1))
        done < /var/www/html/$dir/news$i.txt

        HEADER=$(
            echo "<li><a href="./pages/$dir/news$i.html" target="_blank">${infoVar[2]}</a>"
        )

        echo $HEADER

        echo $HEADER > /var/www/html/htmlTemp.txt
        cat /var/www/html/htmlTemp.txt >> /var/www/html/index.html
    done
    echo "Done"
    rm /var/www/html/htmlTemp.txt
}

createIndex
addEntry
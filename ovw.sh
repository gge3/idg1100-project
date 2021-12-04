#!/bin/bash

currentDate=`date +%d-%m-%y`
dir=$(echo news-$currentDate)

rm index.html

function createIndex() {
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

    echo $HTML > htmlTemp.txt

    cat htmlTemp.txt > index.html
}

function addEntry() {
    for (( i=1; i<4; ++i )) do
        n=1
        while read line; do
            infoVar[$n]=$line
            n=$((n+1))
        done < $dir/news$i.txt

        HEADER=$(
            echo "<li><a href="./pages/$dir/news$i.html">${infoVar[2]}</a><li>"
        )

        echo $HEADER

        echo $HEADER > htmlTemp.txt
        cat htmlTemp.txt >> index.html
    done
    echo "Done"
    rm htmlTemp.txt
}

createIndex
addEntry
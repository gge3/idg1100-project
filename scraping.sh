#!/bin/bash

currentDate=`date +%d-%m-%y`
timestamp=`date -R`
dir=$(echo news-$currentDate)
outfile="output.txt"

url="https://www.tv2.no/nyheter"

function dump_webpage() {
    #we put the whole website on a file for easier scraping.
    curl -o $outfile $url

    echo $timestamp

    #if we cannot curl the file, an error pops up.
    check_err
}

function strip() {   

    #we check if the dir exists. If not, it is created.
    if [ ! -d "$dir" ]; then
        mkdir $dir
    fi

    #for loop to gather the first three news articles, titles and images.
    for (( i=1; i<4; ++i )) do

        #first we create the text file in our new directory
        touch $dir/news$i.txt

        #we set up a variable to get the news article link
        LI=$(
            cat $outfile | grep -E "\/nyheter\/........\/" | sed 's/<a class=\"article__link\" href=\"//g' | sed 's/\">//g' | head -n$i | tail -1
        )

        #we craft the article link with the variable.
        FINALLINK=$(echo https://www.tv2.no$LI | sed 's/ //g')

        #we save the full link to a temporary file.
        echo $FINALLINK >> final.txt

        #we gather the title and the image from previously created link.
        curl $FINALLINK | grep -E -o "(\">).*(<\/h1>)" | sed 's/\">//g' | sed 's/<\/h1>//g' >> final.txt

        echo $timestamp >> final.txt

        curl $FINALLINK | grep -E -o -m 3 "(data-src=).*(\" data)" | sed "s/data-src=\"//g"| sed "s/\" data//g" | head -n1 | tail -1 >> final.txt

        #we put the stdout of cat final.txt into our new created file.
        cat final.txt > $dir/news$i.txt

        #we delete final.txt as its purpose is now achived.
        rm final.txt

        echo Data processed.
    
    done

}

#we clean leftover text files.
function cleanup(){
    rm output.txt
}

function check_err() {
    [ $? -ne 0 ] && echo "Error Downloading Page" && exit -1
}

dump_webpage
strip
cleanup

#end
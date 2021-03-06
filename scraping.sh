#!/bin/bash

currentDate=`date +%d-%m-%y-%H`
day=`date +%-d`
timestamp=`date -R`
dir=$(echo news-$currentDate)
outfile="output.txt"

function dump_webpage() {
    url="https://www.tv2.no/nyheter"
    #we put the whole website on a file for easier scraping.
    curl -o $outfile $url

    echo $timestamp

    #if we cannot curl the file, an error pops up.
    check_err
}

function dump_webpage_sport() {
    url="https://www.tv2.no/sport"
    #we put the whole website on a file for easier scraping.
    curl -o $outfile $url

    echo $timestamp

    #if we cannot curl the file, an error pops up.
    check_err
}

function chooselink() {
    if (( $day % 2 )); then         
    echo $day is odd;
    dump_webpage 
    else         
    echo $day is even;
    dump_webpage_sport     
    fi

}

function strip() {   

    #we check if the dir exists. If not, it is created.
    if [ ! -d "/var/www/html/$dir" ]; then
        mkdir $dir
    fi

    #for loop to gather the first three news articles, titles and images.
    for (( i=1; i<4; ++i )) do

        #first we create the text file in our new directory
        touch /var/www/html/$dir/news$i.txt

        if (( $day % 2 )); then
            LI=$(
            cat $outfile | grep -E "\/nyheter\/........\/" | sed 's/<a class=\"article__link\" href=\"//g' | sed 's/\">//g' | head -n$i | tail -1
            )
        else
            LI=$(
            cat $outfile | grep -E "\/sport\/........\/" | sed 's/<a class=\"article__link\" href=\"//g' | sed 's/\">//g' | head -n$i | tail -1
            )
        fi
        #we set up a variable to get the news article link
        #LI=$(
        #    cat $outfile | grep -E "\/nyheter\/........\/" | sed 's/<a class=\"article__link\" href=\"//g' | sed 's/\">//g' | head -n$i | tail -1
        #)

        #we craft the article link with the variable.
        FINALLINK=$(echo https://www.tv2.no$LI | sed 's/ //g')

        #ESTAVES TREBALLANT EN AQUESTA LINIA; SI NO FUNCIONA CODI ELIMINA AQUESRA LINIA.
        curl $FINALLINK | grep -E -A 1 "__subtitle\">" | sed 's/<p itemprop="description" class="articleheader__subtitle">//g' >> /var/www/html/final.txt


        #we save the full link to the temporary file.
        echo $FINALLINK >> /var/www/html/final.txt

        #we gather the title and the image from previously created link.
        curl $FINALLINK | grep -E -o "(\">).*(<\/h1>)" | sed 's/\">//g' | sed 's/<\/h1>//g' >> /var/www/html/final.txt

        echo $timestamp >> /var/www/html/final.txt

        curl $FINALLINK | grep -E -o -m 3 "(data-src=).*(\" data)" | sed "s/data-src=\"//g"| sed "s/\" data//g" | head -n1 | tail -1 >> /var/www/html/final.txt

        #we put the stdout of cat final.txt into our new created file.
        cat /var/www/html/final.txt > /var/www/html/$dir/news$i.txt

        #we delete final.txt as its purpose is now achived.
        rm /var/www/html/final.txt

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

chooselink
strip
cleanup

#end
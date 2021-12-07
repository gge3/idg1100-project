#idg1100 project

##Author: Gil Grau i Enrich

Please read below to fully understand the functionality of the scripts.

These are a series of scripts made to gather recent news from [tv2.no]https://www.tv2.no/nyheter/. The scripts will auto-update the news articles every six hours. It uses nginx with the configuration file already provided for. 

The news can be accessible on http://ip-of-raspberry/index.html . Note that the ip will depending on the setup of the Raspberry's IP.

##IMPORTANT NOTES

- To get started, execute **deployment.sh** script with super user permission. **IT HAS TO BE EXECUTED IN /var/www/html IN ORDER FOR THE SCRIPT TO WORK CORRECLTY**. Else it will not work. 

- This script does a clone of this repository on /Downloads/tempdir. When executing **deployment.sh** it might ask for permission to delete git files. Press "y", since it's cleaning the temporary files created to copy and move them to directories. 

- **deployment.sh** also edits the user's crontab file and adds four lines, to automatically executed the newly added scripts every six hours.

- **scraping.sh** will scrap html code from the website, clean it and output links for other pages to work. It creates a directory with plain text files. 

- **pages.sh** creates HTML pages with beforementioned text files' content.

- **ovw.sh** creates an index.html page linking all **pages.sh** files in a single page.

- Included on the provided scripts (now available on /var/www/html) there's an automatic update to any git repository, **repoupdate.sh**. Set up a local git repo, then create any remote repository and link it to your local one. The **repoupdate.sh** will automatically ADD, COMMIT AND PUSH any modifications to the directory. 



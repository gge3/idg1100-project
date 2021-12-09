# idg1100 project

## Author: Gil Grau i Enrich

Please read below to fully understand the functionality of the scripts.

These are a series of scripts made to gather recent news from [tv2.no] https://www.tv2.no/nyheter/. The scripts will auto-update the news articles every six hours. It uses nginx with the configuration file already provided for. 

The news can be accessible on http://ip-of-raspberry/index.html . Note that the ip will change depending on the setup of the Raspberry's IP.

## IMPORTANT NOTES

- Last version of nginx must be installed prior to any scrip execution
- Know your Raspberry's IP
- Make sure the directory **/var/www/html** exists and that you have **ALL** necessary permissions to the directory.

- To get started, execute **deployment.sh** script. **IT HAS TO BE EXECUTED IN "/var/www/html" IN ORDER FOR THE SCRIPT TO WORK CORRECLTY**. Else it will not work. 

- This script does a clone of this repository on /Downloads/tempdir. When executing **deployment.sh** it might ask for permission to delete git files. Press "y", since it's cleaning the temporary files created to copy and move them to directories. 
- **deployment.sh** also edits the user's crontab file and adds four lines, to automatically execute the newly added scripts every six hours.

- **scraping.sh** will scrap html code from the website, clean it and output links for other pages to work. It creates a directory with plain text files. 

- **pages.sh** creates HTML pages with beforementioned text files' content.

- **ovw.sh** creates an index.html page linking all **pages.sh** files in a single page.

- Included on the provided scripts (now available on /var/www/html) there's an automatic update to any git repository, **repoupdate.sh**. Set up a local git repo, then create any remote repository and link it to your local one. The **repoupdate.sh** will automatically ADD, COMMIT AND PUSH any modifications to the directory. 

- The repoupdate.sh doesn't execute upon deployment. It is, however, added as a cronjob.

## OPTIONAL ADDED FEATURES
- 🌟🌟 The repo update script pushes all new files and the updated files to a GitHub repository. 
- 🌟🌟 Also retrieve a summary of each news article and add it as a fifth line in the information files. 
- 🌟The deployment script configures a blank installation of Raspberry Pi OS with all that is necessary for the project to work. 
- 🌟 Sort the news articles by date, with the most recent first 
- 🌟 On even days, display sport articles

### KNOWN PROBLEMS

- On even days, when displaying the sports section, the first article doesn't show up properly. This doesn't happen on odd days.
- When launching the scraping.sh script, you might get some errors with curl.
- Although the logic (and code) is there, the ovw.sh fails to detect an existing index.html file, thus overwriting the existing one, getting only three articles every time you scrap and generate pages.





ffrouin/suspicious-14.04 is based on ffrouin/system-14.04

## Suspicious

IT Threats GeoDashboard - [Demo](https://awstats.linuxtribe.fr/suspicious/)

# Features

**Statistic reports** : countries, services, targets
**Threat reports** : target, source, geolocalize (country, region, city), service, timelog
**Map features** : drag, zoom, select country, select it threat, drag it threat, disperse it threats (double click)
**Timeline reports** : move backward and forward in time threat database. Selecting a report before going into
timeline mode results into report survey over timeline.

# Backend Technologies

  * [fail2ban](http://www.fail2ban.org) : used to detect, log and act when malicious activity occurs
  * [MaxMind GeoIP](http://www.maxmind.com) : used to get geographic IP details : latitude, longitude, city, region, country
  * perl : used to process strings with perl REGEXP in order to format the data for the frontend,
  this script produces csv files
  * cron : used to update MaxMind GeoIP database and to call backend perl script to push the data to the frontend

# Frontend Technologies

  * web server : [apache2](http://http://httpd.apache.org) [nginx](http://nginx.org), [lighttpd](http://www.lighttpd.net) will serve our static files to end-users internet browsers
  * [d3js](http://d3js.org) : this technology will be used to build the Suspicious GeoDashboard user interface, espacialy for its geographical library
  * html/css : user interface

## How to use the container image

	docker run -d --name "suspicious-14.04" -p 8888:80 ffrouin/suspicious-14.04

# You can access suspicious dashboard

	http://<docker_host>:8888/suspicious

# Integrate new data to your suspicious reports

Please consult [Suspicious Documentation](https://github.com/ffrouin/suspicious/blob/master/INSTALL.md#manage-multiple-sources-to-integrate-it-threat-reports)

## Accounts Notes

freddy : container support and maintenance (rsa key authentication)

--

Sources : https://github.com/ffrouin/docker
Support : Freddy Frouin http://freddy.linuxtribe.fr

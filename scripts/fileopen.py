#From stackoverflow
#req = urllib.request.Request(url="http://www.fightingillini.com/boxscore.aspx?path=softball&id=12833",headers={'User-Agent':' Mozilla/5.0'})
import urllib2
url = "http://www.fightingillini.com/boxscore.aspx?path=softball&id=12833"
user_agent = "Mozilla/5.0"
req = urllib2.Request(url, headers={'User-Agent': user_agent })
handler = urllib2.urlopen(req)
webpageBytes = handler.read()
handler.close()
webpageStr = webpageBytes.decode('UTF-8')
#
softballList = 100,101,102,103,104,105,106,107,108,109,6,2,99,40,31,77,52,42,11,88,23,0,14,20,1,12,4,3,5,98,13,17,25,33
sport = 'softball'
eventName='dummyEvent'
eventDate='2017-04-01'
eventTime='12:00'
eventPlace='dummyPlace'
jerseyNumber=0
score=6
stat='atBats'
#	
athleteID = softballList.index(0)
#
from bs4 import BeautifulSoup
webSoup = BeautifulSoup(webpageStr, "lxml")

# Event details found at webSoup.body.article.div.aside

myfile = open("myfile.txt", 'w')
#
myfile.write("use michaelsdb;\n\n")
myfile.write("INSERT INTO AutoStat (athleteID, eventName, date, time, place, scoreMetric, statName, sportName) VALUES\n")
myfile.write("\t(%d, '%s', '%s', '%s', '%s', %d, '%s', '%s')\n" % (athleteID, eventName, eventDate, eventTime, eventPlace, score, stat, sport))

myfile.write(str(webSoup.body.article.div.aside.find_all('dd')))
#
#
myfile.close()
#
#print(webpage)


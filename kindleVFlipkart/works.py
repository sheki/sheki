#!/usr/bin/env python

import urllib2
from BeautifulSoup import BeautifulSoup
import sys
import boto
from boto.ecs import ECSConnection
import re

class ExtendedECSConnection(ECSConnection):
 
    def __init__(self, aws_access_key_id=None, aws_secret_access_key=None, host='ecs.amazonaws.com'):
        super(ExtendedECSConnection, self).__init__(aws_access_key_id=aws_access_key_id,
                                                    aws_secret_access_key=aws_secret_access_key,
                                                    host=host)
 
    def itemSearch(self, keyWord, **params):
        params["Keywords"] = keyWord
        params["SearchIndex"]="Books"
        return self.get_response('ItemSearch', params)
    
    def  itemLookUp(self, ASIN, **params):
        params["ItemId"]=ASIN
        params["IdType"]="ASIN"
        return self.get_response('ItemLookup',params)



def kindlePrice(url):
    page=urllib2.urlopen(url)
    soup = BeautifulSoup(page.read())
    ids=soup.findAll(id="kindle_meta_binding_winner")
    if not ids :
        return "No Kindle Edition"
    #price=(''.join(str(ids[0]).split())).split('''class="price">''')[1].split('''<''')[0][1:]
    price=str(re.search( '''\$[0-9]*\.[0-9]*''', str(ids[0])).group(0))[1:]
    print 
    page.close()
    return price


#TODO use regex to find price.

def FWishlist2Books(url):
    page=urllib2.urlopen(url)
    soup = BeautifulSoup(page.read())
    books=soup.findAll("div",{"class":"search_result_item"})
    for book in books:
        bookNames=[ (str(book("b")[0])[3:-4],str(book("b")[2])[6:-4].strip())  for book in books ]
    page.close()
#TODO also maintain flipkart Price
    return bookNames
    
def AmazonUrl(bookName):
     conn = ExtendedECSConnection(aws_access_key_id='TO BE ENTERED BY USER', aws_secret_access_key='TO BE ENTERED BY USER')
     print "amazon http request"
     res = conn.itemSearch(bookName )
     print "amaozn http Request completed"
     url= [item.get("DetailPageURL") for item in res ][0] 
     return (bookName,url)

def main():
    r=FWishlist2Books(sys.argv[1])
    skip=0
    index=open('restart','r')
    skip=int(index.readline())
    index.close()
    f=open('result.txt','a')
    print "SKIP = "+str(skip)
    i=skip
    for k in r[skip:]:
       print " Processing book %s "%k[0]
       amznUrl=AmazonUrl(k[0])
       kindle=kindlePrice(amznUrl[1])
       USD2INR=44.24
       kindleRs=0.0
       try :
           kindleRs=float(kindle)
       except ValueError:
           kindelRs=0.0
       output="%s | %s | %s | %f "%(k[0],k[1],kindle, kindleRs* USD2INR)
       print (output)
       i=i+1
       ind=open('restart','w')
       ind.write(str(i))
       ind.close()
       f.write( output+"\n")
       f.flush()
    f.close()
    sys.exit(0)

def TestKindlePrice():
    if len(sys.argv) <2:
        print "Provide URL"
        sys.exit(2)
    print "the price is"
    print kindlePrice(sys.argv[1])
    sys.exit(0)


if __name__ == "__main__":
    main() 

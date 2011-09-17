# ******************************************************
# IMPORTS
# ******************************************************
from net.grinder.script import Test
from net.grinder.script.Grinder import grinder
from net.grinder.plugin.http import HTTPPluginControl, HTTPRequest
from HTTPClient import NVPair

# ******************************************************
# MAIN
# ******************************************************
class TestRunner:
    def __call__(self):

        test = Test(1,"google.com Homepage")

        requestURL = 'http://www.google.com/'
        request = HTTPRequest(url=requestURL)
        request = test.wrap(request)
        response = request.GET()

        grinder.sleep(1000)

        return

    def __init__(self):
        # initialization
        defaultHeaders = \ 
            (NVPair('Accept-Encoding', 'gzip,deflate'),
             NVPair('Accept-Language', 'en,en-us;q=0.8,de-de;q=0.5,de;q=0.3'),
             NVPair('Accept-Charset', 'ISO-8859-1,utf-8;q=0.7,*;q=0.7'),
             NVPair('User-Agent', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080201 Firefox/2.0.0.12'),
             NVPair('Accept', 'text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5'),)

script.py                                                                                                                                  1,1            Top
:set foldcolumn=0

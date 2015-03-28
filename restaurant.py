#####
# Author: NuclearBanane
# Contributors : 
# Date : 2015/02/12
# Version : v0.1
#####

import tornado.ioloop   #Basic imports for the tornado library
import tornado.web      #

class MainHandler(tornado.web.RequestHandler):
    #####
    # The basic get request at our domain lands here
    # For now it is a welcome page with a form to submit information
    # Later the submit feature will be moved, however it function required
    # for the concept phase    #####
    def get(self):
        ####
        # Sends a dictionnary to showcase use of templates
        # Will be removed once static content is created
        ####
        page = dict([('test', 'Hi, this is a test page'),
                    ('test2','another great statement')])

        self.render("assets/frontpage.html",mest=page) 


class SubmitForm(tornado.web.RequestHandler):
    #####
    # If the page returns a post with the form data,
    # The code below returns the confirmation of the data sent.
    # This doesn't mean the print job is booked
    #####
    def post(self):
        page = dict([
            ('Name',self.get_argument('Name')),
            ('StudentNumber', self.get_argument('StudentNumber')),
            ('PrintTime',self.get_argument('PrintTime'))
            ])

        self.render("assets/response.html",mest=page)

####
# Tornado uses 'handlers' to take care of requests to certain URLs
# This makes certain API requests from a web page or such an easy to handle
# Unfortunatly it means we need to be very granular with our handlers
#
# Note : in the current form it is messy, but it isn't the worst. 
#          We can clear this up using a list called handlers.
####

application = tornado.web.Application(
	[
		(r"/", MainHandler),
		(r"/SubmitForm",SubmitForm),
		(r'/(favicon.ico)', tornado.web.StaticFileHandler, {"path": "assets/"}),
        (r'/images/(.*)', tornado.web.StaticFileHandler, {"path": "assets/images/"}),
		(r'/style/(.*)', tornado.web.StaticFileHandler, {'path' : 'assets/style/'}),
        (r'/scripts/(.*)', tornado.web.StaticFileHandler, {'path' : 'assets/scripts/'})
	])

####
# When you run python restaurant.py, this runs and starts the tornado listner
####
if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()

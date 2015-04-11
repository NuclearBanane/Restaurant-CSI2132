#####
# Author: NuclearBanane
# Contributors : 
# Date : 2015/02/12
# Version : v0.1.2
#####

import tornado.ioloop   #Basic imports for the tornado library
import tornado.web      #

class BaseHandler(tornado.web.RequestHandler):
    def get_current_user(self):
        return self.get_secure_cookie("user")


class MainHandler(BaseHandler):
    def get(self):
        page = dict()
        #temporary to test Logins and cookies 
        if not self.current_user:
            self.redirect("/login")
            return
        else: 
            page['authenticated']='true'

        if not self.get_secure_cookie("mycookie"):
            self.set_secure_cookie("mycookie", "myvalue")
            #self.write("Your cookie was not set yet!")
        #else:
            #self.write("Your cookie was set!")

        page['test']='Hi, this is a test page'
        page['test2']='another great statement'
        page['Name']= tornado.escape.xhtml_escape(self.current_user)

        self.render("assets/frontpage.html",mest=page) 

class LoginHandler(BaseHandler):
    def get(self):
        self.write('<html><body><form action="/login" method="post">'
                   'Name: <input type="text" name="name">'
                   '<input type="submit" value="Sign in">'
                   '</form></body></html>')

    def post(self):
        self.set_secure_cookie("user", self.get_argument("name"))
        self.redirect("/")

class SignupHandler(BaseHandler):
    def get(self):
        return


####
# Tornado uses 'handlers' to take care of requests to certain URLs
# This makes certain API requests from a web page or such an easy to handle
# Unfortunatly it means we need to be very granular with our handlers
####

application = tornado.web.Application(
	[
		(r'/',              MainHandler),
        (r'/login',         LoginHandler),
        (r'/Signup',        SignupHandler),


		(r'/(favicon.ico)', tornado.web.StaticFileHandler, {'path': 'assets/'        }),
        (r'/images/(.*)',   tornado.web.StaticFileHandler, {'path': 'assets/images/' }),
        (r'/fonts/(.*)',    tornado.web.StaticFileHandler, {'path': 'assets/fonts/'  }),
		(r'/css/(.*)',      tornado.web.StaticFileHandler, {'path': 'assets/css/'    }),
        (r'/js/(.*)',       tornado.web.StaticFileHandler, {'path': 'assets/js/'     })
	],cookie_secret="__TODO:_GENERATE_YOUR_OWN_RANDOM_VALUE_HERE__")

####
# When you run python restaurant.py, this runs and starts the tornado listner
####
if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()

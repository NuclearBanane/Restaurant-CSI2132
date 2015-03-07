import tornado.ioloop   #Basic imports for the tornado library
import tornado.web      #


class MainHandler(tornado.web.RequestHandler):
	def get(self):
		self.render("assets/response.html")


application = tornado.web.Application(
	[
		(r"/", MainHandler),
		(r'/images/(.*)', tornado.web.StaticFileHandler, {"path": "assets/images/"}),
		(r'/style/(.*)', tornado.web.StaticFileHandler, {'path' : 'assets/style/'}),
        (r'/js/(.*)', tornado.web.StaticFileHandler, {'path' : 'assets/js/'})
	])


####
# When you run python restaurant.py, this runs and starts the tornado listner
####
if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()

In order to be able to use Slic3r application, you'll need to compile gui
while your X11 session is running. Some tests during compiling needs opengl
and wx wigdget to be created.

Here is what you need to do, launch a terminal and type :

	sudo su
	cd /opt/Slic3r
	perl Build.PL --gui

require 'tray_application'
require 'screenshot'

app = TrayApplication.new("Deskshot")
app.icon_filename = 'icon.gif'
app.item('Take Screenshot')  {Screenshot.capture}
app.item('Exit')             {java.lang.System::exit(0)}
app.run
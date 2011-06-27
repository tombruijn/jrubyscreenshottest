require 'tray_application'
# require 'screenshot'
require 'layer'

app = TrayApplication.new("Deskshot")
app.icon_filename = '../icon.gif'
app.item('Take Screenshot')  {Layer.start}
app.item('Exit')             {java.lang.System::exit(0)}
app.run
puts "Started tray"
require 'tray_application'
require 'selection_layer'
import com.sun.awt.AWTUtilities

app = TrayApplication.new("Screenshot grabber")
app.icon_filename = '../icon.gif'

app.item('Take Screenshot') do
  frame = SelectionLayer.new(nil)
end

app.item('Exit') { java.lang.System::exit(0) }
app.run

puts "Started tray"
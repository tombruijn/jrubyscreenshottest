require 'tray_application'
# require 'screenshot'
require 'selection_layer'
import com.sun.awt.AWTUtilities

app = TrayApplication.new("Deskshot")
app.icon_filename = '../icon.gif'
app.item('Take Screenshot') do
  frame = SelectionLayer.start
  begin
    AWTUtilities.setWindowOpacity(frame, (0.5).to_f)
  rescue
    puts "ERROR: Transparant layer not supported. Running GNOME?"
  end
end
app.item('Exit') { java.lang.System::exit(0) }
app.run
puts "Started tray"
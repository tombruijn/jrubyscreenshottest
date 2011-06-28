require 'tray_application'
require 'selection_layer'
import com.sun.awt.AWTUtilities

app = TrayApplication.new("Screenshot grabber")
app.icon_filename = '../icon.gif'

app.item('Take Screenshot') do
  frame = SelectionLayer.new
  begin
    AWTUtilities.setWindowOpacity(frame, (0.8).to_f)
  rescue
    puts "ERROR: Transparant layer not supported. Running GNOME?"
  end
end

app.item('Exit') { java.lang.System::exit(0) }
app.run

puts "Started tray"
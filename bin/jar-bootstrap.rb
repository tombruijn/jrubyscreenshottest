require 'tray_application'
# require 'screenshot'
require 'layer'
# import com.sun.awt.AWTUtilities
  java_import 'com.sun.awt.AWTUtilities'

app = TrayApplication.new("Deskshot")
app.icon_filename = '../icon.gif'
app.item('Take Screenshot') do
  frame = Layer.start
  # if AWTUtilities.isTranslucencySupported(AWTUtilities.Translucency.TRANSLUCENT)
    AWTUtilities.setWindowOpacity(frame, (0.5).to_f)
  # end
end
app.item('Exit')             {java.lang.System::exit(0)}
app.run
puts "Started tray"
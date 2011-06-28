include Java

import java.awt.Desktop
import java.awt.Robot
import java.awt.Toolkit
import java.awt.Rectangle
import javax.imageio.ImageIO

class Screenshot
  
  attr_accessor :file_location
  
  def self.capture_fullscreen
    screenshot = Screenshot.new
    
    # Get the size of the screen and use that as dimensions for the screenshot
    toolkit   = Toolkit.get_default_toolkit
    dim       = toolkit.get_screen_size
    screenshot.capture_image(0, 0, dim.get_width, dim.get_height)

    screenshot.open_file
  end
  
  def self.capture_section(x,y,width,height)
    screenshot = Screenshot.new
    screenshot.capture_image(x,y,width,height)

    screenshot.open_file
  end
  
  # Open the file in the users default application for the given file type
  # This will probably become optional at some point
  def open_file
    desktop = Desktop.get_desktop
    desktop.open(self.file_location)
  end
  
  def capture_image(x,y,width,height)
    robot     = Robot.new
    rectangle = Rectangle.new(x, y, width, height)
    image     = robot.create_screen_capture(rectangle)
    
    time_now = Time.now
    self.file_location = java::io::File.new("screenshot_#{time_now.strftime('%Y_%m_%d_%H_%M_%S')}.png")
    ImageIO::write(image, "png", self.file_location)
  end
  
end

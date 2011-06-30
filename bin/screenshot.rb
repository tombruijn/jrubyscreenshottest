include Java

import java.awt.Desktop
import java.awt.Robot
import java.awt.Toolkit
import java.awt.Rectangle
import javax.imageio.ImageIO

class Screenshot
  
  # Steps
  # 1. Get the image, size specified
  # 2. Decide what to do with it:
  #    a. Get it as an object (for GNOME fix)
  #    b. Save it to disk or something else depending on the methods supported.
  # 3. Get confirmation of success
  
  attr_accessor :file, :image
  
  def self.capture_fullscreen
    screenshot = Screenshot.new
    screenshot.capture_fullscreen_image
    
    screenshot.save_to_file
    screenshot.open_file
  end
  
  def self.capture_section(x,y,width,height)
    screenshot = Screenshot.new
    screenshot.capture_image(x,y,width,height)
    
    screenshot.save_to_file
    screenshot.open_file
  end
  
  def save_to_file
    time_now = Time.now
    self.file = java::io::File.new("screenshot_#{time_now.strftime('%Y_%m_%d_%H_%M_%S')}.png")
    ImageIO::write(self.image, "png", self.file)
  end
  
  # Open the file in the users default application for the given file type
  # This will probably become optional at some point
  def open_file
    if self.file and self.file.exists?
      desktop = Desktop.get_desktop
      desktop.open(self.file)
    end
  end

  def capture_fullscreen_image
    # Get the size of the screen and use that as dimensions for the screenshot
    toolkit   = Toolkit.get_default_toolkit
    dim       = toolkit.get_screen_size
    rectangle = Rectangle.new(0, 0, dim.get_width, dim.get_height)
    robot     = Robot.new
    self.image= robot.create_screen_capture(rectangle)
  end

  def capture_image(x,y,width,height)
    robot     = Robot.new
    rectangle = Rectangle.new(x, y, width, height)
    self.image= robot.create_screen_capture(rectangle)
  end
  
end

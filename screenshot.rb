class Screenshot
  include Java

  import java.awt.Desktop
  import java.awt.Robot
  import java.awt.Toolkit
  import java.awt.Rectangle
  import javax.imageio.ImageIO

  def self.capture()
    robot     = Robot.new
    toolkit   = Toolkit.get_default_toolkit
    dim       = toolkit.get_screen_size
    rectangle = Rectangle.new(0, 0, dim.get_width, dim.get_height)
    image     = robot.create_screen_capture(rectangle)
    
    time_now = Time.now
    file  = java::io::File.new("screenshot_#{time_now.strftime('%Y_%m_%d_%H_%M_%S')}.png")
    ImageIO::write(image, "png", file)

    # Open the file in the users default application for the given file type
    desktop = Desktop.get_desktop
    desktop.open(file)
  end
end

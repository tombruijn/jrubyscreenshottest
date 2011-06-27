class Layer
  include Java

  import java.awt.Desktop
  import java.awt.Robot
  import java.awt.Toolkit
  import java.awt.Rectangle
  import javax.imageio.ImageIO
  import javax.swing.JFrame
  import javax.swing.JLabel
  import java.awt.Color
  import com.sun.awt.AWTUtilities

  def self.start()
    robot     = Robot.new
    toolkit   = Toolkit.get_default_toolkit
    dim       = toolkit.get_screen_size
    # rectangle = Rectangle.new(0, 0, dim.get_width, dim.get_height)
    # image     = robot.create_screen_capture(rectangle)
    
    frame = JFrame.new 'Transparant layer'
    frame.set_bounds(0,0,dim.get_width, dim.get_height)
    frame.default_close_operation = JFrame::EXIT_ON_CLOSE
    
    frame.get_content_pane().add(JLabel.new("wa"))
    frame.set_undecorated(true)
    # frame.setBackground(Color.new(0,0,0,0))
    # frame.set_opacity(0.5)
    if AWTUtilities.isTranslucencySupported frame
      AWTUtilities.setWindowOpacity(frame, 0.5)
    end
    # frame.setBackground(Color.new(1.0, 1.0, 1.0, 0.25))
    frame.visible = true
  end
end

class Layer
  include Java

  import java.awt.Desktop
  import java.awt.Robot
  import java.awt.Toolkit
  import java.awt.Rectangle
  import javax.imageio.ImageIO
  import javax.swing.JFrame
  import javax.swing.JLabel
  import java.awt.MouseInfo
  import java.awt.PointerInfo

  def self.start()
    robot     = Robot.new
    toolkit   = Toolkit.get_default_toolkit
    dim       = toolkit.get_screen_size
    # rectangle = Rectangle.new(0, 0, dim.get_width, dim.get_height)
    # image     = robot.create_screen_capture(rectangle)
    
    @frame = JFrame.new 'Transparant layer'
    @frame.set_bounds 0,0,dim.get_width, dim.get_height
    @frame.default_close_operation = JFrame::EXIT_ON_CLOSE
    
    @frame.set_undecorated true
    @frame.visible = true
    
    @frame.get_content_pane().add(JLabel.new("#{MouseInfo.getPointerInfo().getLocation()}"))
    
    @frame
  end
end

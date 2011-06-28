include Java

import java.awt.Desktop
import java.awt.Robot
import java.awt.Toolkit
import java.awt.Rectangle
import javax.imageio.ImageIO
import javax.swing.JFrame
import javax.swing.JLabel
import javax.swing.JComponent
import java.awt.MouseInfo
import java.awt.PointerInfo

class Layer

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
    
    @frame.get_content_pane().add JLabel.new("#{MouseInfo.getPointerInfo().getLocation()}")
    can = MyCanvas.new
    can.addMouseListener MouseAction.new(can)
    @frame.getContentPane().add can
    @frame
  end
end

import java.awt.event.MouseAdapter
class MyCanvas < JComponent
  include java.awt.event
  
  def initialize
    # addMouseListener(this)
  end
  
  def paint(g)
    # g.drawRect(10, 10, 200, 200)
    
  end
  
  def draw_rect(x,y,x2,y2)
    g = get_graphics()
    # g.dispose()
    # g.paint()
    g.drawRect(x, y, x2-x, y2-y)
  end
  
end

class MouseAction < MouseAdapter
  @fr = nil
  @point = nil
  def initialize(frame)
    super()
    @fr = frame
  end

  def mousePressed(e)
    @point = e.get_point
  end

  def mouseReleased e
    @fr.draw_rect(@point.x,@point.y,e.get_point().x,e.get_point().y)
  end
  
end
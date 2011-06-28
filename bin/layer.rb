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
    # @frame.default_close_operation = JFrame::EXIT_ON_CLOSE
    
    @frame.set_undecorated true
    @frame.visible = true
    
    @frame.get_content_pane().add JLabel.new("#{MouseInfo.getPointerInfo().getLocation()}")
    @frame.create_graphics
    @frame.getContentPane().add can
    @frame
  end
  
  def create_graphics
    can = MyCanvas.new @frame
    can.addMouseListener MouseAction.new(can)
    can.addMouseMotionListener MouseAction.new(can)
  end
end

import java.awt.event.MouseAdapter
import java.awt.Color
class MyCanvas < JComponent
  include java.awt.event
  
  @frame
  def initialize(frame)
    @frame = frame
    # addMouseListener(this)
  end
  
  def draw_rect(x,y,x2,y2)
    # repaint()
    g = get_graphics()
    paint(g)
    g.setColor(Color.red)
    # g.dispose()
    if x < x2
      g.drawRect(x, y, x2-x, y2-y)
    else
      g.drawRect(x2, y2, x-x2, y-y2)
    end
  end
  
end

class MouseAction < MouseAdapter
  @fr = nil
  @@startpoint = nil
  def initialize(frame)
    super()
    @fr = frame
  end

  def mousePressed(e)
    @@startpoint = e.get_point
  end
  
  def mouseDragged(e)
    # puts "wa"
    @fr.draw_rect(@@startpoint.x,@@startpoint.y,e.get_point().x,e.get_point().y)
  end

  def mouseReleased(e)
    @fr.draw_rect(@@startpoint.x,@@startpoint.y,e.get_point().x,e.get_point().y)
  end
  
end
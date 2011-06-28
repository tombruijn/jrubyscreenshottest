include Java

require 'screenshot'

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

class Layer < JFrame

  def self.start()
    robot     = Robot.new
    toolkit   = Toolkit.get_default_toolkit
    dim       = toolkit.get_screen_size
    # rectangle = Rectangle.new(0, 0, dim.get_width, dim.get_height)
    # image     = robot.create_screen_capture(rectangle)
    
    @frame = Layer.new 'Transparant layer'
    @frame.set_bounds 0,0,dim.get_width, dim.get_height
    # @frame.default_close_operation = JFrame::EXIT_ON_CLOSE
    
    @frame.set_undecorated true
    @frame.visible = true
    
    # get_content_pane().add JLabel.new("#{MouseInfo.getPointerInfo().getLocation()}")
    @frame.cg()
    @frame
  end
  
  def cg
    can = MyCanvas.new @frame
    action = MouseAction.new(can)
    can.addMouseListener action
    can.addMouseMotionListener action
    getContentPane().add(can)
  end
end

import java.awt.event.MouseAdapter
import java.awt.Color
class MyCanvas < JComponent
  include java.awt.event
  
  @frame
  def initialize(frame)
    super()
    @frame = frame
  end
  
  def draw_rect(x,y,x2,y2)
    g = get_graphics()
    g.setColor(Color.red)
    if x < x2
      g.drawRect(x, y, x2-x, y2-y)
    else
      g.drawRect(x2, y2, x-x2, y-y2)
    end
  end
  
end

class MouseAction < MouseAdapter
  @fr = nil
  @startpoint = nil
  def initialize(frame)
    super()
    @fr = frame
  end

  def mousePressed(e)
    @startpoint = e.get_point
  end
  
  def mouseDragged(e)
    @fr.draw_rect(@startpoint.x,@startpoint.y,e.get_point().x,e.get_point().y)
  end

  def mouseReleased(e)
    @fr.draw_rect(@startpoint.x,@startpoint.y,e.get_point().x,e.get_point().y)
    width = 200
    height = 200
    if @startpoint.x < e.get_point().x
      width = e.get_point().x - @startpoint.x
      height = e.get_point().y - @startpoint.y
    else
      width = @startpoint.x - e.get_point().x
      height = @startpoint.y - e.get_point().y
    end
    # Create screenshot but cut off the red outer rectangle
    width -= 1
    height -= 1 
    Screenshot.capture_section(@startpoint.x-1,@startpoint.y-1,width,height)
  end
  
end
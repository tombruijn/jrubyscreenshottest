include Java

require 'screenshot'

import java.awt.Color
import java.awt.Robot
import java.awt.Toolkit
import java.awt.MouseInfo
import java.awt.PointerInfo
import javax.swing.JFrame
import javax.swing.JComponent
import java.awt.event.MouseAdapter
import java.awt.Graphics2D

class SelectionLayer < JFrame

  def initialize(name = "Transparent layer")
    super(name)
    
    # Get the size of the screen
    robot     = Robot.new
    toolkit   = Toolkit.get_default_toolkit
    dim       = toolkit.get_screen_size
    
    # Create a fullscreen frame
    self.set_bounds(0,0,dim.get_width, dim.get_height)
    # No borders
    self.set_undecorated(true)
    self.visible = true
    
    # Add a draw panel to make something selectable
    can = SelectionCanvas.new(self)
      # MouseAction records mouse movements
      action = MouseAction.new(can)
      can.addMouseListener(action)
      can.addMouseMotionListener(action)
    getContentPane.add(can)

    self # Needed to make the frame transparent later
  end

end

class SelectionCanvas < JComponent
  include java.awt.event
  attr_accessor :frame
  
  def initialize(f)
    super()
    self.frame = f
  end
  
  def draw_rect(x,y,x2,y2)
    g = get_graphics
    g.clear_rect(0,0,self.frame.get_size.width,self.frame.get_size.height)
    g.setColor(Color.red)
    
    # Default behavior of dragging is from top left to bottom right
    width = 0
    height = 0
    if x < x2
      width = x2 - x
    else
      width = x - x2
      # Resetting startpoint when dragging to the left side on your screen
      x = x - width
    end
    if y < y2
      height = y2 - y
    else
      height = y - y2
      # Resetting startpoint when dragging to the top side on your screen
      y = y - height
    end
    # Create selection rectangle
    g.drawRect(x, y, width, height)
  end
  
  def close
    self.frame.set_visible(false)
  end
  
end

class MouseAction < MouseAdapter
  attr_accessor :canvas, :startpoint
  
  def initialize(c)
    super()
    self.canvas = c
  end

  def mousePressed(e)
    # Save startpoint, needed for creating a screenshot
    self.startpoint = e.get_point
  end
  
  def mouseDragged(e)
    # Draw selection
    self.canvas.draw_rect(self.startpoint.x,self.startpoint.y,e.get_point().x,e.get_point().y)
  end

  def mouseReleased(e)
    # Draw final selection
    self.canvas.draw_rect(self.startpoint.x,self.startpoint.y,e.get_point().x,e.get_point().y)
    # Exit layer
    self.canvas.close()
    
    # Default size, just in case something fails
    width = 200
    height = 200
    
    # Left to right or right to left drag?
    if self.startpoint.x < e.get_point().x
      width = e.get_point().x - self.startpoint.x
      height = e.get_point().y - self.startpoint.y
    else
      width = self.startpoint.x - e.get_point().x
      height = self.startpoint.y - e.get_point().y
    end
    
    # Create screenshot but cut off the red outer rectangle
    width -= 1
    height -= 1
    Screenshot.capture_section(self.startpoint.x-1,self.startpoint.y-1,width,height)
  end
  
end
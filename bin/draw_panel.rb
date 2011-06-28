require 'java'

java_import 'javax.swing.JFrame'
java_import 'javax.swing.JPanel'
java_import 'java.awt.Dimension'
java_import 'java.awt.Graphics'
java_import 'java.awt.event.MouseEvent'
java_import 'java.awt.event.MouseMotionListener'

class DrawPanel < JPanel
  include MouseMotionListener
  attr_accessor :draw_x, :draw_y
  def paint_ecomponent(graphics)
    graphics.draw_oval(@draw_x, @draw_y, 10, 10)
  end
  def mouse_edragged(event)
    @draw_x = event.x
    @draw_y = event.y
    repaint
  end
  def mouse_emoved(event)
  end
  # alias_method :mouseDragged, :mouse_dragged
  # alias_method :mouseMoved, :mouse_moved
  # alias_method :paintComponent, :paint_component
end

frame = JFrame.new 'JRuby Paint'
frame.size = Dimension.new 640, 480
panel = DrawPanel.new
panel.add_mouse_motion_listener(panel)
frame.add panel
frame.visible = true
# JRuby ScreenShot Test

Most credit goes to: http://rubylearning.com/blog/2010/09/29/an-introduction-to-desktop-apps-with-ruby/

I'm trying to build something from there.

Bugs:
- Unity - location positioning is off, I'm guessing 10px from the top as there is a bar there. Don't tell me unity doesn't regard that as part of the fullscreen.

Ideas:
- Don't use a fullscreen frame, but instead something that can draw a rectangle on the native OS's screen.
- Also make the "take screenshot" option something that can be called by a native shortcut. Such as: Windows + S (Windows), Ctrl + Alt + S (Linux), Command + Ctrl + S (Mac).
- Dropbox implementation. The reason why I'm making this!
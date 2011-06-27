
desc "Build application to .jar file"
task :build do
  app_name = "myapp"
  %x(unlink #{app_name}.jar)
  %x(cp jruby-complete.jar #{app_name}.jar)
  puts %x(rvm use jruby && jar ufe #{app_name}.jar org.jruby.JarBootstrapMain jar-bootstrap.rb screenshot.rb tray_application.rb icon.gif)
end
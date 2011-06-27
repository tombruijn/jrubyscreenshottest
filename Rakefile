
desc "Build application to .jar file"
task :build do
  app_name = "myapp"
  bin_dir = "bin/"
  %x(unlink #{app_name}.jar)
  puts "cp jruby-complete.jar #{app_name}.jar"
  %x(cp jruby-complete.jar #{app_name}.jar)
  # puts "rvm use jruby && jar ufe #{app_name}.jar org.jruby.JarBootstrapMain #{bin_dir}jar-bootstrap.rb #{bin_dir}screenshot.rb #{bin_dir}tray_application.rb #{bin_dir}layer.rb"
  puts %x(rvm use jruby && jar ufe #{app_name}.jar org.jruby.JarBootstrapMain -C bin/ jar-bootstrap.rb -C bin/ screenshot.rb -C bin/ tray_application.rb -C bin/ layer.rb)
  %x(chmod +x #{app_name}.jar) # Make executable
end
require 'find'
require 'fileutils'

class String
  def colorize(color_code); "#{color_code}#{self}\e[0m"; end
  def red; colorize("\e[31m"); end
  def green; colorize("\e[32m"); end
end

# File paths
source_dir = "/Users/echo/Desktop/Warhammer"
dest_dir = "/Users/echo/dev/bukowskis/output"


# File types to copy (dot included, case ignored)
file_exts = [".tiff", ".tif", ".jpg", ".jpeg", ".png"]

# Create destination directory if it doesn't exist
if not File.exists?(dest_dir)
  puts "Creating output directory"
  FileUtils.mkdir_p dest_dir
end

# Create file list
filelist = Array.new
Find.find(source_dir) do |path|
    filelist << path
end

# First entry is source dir - cut that
filelist.shift

# Move some bits
for file in filelist
  # Show path relative to source dir
  puts "Source: ".green + file.sub(source_dir, "")

  # Only copy file types we want
  if File.file?(file) and file_exts.include?(File.extname(file).downcase)
    dest_file = dest_dir + file
    dest_path = File.dirname(File.expand_path(dest_file))

    puts "Target: ".green + dest_file.sub!(source_dir, "")
    puts "Size: ".green + File.size(file).to_s

    # Create target dir
    FileUtils.mkdir_p dest_path
    FileUtils.cp(file, dest_file)

    puts
  else
    puts "Skipped".red
    puts
  end
end
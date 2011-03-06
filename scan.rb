require 'find'
require 'fileutils'

class String
  def colorize(color_code); "#{color_code}#{self}\e[0m"; end
  def red; colorize("\e[31m"); end
  def green; colorize("\e[32m"); end
end

# File paths
source_dirs = ["/Users/echo/Desktop/Warhammer"]
dest_dir = "/Users/echo/dev/bukowskis/output"


# File types to copy (dot included, case ignored)
file_exts = [".tiff", ".tif", ".jpg", ".jpeg"]

# Create destination directory if it doesn't exist
if not File.exists?(dest_dir)
  puts "Creating output directory"
  FileUtils.mkdir_p dest_dir
end

# Create file list
filelist = Array.new
for dir in source_dirs
  Find.find(dir) do |path|
    filelist << path
  end
end

# First entry is source dir - cut that
filelist.shift

# Move some bits
for file in filelist
  puts "File: ".red + file
  # Only copy file types we want
  if file_exts.include?(File.extname(file))
    dest_file = dest_dir + file
    dest_path = File.dirname(File.expand_path(dest_file))

    puts "Dest: ".green + dest_file
    puts "Size: ".green + File.size(file).to_s

    # Create target dir
    FileUtils.mkdir_p dest_path 
    FileUtils::DryRun.cp(file, dest_file)

    print "\n"
  else
    puts "Skipped".red  
  end
end
require 'find'
require 'fileutils'
require 'digest/md5'

class String
  def colorize(color_code); "#{color_code}#{self}\e[0m"; end
  def red; colorize("\e[31m"); end
  def green; colorize("\e[32m"); end
end

# File paths
source_dirs = ["/Volumes/S170 649-1011"]
dest_dir = "output"

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
  dest_file = dest_dir + file
  dest_path = File.dirname(File.expand_path(dest_file))

  puts "File: ".red + file
  puts "Dest: ".green + dest_file
  puts "Size: ".green + File.size(file).to_s

  # Create target dir
  FileUtils.mkdir_p dest_path 
  FileUtils::DryRun.cp(file, dest_file)

  print "\n"
end
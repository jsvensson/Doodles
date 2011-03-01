require 'find'
require 'fileutils'
require 'digest/md5'

class String
  def colorize(color_code); "#{color_code}#{self}\e[0m"; end
  def red; colorize("\e[31m"); end
  def green; colorize("\e[32m"); end
end

# File paths
source_dirs = ["source"]
dest_dir = "output"

# Create destination directory if it doesn't exist
if not File.exists?(dest_dir)
  puts "Creating output directory"
  FileUtils.mkdir dest_dir
end

# Create file/directory list
filelist  = Array.new
dirlist   = Array.new
for dir in source_dirs
  Find.find(dir) do |path|
    if FileTest.directory?(path)
      dirlist << path
    else
      filelist << path
    end
  end
end

# Replicate source directory structure at destination

FileUtils.cd(dest_dir) do
  for dir in dirlist
    if not File.exists?(dir)
      FileUtils.mkdir dir
    end
  end
end

# Move some bits
for file in filelist
  puts file
  md5_in = Digest::MD5.file(file).hexdigest
  puts "in:  #{md5_in}"

  # Copy file to destination
  dest_file = dest_dir + "/" + file
  FileUtils.copy_file(file, dest_file)

  # Verify checksums
  md5_out = Digest::MD5.file(dest_file).hexdigest
  print "out: " + md5_out + " ["
  if md5_in == md5_out
    print " OK ".green
  else
    print "FAIL".red
  end
  print "]\n\n"
end
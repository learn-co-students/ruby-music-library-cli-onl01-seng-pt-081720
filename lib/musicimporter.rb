require "pry"

class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(path).select do |mp3|
      mp3.include?(".mp3")
    end
  end

  def import
    files.each do |song|
      Song.create_from_filename(song)
    end

  end

end

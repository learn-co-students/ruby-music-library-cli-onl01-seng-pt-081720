class MusicImporter

  def initialize(path)
    @path = path
  end

  def path
    File.path("./spec/fixtures/mp3s")
  end

  def files
    Dir.chdir(@path){|path| Dir.glob("*.mp3")}
  end

  def import
  files.each {|name|  Song.create_from_filename(name)}
  end
end

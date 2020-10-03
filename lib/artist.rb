class Artist
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear()
  end

  def save
    @@all << self
  end

  def self.create(new_artist)
    artist = self.new(new_artist)
    @@all << artist
    artist
  end

  def songs
    @songs
  end

  def add_song(song)
    @songs << song
  end
end

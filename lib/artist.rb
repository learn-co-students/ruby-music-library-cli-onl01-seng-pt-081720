class Artist
  extend Concerns::Findable
  
  attr_accessor :name, :songs, :genres

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(artist)
    artist = self.new(artist)
    artist.save
    artist
  end

  def add_song(song)
    song.artist = self unless song.artist
    songs << song unless songs.include?(song) # unless - doesn't add if found in collection
  end

  def genres
    self.songs.collect { |song| song.genre }.uniq
  end
end
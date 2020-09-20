require "pry"

class Artist
  attr_accessor :name, :songs, :genre
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def self.create(name)
    new_artist = self
    @@all << new_artist
    new_artist
  end

  def add_song(song)
    if song.artist == nil
      song.artist = self
    end
    counter = 0
    self.songs.each do |a|
      if a.name == song.name
        counter = 1
      end
    end
    if counter == 0
      @songs << song
    end
  end

  def genres
    coll = []
    songs.each do |g|
      if coll.include?(g.genre)
      else
        coll << g.genre
      end
    end
    coll
  end

end

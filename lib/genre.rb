require "pry"

class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs
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
    new_genre = self
    @@all << new_genre
    new_genre
  end

  def artists
    coll = []
    songs.each do |g|
      if coll.include?(g.artist)
      else
        coll << g.artist
      end
    end
    coll
  end

  #artists
        #returns a collection of artists for all of the genre's songs (genre has many artists through songs)
end

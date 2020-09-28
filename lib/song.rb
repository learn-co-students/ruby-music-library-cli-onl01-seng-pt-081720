require "pry"

class Song

  attr_accessor :name, :genre
  attr_reader :artist#,:genre

  @@all = []
  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist != nil
      self.artist = (artist)
    end
    if genre != nil
      self.genre = (genre)
    end
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
    new_song = self.new(name)
    new_song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    if genre.songs.include?(self)
    else
      genre.songs << self
    end
  end

  def self.find_by_name(name)
    @@all.detect do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    if find_by_name(name)
      return find_by_name(name)
    else
      self.create(name)
    end
  end

  def self.new_from_filename(filename)
    song = filename.split(" - ")
    artist = song[0]
    name = song[1]
    temp = song[2].split(".")
    genre = temp[0]
    genre = Genre.find_or_create_by_name(genre)
    artist = Artist.find_or_create_by_name(artist)
    self.new(name, artist, genre)
  end

  def self.create_from_filename(filename)
    news = self.new_from_filename(filename)
  end

end

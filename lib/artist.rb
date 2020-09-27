class Artist

  attr_accessor :name, :songs

  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    new_artist = self.new(name)
    new_artist.save
    new_artist
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def add_song(song)
    if song.artist == nil || !song.artist
      song.artist = self
    end
    if !self.songs.include?(song)
      self.songs << song
    end
  end

  def genres
    genre_list = []
    self.songs.collect do |song|
      genre_list << song.genre
    end
    genre_list.uniq
  end

end

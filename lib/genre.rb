class Genre
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def artists
    songs.collect{ |s| s.artist }.uniq
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
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

  def self.create(new_genre)
    genre = self.new(new_genre)
    @@all << genre
    genre
  end
end

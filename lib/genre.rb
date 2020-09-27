class Genre

  attr_accessor :name, :songs

  extend Concerns::Findable
  
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    new_genre = self.new(name)
    new_genre.save
    new_genre
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

  def artists
    artist_list = []
    self.songs.collect do |song|
      artist_list << song.artist
    end
    artist_list.uniq
  end

end

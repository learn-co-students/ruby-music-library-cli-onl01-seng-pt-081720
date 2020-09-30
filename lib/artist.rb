class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs
@@all=[]
  def initialize(name)
    @name=name
    @songs = []
    save
  end

  def save
    @@all<<self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
   new(name)
  end

  def songs
    Song.all.each do |s|
      s.artist == self
    end
  end

  def add_song(song)
    song.artist = self unless song.artist == self
    @songs << song unless @songs.include?(song)
  end

  def genres
    self.songs.collect {|s|
    s.genre}.uniq
  end

  def self.count
    @@all.size
  end

end

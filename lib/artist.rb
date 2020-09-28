class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs
@@all=[]
  def initialize(name)
    @name=name
    @songs = []
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
    c = self.new(name)
    c.save
    c
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
  #
  # def name
  #   self.name
  # end
end

class Artist 
  attr_accessor :name
  attr_reader :songs 
  extend Concerns::Findable
  @@all = [] 
  
  def initialize(name)
    @name = name 
    @songs = []
  end
  
  def self.all 
    @@all 
  end
  
  def save 
    self.class.all << self 
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name)
    artist = self.new(name)
     artist.save
    artist
  end

  def add_song(song)
      song.artist = self unless song.artist 
      songs.push song unless songs.include?(song)
  end
  
  def genres 
    songs.collect{|song| song.genre}.uniq
  end
end
class Artist 
  attr_accessor :name , :songs , :genres 
  @@all = [] 
  
  def initialize (name)
    @name = name 
    @@all << self 
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
  
  def self.create (name)
   artist = Artist.new (name)
    self.all << artist 
    artist 
  end 
  
   def add_song(song)
    if song.artist == nil
      song.artist = self
    else
      nil
    end
    if @songs.include?(song)
      nil
    else
      @songs << song
    end
    song
  end
  
  def genres 
    @new_genre = [] 
    @songs.each do |song|
  if @new_genre.include?(song.genre)
        nil
      else
        @new_genre << song.genre
      end
    end
    @new_genre 
  end
  
end 
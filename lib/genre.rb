class Genre 
  
  attr_accessor :name , :songs , :artists 
   extend Concerns::Findable
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
    @@all.clear 
  end 
  
  def save 
    @@all << self 
  end 
    
    def self.create (name) 
   genre = Genre.new (name)
    self.all << genre 
    genre 
  end 
  
  def artists 
     @new_artists = [] 
    @songs.each do |song|
  if @new_artists.include?(song.artist)
        nil
      else
        @new_artists << song.artist
      end
    end
    @new_artists  
  end
  
  
end 
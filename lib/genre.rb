class Genre 
  
  attr_accessor :name 
  
  @@all = []
  
  def initialize(name)
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
  
  def self.create(genre)
    genre = self.new(genre)
    genre.save 
    genre
  end 
  
  def songs 
    @songs 
  end 
  
  
end 
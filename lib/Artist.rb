require 'pry'
class Artist
  attr_accessor :name
  extend Concerns::Findable
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
    save
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
  
  def self.create(artist)
    artist = self.new(artist)
    artist.save
    artist
  end
  
  def songs
    @songs
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
    collection_array = []
    @songs.each do |song|
      if collection_array.include?(song.genre)
        nil
      else
        collection_array << song.genre
   end
    end
    collection_array
  end
    
  
  
  
  
end
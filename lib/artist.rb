require 'pry'

class Artist 
  
  extend Concerns::Findable
  
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
  
  def self.create(artist)
    artist = self.new(artist)
    artist.save
    artist 
  end 
  
  def songs 
    @songs 
  end 
  
  def add_song(song)
    @songs << song unless songs.include?(song)
    if song.artist == nil
      song.artist = self
    end
  end 
  
  def genres 
    self.songs.collect { |song| song.genre }.uniq 
  end 
  
end 
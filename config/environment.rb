require 'bundler'
require 'pry'
Bundler.require

module Concerns
end

require_all 'lib'

module Concerns::Findable
  def find_by_name(name)
    all.find do |o|
      o.name == name
    end
  end
  def find_or_create_by_name(name)
    find_by_name(name) || self.create(name)
  end
end 


 class Song
  extend Concerns::Findable
  attr_accessor :name
  @@all = [] 
  def initialize(name,artist=nil,genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  def self.all
    @@all
  end
  def self.destroy_all
    self.all.clear
  end
  def save
    @@all << self
  end
 
 
 def self.create(name)
    song = self.new(name)
    song.save
    song
  end
 
 
 
 
  def artist=(artist)
    if @artist == nil
      @artist = artist
    else
      @artist = @artist
    end
    if self.artist != nil
      @artist.add_song(self)
    end
    @artist
  end
  def artist
    @artist
  end
  def genre=(genre)
    if @genre == nil
      @genre = genre
    else
      @genre= @genre
    end
    if self.genre != nil
      @genre.add_song(self)
    end
    @genre
  end
  def genre
    @genre
  end
  def self.find_by_name(name)
    @@all.find do |song|
        song.name == name
    end
  end
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
    end
  def self.create_from_filename(name)
    @@all << self.new_from_filename(name)
  end
  def self.new_from_filename(name)
    song_name = name.split(" - ")[1]
    artist_name = name.split(" - ")[0]
    genre_name = name.split(" - ")[2].chomp(".mp3")
    song = self.find_or_create_by_name(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_name)
    song
  end
end

class Artist
  extend Concerns::Findable
  attr_accessor :name
  @@all = []
  def initialize(name)
    @name = name
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
 
 def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end
 
 
 
 
  def songs
    @songs
  end
  def add_song(song)
    song.artist = self unless song.artist == self
    @songs << song unless @songs.include?(song)
  end
  def genres
    genres = @songs.collect do |song|
      song.genre
    end
    genres.uniq
  end
end


class Genre
  extend Concerns::Findable
  attr_accessor :name
  @@all = []
  def initialize(name)
    @name = name
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
 
 def self.create(string)
    new_genre = Genre.new(string)
  end
 
 
  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end
 
 
 
  def songs
    @songs
  end
  def add_song(song)
    song.genre = self unless song.genre == self
    @songs << song unless @songs.include?(song)
  end
  def artists
    artists = @songs.collect do |song|
      song.artist
    end
    artists.uniq
  end
end

class MusicImporter
  def initialize(path)
   @path = path
  end
  def path
    @path
  end 
  def files()
    @files ||= Dir.glob("#{@path}/*.mp3").collect{ |file| file.gsub("#{@path}/", "") }
  end
  def import()
    files.each do |filename|
      Song.create_from_filename(filename)
    end 
  end
  
end

class MusicLibraryController
  
  extend Concerns::Findable
  
  def initialize(path = "./db/mp3s")
    new_importer_object = MusicImporter.new(path)
    new_importer_object.import
  end
  
  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
      end 
      end
      
       def list_songs
        Song.all.uniq.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
        puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
       end
       end
       def list_artists
        artists = Artist.all.uniq.sort {|a,b| a.name <=> b.name}
        artists.each.with_index(1) {|artist, i| puts "#{i}. #{artist.name}"}
        end
        def list_genres
          genres = Genre.all.uniq.sort {|a,b| a.name <=> b.name}
          genres.each.with_index(1) {|genre, i| puts "#{i}. #{genre.name}"}
        end
         def list_songs_by_artist
         puts "Please enter the name of an artist:"
         input = gets.strip

         if artist = Artist.find_by_name(input)
         artist.songs.uniq.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, i|
          puts "#{i}. #{song.name} - #{song.genre.name}"
        end
        end
        end 
      
         def list_songs_by_genre
         puts "Please enter the name of a genre:"
         input = gets.strip

         if genre = Genre.find_by_name(input)
         genre.songs.uniq.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, i|
          puts "#{i}. #{song.artist.name} - #{song.name}"
         end
         end
         end
         
         def play_song
           puts "Which song number would you like to play?"
           input = gets.chomp.to_i 
           songs = Song.all
           
           if (1..songs.length).include?(input)
             song = Song.all.uniq.sort { |a,b| a.name <=> b.name} [input - 1]
           end 
           puts "Playing #{song.name} by #{song.artist.name}" if song
           end
   
  end




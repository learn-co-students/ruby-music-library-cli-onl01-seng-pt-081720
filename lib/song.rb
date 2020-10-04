require 'pry'
class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    self.name = name
    self.artist = artist
    self.genre = genre
  end

  def artist=(artist_instance)
    @artist = artist_instance
    @artist.add_song(self) if @artist
  end

  def genre=(genre_instance)
    @genre = genre_instance
    @genre.add_song(self) if @genre
    if @genre && !@genre.songs.include?(self)
      @genre.songs << self
    end
  end


  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear()
  end

  def save
    @@all << self
  end

  def self.create(new_song)
    song = self.new(new_song)
    @@all << song
    song
  end

  def self.new_from_filename(file)
      song_info = file.chomp(".mp3").split(" - ")
      song = Song.new(song_info[1])
      song.artist= Artist.find_or_create_by_name(song_info[0])
      song.genre = Genre.find_or_create_by_name(song_info[2])
      song
  end

  def self.create_from_filename(file)
    song = new_from_filename(file)
    @@all << song
    song
  end
end

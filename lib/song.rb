require 'pry'

class Song
    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
        @@all << self       
        
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all = []
    end

    def save
        @@all << self
    end

    def self.create(name)
        Song.new(name)
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)        
    end

    def genre=(genre)
        @genre = genre
        if @genre.songs.none? {|x| x == self}
            @genre.songs << self
        end
    end

    def self.find_by_name(name)
        @@all.find {|x| x.name == name}
    end

    def self.find_or_create_by_name(name)
        if find_by_name(name) == nil
            create(name)
        else
            find_by_name(name)
        end
    end

    def self.new_from_filename(filename)
        song = filename.split(" - ")
        new_name = song[1]
        new_artist = song [0]
        new_genre = song[2].chomp(".mp3")
        
        song = find_or_create_by_name(new_name)
        song.artist = Artist.find_or_create_by_name(new_artist)
        song.genre = Genre.find_or_create_by_name(new_genre)
        song
    end

    def self.create_from_filename(filename)
        @@all << new_from_filename(filename)
    end


end
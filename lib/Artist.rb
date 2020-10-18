require 'pry'

class Artist

    extend Concerns::Findable

    attr_accessor :name, :songs
    
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

    def self.create(artist)
        new_artist = self.new(artist)
        new_artist.save
        new_artist
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
        elsif songs.include?(song) == false
           @songs << song
        end 
    end

    def genres
        genres = @songs.collect do |song|
            song.genre
        end
        genres.uniq
    end
end 
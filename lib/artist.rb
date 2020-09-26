require 'pry'

class Artist
    attr_accessor :name
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        @@all << self
    end

    def songs
        @songs
    end

    def songs=(songs)
        @songs = songs
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
        Artist.new(name)
    end

    def no_artist?(song)
        song.artist == nil
    end

    def add_song(song)
        if no_artist?(song)
            song.artist = self
            @songs << song
        end
    end

end
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

    def self.create(name_arg)
        new_artist = Artist.new(name_arg)
        new_artist.save
        new_artist
    end

    def songs
        @songs
    end

    def add_song(song_arg)
        if song_arg.artist == nil
            song_arg.artist = self
        end

        if songs.include?(song_arg) == false
            songs << song_arg
        end
    end

    def genres
        collection_genres = []
        songs.each do |item|
            collection_genres << item.genre
        end
        collection_genres.uniq
    end
    
end
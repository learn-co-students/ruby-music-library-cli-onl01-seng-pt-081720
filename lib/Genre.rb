require 'pry'

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

    def self.create(genre)
        new_genre = self.new(genre)
        new_genre.save
        new_genre
    end

    def songs
        @songs
    end

    def artists
        artists = @songs.collect do |song|
            song.artist 
        end
        artists.uniq
    end
end 
class Genre
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
        new_genre = Genre.new(name_arg)
        new_genre.save
        new_genre
    end

    def songs
        @songs
    end

    def artists
        collection_artists = []
        songs.each do |song|
            if song.genre == self
                collection_artists << song.artist
            end
        end
        collection_artists.uniq
    end
end
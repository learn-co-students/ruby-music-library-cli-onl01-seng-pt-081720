require 'pry'

class Song
    extend Concerns::Findable
    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name

        if artist != nil
            self.artist=artist
        end

        if genre != nil
            self.genre=genre
        end
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
        new_song = Song.new(name)
        new_song.save
        new_song
    end

    def artist=(artist_arg)
        @artist = artist_arg
        artist_arg.add_song(self)
    end

    def genre=(genre_arg)
        @genre = genre_arg
        if !genre_arg.songs.include?(self)
            genre_arg.songs << self
        end
    end

    def self.find_or_create_by_name(name)
        return_song = nil
        if find_by_name(name) != nil
            return_song = find_by_name(name)
        else
            return_song = create(name)
        end
        return_song
    end

    def self.new_from_filename(name_arg)

        # split
        array_parts = name_arg.split(" - ")

        # get the individual parts
        artist_part = array_parts[0]
        name_part = array_parts[1]
        genre_part = array_parts[2].gsub(".mp3", "")

        # create the parts
        new_artist = Artist.find_or_create_by_name(artist_part)
        new_genre = Genre.find_or_create_by_name(genre_part)

        # create the song with the parts
        new_song = Song.new(name_part, new_artist, new_genre)
        new_song
    end

    def self.create_from_filename(filename_arg)
        new_song = self.new_from_filename(filename_arg)
        new_song.save
    end

end
class Song
  attr_accessor :name, :artist, :genre
  @@all=[]
    def initialize(name, artist = nil, genre = nil)
      @name=name
      self.artist = artist if artist
      self.genre == genre if genre
    end

    def save
      @@all << self
    end

    def self.all
      @@all
    end

    def self.destroy_all
      @@all.clear
    end

    def self.create(name)
      a = self.new(name)
      a.save
      a
    end

    def self.find_by_name(name)
      self.all.detect {|s|
      s.name == name }
    end

    def self.find_or_create_by_name(name)
      self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(filename)

    end
    def self.create_from_filename(filename)

    end

    def artist=(artist)
      @artist=artist
      artist.add_song(self)
    end

    # def genre=(genre)
    #   @genre= genre
    #   genre.songs << self unless genre.songs.iclude?(self)
    # end

end

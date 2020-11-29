class Song
  
    attr_accessor :name, :artist, :genre
    @@all = []
    
    def initialize(name, artist = nil, genre = nil)
      @name = name
      self.artist=(artist) if artist != nil
      self.genre=(genre) if genre != nil
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
       song = self.new(name)
      song.save
      song
    end
    
    def artist
      @artist
    end
    
    def artist=(artist)
      @artist = artist
      artist.add_song(self)
    end
    
    def genre
      @genre
    end
    
    def genre=(genre)
      @genre = genre
      genre.songs << self unless genre.songs.include?(self)
    end
    
    def self.find_by_name(name)
      @@all.detect do |song| 
        song.name == name
      end
    end
    
    def self.find_or_create_by_name(name)
       if self.find_by_name(name)
        return self.find_by_name(name)
       else
         self.create(name)
       end
      end
      
      def self.new_from_filename(file)
        edited_files = file.split(" - ")
        song_name = edited_files[1]
        artist_name = edited_files[0]
        genre_name = edited_files[2].split(".mp3").join
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        self.new(song_name, artist, genre)
      end
      
      def self.create_from_filename(file)
        self.new_from_filename(file).save
      end
    
    
  end
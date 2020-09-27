class Song

  attr_accessor :name, :genre, :artist

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist != nil
      self.artist=(artist)
    end
    if genre != nil
      self.genre=(genre)
    end
  end

  def self.create(name, artist = nil, genre = nil)
    new_song = self.new(name,artist)
    new_song.save
    new_song
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

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    if !genre.songs.include?(self)
      genre.songs << self
    end
  end

  def self.find_by_name(name)
    self.all.find { |song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
       self.create(name)
     else
       self.find_by_name(name)
     end
  end

  def self.new_from_filename(filename)
    file = filename.split(" - ")
    file[2] = file[2].delete_suffix(".mp3")
    file_artist = Artist.find_or_create_by_name(file[0])
    file_genre = Genre.find_or_create_by_name(file[2])
    song = self.new(file[1], file_artist, file_genre)
    song.save
    song
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end

end

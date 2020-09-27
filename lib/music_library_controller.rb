class MusicLibraryController

  attr_accessor :path

  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    inp = gets.strip.downcase
    while inp != "exit"
      if inp == "list songs"
        self.list_songs
      elsif inp == "list artists"
        self.list_artists
      elsif inp == "list genres"
        self.list_genres
      elsif inp == "list artist"
        self.list_songs_by_artist
      elsif inp == "list genre"
        self.list_songs_by_genre
      elsif inp == "play song"
        self.play_song
      end
      inp = gets.strip.downcase
    end
  end

  def list_songs
    alphabetized_list = Song.all.sort_by{|s| s.name}
    alphabetized_list.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} \- #{song.name} \- #{song.genre.name}"
    end
  end

  def list_artists
    alphabetized_list = Artist.all.sort_by{|a| a.name}
    alphabetized_list.each_with_index do |artist, index|
      int = index + 1
      puts "#{int}. #{artist.name}"
    end
  end

  def list_genres
    alphabetized_list = Genre.all.sort_by{|g| g.name}
    alphabetized_list.each_with_index do |genre, index|
      int = index + 1
      puts "#{int}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    gets
    selected_artist = Artist.find_by_name(gets)
    if selected_artist != nil
      song_list = selected_artist.songs.sort_by{|s| s.name}
      song_list.each_with_index do |song, index|
        puts "#{index + 1}. #{song.name} \- #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    gets
    selected_genre = Genre.find_by_name(gets)
    if selected_genre != nil
      song_list = selected_genre.songs.sort_by{|g| g.name}
      song_list.each_with_index do |song, index|
        puts "#{index + 1}. #{song.artist.name} \- #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    gets
    inp = gets.to_i
    if inp > 0 && inp <= Song.all.length
      alphabetized_list = Song.all.sort_by{|s| s.name}
      puts "Playing #{alphabetized_list[inp - 1].name} by #{alphabetized_list[inp - 1].artist.name}"
    end
  end

end

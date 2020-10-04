class MusicLibraryController
  attr_accessor :path
  attr_reader :song, :artist, :genre
  def initialize(path = "./db/mp3s")
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "What would you like to do?"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
        input = gets.strip
      case input
      when "list songs"
        songs
      when "list artists"
        artists
      when "list genres"
        genres
      when "list artists"
        list_artist
      when "list genres"
        list_genres
      when "play song"
        play_song
      end
    end
  end

  def list_songs
    songs = Song.all
    alph_list = songs.sort_by!{ |song| song.name }
    alph_list.each_with_index { |song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }
  end

  def list_artists
    songs = Song.all
    alph_list = songs.sort_by!{ |artist| song.artist.name }
    alph_list.each_with_index { |song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }
  end
end

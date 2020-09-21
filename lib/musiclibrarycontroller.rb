class MusicLibraryController

  def initialize(path = "./db/mp3s")
    miobj = MusicImporter.new(path)
    miobj.import
  end

  def call
    input = nil
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp

      if input == "list songs"
        list_songs
      elsif input == "list artists"
        list_artists
      elsif input == "list genres"
        list_genres
      elsif input == "list artist"
        list_songs_by_artist
      elsif input == "list genre"
        list_songs_by_genre
      elsif input == "play song"
        play_song
      else
        "Try something else."
      end
    end
  end

  def list_songs
    sorted = Song.all.sort do |a, b|
      a.name <=> b.name
    end
    sorted.each_with_index do |song, i|
      puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sorted = Artist.all.sort do |a, b|
      a.name <=> b.name
    end
    sorted.each_with_index do |art, i|
      puts "#{i+1}. #{art.name}"
    end
  end

  def list_genres
    sorted = Genre.all.sort do |a, b|
      a.name <=> b.name
    end
    sorted.each_with_index do |gen, i|
      puts "#{i+1}. #{gen.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    if res = Artist.find_by_name(input)
      res.songs.sort {|a, b| a.name <=> b.name}.each_with_index {|s,i| puts "#{i+1}. #{s.name} - #{s.genre.name}" }
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    if res = Genre.find_by_name(input)
      res.songs.sort {|a, b| a.name <=> b.name}.each_with_index {|s,i| puts "#{i+1}. #{s.artist.name} - #{s.name}" }
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    if input > 0 && input <= Song.all.length
      list = Song.all.sort {|a, b| a.name <=> b.name}
      song = list[input-1]
      #binding.pry
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end

end

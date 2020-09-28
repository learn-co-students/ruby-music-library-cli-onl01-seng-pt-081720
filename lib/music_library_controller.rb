class MusicLibraryController
    attr_accessor :path
    
    def initialize(path = "./db/mp3s")
        @path = path
        MusicImporter.new(@path).import 
    end

    def call
        input = ""
        
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
            
            input = gets.strip
                
            case input
                when "list songs"
                    list_songs
                when "list artists"
                    list_artists
                when "list genres"
                    list_genres
                when "list artist"
                    list_songs_by_artist
                when "list genre"
                    list_songs_by_genre
                when "play song"
                    play_song
                when "exit"
                    input = "exit"
            end 
        end
    end

    #prints all songs in the music library in a numbered list (alphabetized by song name)
    #is not hard-coded
    def list_songs
        Song.all.sort{|a, b| a.name <=> b.name}.uniq.collect.with_index do |s, i|
            puts "#{i+1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
        end
    end

    #prints all artists in the music library in a numbered list (alphabetized by artist name)
    #is not hard-coded 
    def list_artists
        Artist.all.sort{|a, b| a.name <=> b.name}.uniq.collect.with_index do |s, i|
            puts "#{i+1}. #{s.name}"
        end
    end

    #prints all genres in the music library in a numbered list (alphabetized by genre name)
    #is not hard-coded
    def list_genres
        Genre.all.sort{|a, b| a.name <=> b.name}.uniq.collect.with_index do |s, i|
            puts "#{i+1}. #{s.name}"
        end
    end

    # prompts the user to enter an artist
    # accepts user input
    # prints all songs by a particular artist in a numbered list (alphabetized by song name)
    # does nothing if no matching artist is found
    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip

        if artist = Artist.find_by_name(input)
            artist.songs.sort{|a, b| a.name <=> b.name}.uniq.collect.with_index do |s, i|
                puts "#{i+1}. #{s.name} - #{s.genre.name}"
            end
        end
    end

    # prompts the user to enter a genre
    # accepts user input
    # prints all songs by a particular genre in a numbered list (alphabetized by song name)
    # does nothing if no matching genre is found
    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip

        if genre = Genre.find_by_name(input)
            genre.songs.sort{|a, b| a.name <=> b.name}.uniq.collect.with_index do |s, i|
                puts "#{i+1}. #{s.artist.name} - #{s.name}"
            end
        end
    end

    # prompts the user to choose a song from the alphabetized list output by #list_songs
    # accepts user input
    # upon receiving valid input 'plays' the matching song from the alphabetized list output by #list_songs
    # does not 'puts' anything out if a matching song is not found
    # checks that the user entered a number between 1 and the total number of songs in the library
    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i

        if (1..Song.all.length).include?(input)
            song = Song.all.sort{|a, b| a.name <=> b.name}.uniq[input-1]
            puts "Playing #{song.name} by #{song.artist.name}" if song
            #binding.pry
        end
    end
end
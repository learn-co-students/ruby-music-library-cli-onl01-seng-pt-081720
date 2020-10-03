class MusicLibraryController

    def initialize(path_arg = "./db/mp3s")
        music_importer = MusicImporter.new(path_arg)
        music_importer.import
    end

    def call
        user_input = ""

        while user_input != "exit"

            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            user_input = gets.chomp

            if user_input == "list songs" 
                list_songs
            elsif user_input == "list artists"
                list_artists 
            elsif user_input == "list genres"
                list_genres 
            elsif user_input == "list artist"
                list_songs_by_artist
            elsif user_input == "list genre"
                list_songs_by_genre
            elsif user_input == "play song"
                play_song
            end
        end
    end

    def list_songs
        alphabetized_list = Song.all.sort{ |x, y| x.name <=> y.name}
        alphabetized_list.each_with_index do |song, index|
            puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        alphabetized_list = Artist.all.sort{ |x, y| x.name <=> y.name}
        alphabetized_list.each_with_index do |artist, index|
            puts "#{index+1}. #{artist.name}"
        end
    end

    def list_genres
        alphabetized_list = Genre.all.sort{ |x, y| x.name <=> y.name}
        alphabetized_list.each_with_index do |genre, index|
            puts "#{index+1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_input = gets.chomp

        if Artist.find_by_name(user_input)
            artist_input = Artist.find_by_name(user_input)

            array_songs = []
            Song.all.each do |item|
                if item.artist == artist_input
                    array_songs << item
                end
            end

            array_songs_sorted = array_songs.sort{ |x, y| x.name <=> y.name}
            array_songs_sorted.each_with_index do |song, index|
                puts "#{index+1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input = gets.chomp

        if Genre.find_by_name(user_input)
            genre_input = Genre.find_by_name(user_input)
            
            array_genre = []
            Song.all.each do |song|
                if song.genre == genre_input 
                    array_genre << song
                end
            end

            array_genre_sorted = array_genre.sort{ |x, y| x.name <=> y.name}
            array_genre_sorted.each_with_index do |song, index|
                puts "#{index+1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        user_input = gets.chomp.to_i

        sorted_songs = Song.all.each.sort{|x, y| x.name <=> y.name}

        sorted_songs.each_with_index do |song, index|
            if index+1 == user_input
                puts "Playing #{song.name} by #{song.artist.name}"
            end
        end
    end
end
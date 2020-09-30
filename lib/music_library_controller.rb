class MusicLibraryController
    require 'pry'

    def initialize (path = "./db/mp3s")
        importer = MusicImporter.new(path)
        importer.import
    end

    def list_songs
        songs = Song.all.sort_by { |song| song.name }
        songs.each_with_index{ |item, index|
            puts (index+1).to_s + ". " + item.artist.name + " - " + item.name + " - " + item.genre.name
        }
    end

    def list_artists
        artists = Artist.all.sort_by {|artist| artist.name}
        artists.each_with_index{ |item, index|
        puts (index+1).to_s + ". " + item.name
        }
    end

    def list_genres
        genres = Genre.all.sort_by {|genre| genre.name}
        genres.each_with_index{ |item, index|
        puts (index+1).to_s + ". " + item.name
        }
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        Artist.all.each{ |a|
            if(a.name == input)
                songs = a.songs.sort_by {|song| song.name}
                counter = 1 
                songs.each_with_index{ |item, index|
                    if item.artist.name == input
                        puts (counter).to_s + ". " + item.name + " - " + item.genre.name
                        counter += 1
                    end
                }
            end
        }
    
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        Genre.all.each{ |a|
            if(a.name == input)
                songs = a.songs.sort_by {|song| song.name}
                songs.each_with_index{ |item, index|
                    if item.genre.name == input
                        puts (index+1).to_s + ". " + item.artist.name + " - " + item.name
                    end
                }
            end
        }
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip
        index = input.to_i
        if(index >0)
            index -= 1
            songs = Song.all.sort_by { |song| song.name }
            songs.each_with_index { |item, i|
                if(i == index)
                    puts "Playing " + item.name + " by " + item.artist.name
                end
            }
        end
    end

    def call
        input=""
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
                    self.list_songs
                when "list artists"
                    self.list_artists
                when "list genres"
                    self.list_genres
                when "list artist"
                    self.list_songs_by_artist
                when "list genre"
                    self.list_songs_by_genre
                when "play song"
                    play_song
                end
            end
    end
end
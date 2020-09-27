
class MusicLibraryController

    def initialize(path = './db/mp3s')
        @path = path
        music = MusicImporter.new(@path)
        music.import
    end

    def call
        input = String.new
        while input != "exit"
            puts ("Welcome to your music library!")
            puts ("To list all of your songs, enter 'list songs'.")
            puts ("To list all of the artists in your library, enter 'list artists'.")
            puts ("To list all of the genres in your library, enter 'list genres'.")
            puts ("To list all of the songs by a particular artist, enter 'list artist'.")
            puts ("To list all of the songs of a particular genre, enter 'list genre'.")
            puts ("To play a song, enter 'play song'.")
            puts ("To quit, type 'exit'.")
            puts ("What would you like to do?")

            input = gets.chomp
        end
    end

    def list_songs
    
        # Song.all.sort{|a, b| a.name <=> b.name}.each.with_index(1) do |song, i| 
        #     puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        # end

        Song.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
            puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
          end
    

    end
end
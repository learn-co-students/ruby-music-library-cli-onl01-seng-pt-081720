
class MusicLibraryController

    def initialize(path = './db/mp3s')
        @path = path
        music = MusicImporter.new(@path)
        music.import
    end

    def call
        puts "Welcome to your music library!"
    end
end
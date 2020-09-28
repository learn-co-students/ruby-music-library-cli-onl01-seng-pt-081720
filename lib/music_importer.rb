class MusicImporter
    attr_accessor :path
    
    def initialize(path)
        @path = path
    end

    def files
        @files = Dir.children(@path) #.children gets filenames as an array except for "." and ".."
    end

    #uses the method above and iterates over it to create a new Song instance for each filename
    def import
        files.collect {|filename| Song.create_from_filename(filename)}
    end
end
require 'pry'

class MusicImporter
    attr_accessor :path, :files

    def initialize(path_arg)
        @path = path_arg
    end

    def files
        files_to_return = []
        Dir.entries(@path).each do |entry|
            if entry.include?(".mp3") 
                files_to_return << entry
            end
        end
        files_to_return
    end

    def import
        files.each do |file|
            Song.create_from_filename(file)
        end
    end


end
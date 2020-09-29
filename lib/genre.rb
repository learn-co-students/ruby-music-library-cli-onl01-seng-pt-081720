class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all=[]
    def initialize(name)
      @name=name
      @songs = []
      save
    end

    def save
      @@all<<self
    end

    def self.all
      @@all
    end

    def self.destroy_all
      @@all.clear
    end

    def self.create(name)
      b = self.new(name)
      b.save
      b
    end

    def artists
      self.songs.collect {|a|
      a.artist}.uniq
    end

    def songs
      @songs
    end


    #
    # def name
    #   self.name
    # end
end

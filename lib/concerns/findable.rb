module Concerns::Findable
  
    def find_by_name(name)
      self.all.detect do |song| 
        song.name == name
      end
    end
    
    def create(name)
       song = self.new(name)
      song.save
      song
    end
    
    def find_by_name(name)
      self.all.detect do |song| 
        song.name == name
      end
    end
    
    def find_or_create_by_name(name)
       if find_by_name(name)
        return find_by_name(name)
       else
         create(name)
       end
      end
    
    
  end
  
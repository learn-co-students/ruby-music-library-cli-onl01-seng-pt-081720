module Concerns::Findable

  def find_by_name(name)
    self.all.detect {|a| a.name == name}
  end

  def find_or_create_by_name(name)
    song = find_by_name(name)
      if song
        song
    else
        self.create(name)
      end
    end
end

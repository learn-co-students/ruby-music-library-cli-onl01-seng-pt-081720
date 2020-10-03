module Concerns::Findable

    def find_by_name(name_arg)
        return_item = nil
        self.all.each do |item|
            if item.name == name_arg
                return_item = item
            end
        end
        return_item
    end

    def find_or_create_by_name(name_arg)
        return_item = nil
        if self.find_by_name(name_arg) == nil
            return_item = self.create(name_arg)
        else
            return_item = self.find_by_name(name_arg)
        end
        return_item
    end
end
require "pry"
require 'bundler'
Bundler.require

module Concerns:Findable
    def find_by_name(name)
      self.all.detect do |a|
        return a
      end
    end

end

require_all 'lib'

require "pry"
require 'bundler'
Bundler.require

module Concerns

  module Findable

    def find_by_name(name)
      self.all.detect do |a|
        return a
      end
    end

  end

end

require_all 'lib'

#
#  This Return Store uses RudeQ a databased queue system
#   http://github.com/matthewrudy/rudeq
#
module Workling
  module Return
    module Store
      class RudeQReturnStore < Base

        def self.load_rude_q_installed?
          Object.const_defined? "RudeQueue"
        end

        def self.load_rude_q
          begin
            gem 'rudeq'
            require 'rudeq'
          rescue Gem::LoadError
            Workling::Base.logger.info "WORKLING: couldn't find rudeq library. Install: \"gem install matthewrudy-rudeq\". "
          end
        end

        def initialize
          self.class.load_rude_q unless self.class.load_rude_q_installed?
        end

        # set a value in the queue 'key'.
        def set(key, value)
          RudeQueue.set(key, value)
        end

        # get a value from starling queue 'key'.
        def get(key)
          RudeQueue.get(key)
        end

      end
    end
  end
end
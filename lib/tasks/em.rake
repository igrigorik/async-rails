module Rake
  class Application
    alias_method :top_level_alias, :top_level
    def top_level
      EM.synchrony do
        top_level_alias
        EM.stop
      end
    end
  end
end

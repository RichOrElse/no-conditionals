require "no_conditionals/version"

# Refines truthy and falsey types
module NoConditionals

  # Mixin for truthy behavior
  module Truthiness

    # evaluates a block, passes object
    def hence
      yield self
    end

    # just returns object, ignores block
    def otherwise
      self
    end

    # just returns first parameter (so), ignores optional second parameter (maybe)
    def maybe so, maybe: nil
      so
    end

    # calls first parameter (so)
    def maybe! so, maybe: nil
      so.call
    end
  end

  # Mixin for falsey behavior
  module Falseyness

    # just returns object, ignores block
    def hence
      self
    end

    # evaluates a block
    def otherwise
      yield self
    end

    # ignores first parameter (so), returns either object or keyword argument (maybe)
    def maybe _, maybe: self
      maybe
    end

    # calls keyword argument (maybe) or returns object
    def maybe! _, maybe: -> { self }
      maybe.call
    end
  end

  refine Object do
    include Truthiness
  end

  refine NilClass do
    include Falseyness
  end

  refine FalseClass do
    include Falseyness
  end
end

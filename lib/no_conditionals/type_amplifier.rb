module NoConditionals
  class TypeAmplifier < Module
    def initialize(*types)
      amplifying *types
    end

    def amplifying(*types)
      types.each {|type| amplify type }
    end

    def amplify(type)
      warn "'#{self.class}#amplify': callback is missing. Please define 'amplify' method in '#{self.class}' class.\n"
    end

    protected :amplifying, :amplify

    class << self
      NONCLASS_TYPE = -> a { !a.kind_of? Class }

      def new(*args)
        wrong = args.detect(&NONCLASS_TYPE) and fail TypeError,"wrong argument type #{wrong.class} (expected Class)"
        super
      end

      alias_method :[], :new
    end # class methods

    class Wrapper
      def initialize object
        @value = object
      end

      def value
        @value
      end

      protected :value

      class << self
        alias_method :wrap, :new
      end
    end
  end
end
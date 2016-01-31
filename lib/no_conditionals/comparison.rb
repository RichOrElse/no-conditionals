module NoConditionals

  # Mixin for Comparable types
  module Comparison

    # returns criterion (Proc) for greater amount (Comparable)
    def above
      -> other { self < other }
    end

    # returns criterion (Proc) for lesser amount (Comparable)
    def below
      -> other { self > other }
    end

    # returns criterion (Proc) for same or greater amount (Comparable)
    def or_above
      -> other { self <= other }
    end

    # returns criterion (Proc) for same or lesser amount (Comparable)
    def or_below
      -> other { self >= other }
    end

    # Mixin for Time
    module Chronological
      include Comparison

      # returns criterion (Proc) for greater amount (of Time)
      alias_method :later, :above

      # returns criterion (Proc) for lesser amount (of Time)
      alias_method :earlier, :below

      # returns criterion (Proc) for same or greater amount (of Time)
      alias_method :or_later, :or_above

      # returns criterion (Proc) for same or lesser amount (of Time)
      alias_method :or_earlier, :or_below
    end
  end

  module Critieria
    def >>(other)
      is_one = to_proc
      is_another = other.to_proc
      -> alike { is_one[alike] && is_another[alike] }
    end

    def to_proc
      method(:===).to_proc
    end

    module HaveAlike
      def procs
        collect(&:to_proc)
      end

      def have?(alike)
        procs.any? { |is| is[alike] }
      end

      def to_proc
        method(:have?).to_proc
      end
    end

    module HaveKeysAlike
      def procs
        collect do |key, criterion|
          has = criterion.to_proc
          a = key.to_sym.to_proc
          -> like { has[a[like]] }
        end
      end

      def to_proc
        procs.inject(:>>)
      end
    end
  end

  refine Object do
    include Criteria

    def Below amount
      amount.below
    end

    def Above amount
      amount.above
    end

    private :below, :above
  end


  refine Symbol do
    include Comparison
  end

  refine String do
    include Comparison
  end

  refine Numeric do
    include Comparison
  end

  refine Time do
    include Comparison::Chronological
  end
end

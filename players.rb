class Players
    attr_reader :name, :score
    def initialize(name:, score:)
        @name = name
        @score = score
    end
    def to_json(_arg)
        {name: @name, score: @score}.to_json
    end
end

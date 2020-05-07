require_relative "./../../services/marvel_combat/word.rb"

module MarvelCombat
  class DetermineWinner
    def initialize(opts)
      @character1 = opts[:character1]
      @character2 = opts[:character2]
      @seed = opts[:seed]
    end

    def perform
      @character1[:word] = MarvelCombat::Word.pick({ description: @character1[:description], position: @seed }).downcase
      @character2[:word] = MarvelCombat::Word.pick({ description: @character2[:description], position: @seed }).downcase

      @character1[:points] = MarvelCombat::Word.calc_points({ word: @character1[:word], description: @character1[:description].downcase })
      @character2[:points] = MarvelCombat::Word.calc_points({ word: @character2[:word], description: @character2[:description].downcase })

      case
      when @character1[:points] > @character2[:points]
        @character1
      when @character1[:points] < @character2[:points]
        @character2
      else 
        settle_tie
      end
    end

    private

    def settle_tie
      rand(1..10).odd? ? @character1 : @character2
    end
  end
end
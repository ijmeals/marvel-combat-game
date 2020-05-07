require_relative "./../terminal_utils/question.rb"

module MarvelCombat
  class SeedNumber
    def self.terminal_prompt
      seed = nil

      loop do
        seed = TerminalUtils::Question.ask("Please enter a SEED number between 1 - 9: ").to_i

        break if self.valid_seed_number?(seed)
        puts "You entered an invalid SEED number."
      end

      seed
    end

    def self.valid_seed_number?(seed)
      seed.between?(1,9)
    end
  end
end
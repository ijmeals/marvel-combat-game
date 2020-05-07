require_relative "./../../models/marvel_combat/character.rb"
require_relative "./../../services/terminal_utils/question.rb"

module MarvelCombat
  class PickCharacter
    @@instance_count = 0

    def initialize
      @@instance_count += 1
    end

    def perform
      character = nil

      loop do
        name = prompt_for_character_name
        character = MarvelCombat::Character.find(name).first

        break unless character.nil?
        puts "Could not find the character. Please try again."
      end

      character
    end

    private

    def prompt_for_character_name
      verbiage = @@instance_count.odd? ? "first" : "second"
      name = nil

      loop do
        name = TerminalUtils::Question.ask("Please enter the #{verbiage} character's name (e.g. spider-man): ")

        break unless name.strip.empty?
        puts "A name must be greater than one character. Please try again."
      end

      name
    end
  end
end
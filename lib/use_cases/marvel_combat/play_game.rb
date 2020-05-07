require_relative "./../../services/marvel_combat/seed_number.rb"
require_relative "./../../services/terminal_utils/question.rb"
require_relative "./determine_winner.rb"
require_relative "./pick_character.rb"
 
module MarvelCombat
  class PlayGame
    def perform
      welcome_message

      loop do
        seed = MarvelCombat::SeedNumber.terminal_prompt()
        character1 = MarvelCombat::PickCharacter.new.perform()
        character2 = MarvelCombat::PickCharacter.new.perform()
        winner = MarvelCombat::DetermineWinner.new({
          character1: character1,
          character2: character2,
          seed: seed
        }).perform()

        announce_winner(winner)
  
        break unless play_again?
      end

      goodbye_message
    end

    private

    def welcome_message
      puts "\n"
      puts "WELCOME TO THE MARVEL COMBAT ARENA"
      puts "----------------------------------"
      puts "\n"
    end

    def announce_winner(winner)
      puts "AND THE WINNNER IS... #{winner[:name]}"
    end

    def play_again?
      TerminalUtils::Question.ask("ENTER 'y' TO PLAY AGAIN OR ANYTHING ELSE TO EXIT.").include? "y"  
    end

    def goodbye_message
      puts "THANK YOU FOR PLAYING MARVEL COMBAT ARENA"
      puts "\n"
    end
  end
end
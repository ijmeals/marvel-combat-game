module TerminalUtils
  class Question
    def self.ask(q)
      puts q
      answer = gets.chomp
      puts "\n"
      answer
    end
  end
end
require "bundler/setup"
require_relative "lib/use_cases/marvel_combat/play_game.rb"

begin
  MarvelCombat::PlayGame.new().perform();
rescue Exceptions::MarvelApi => e
  puts e.message
  puts "Params used to make the API call #{e.api_params}" unless e.api_params.nil? 
  puts "\nUnfortunately that is too fatal, and so the game must exit."
rescue => e
  puts e.message
  puts "\nUnfortunately is too fatal, and so the game must exit."
end
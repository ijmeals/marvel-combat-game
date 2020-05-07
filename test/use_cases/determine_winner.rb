require "minitest/autorun"
require_relative "./../../lib/use_cases/marvel_combat/determine_winner.rb"

class TestDetermineWinner < Minitest::Test
  def test_winner_when_neither_have_a_magic_word
    winner = MarvelCombat::DetermineWinner.new({
      character1: {
        name: "spider-man",
        description: "spider man will be the winner",
      },
      character2: {
        name: "A.I.M.",
        description: "you, will-not be the winner here",
      },
      seed: 1
    }).perform()

    assert_equal(winner[:name], "spider-man")
  end

  def test_winner_when_one_has_gamma_magic_word
    winner = MarvelCombat::DetermineWinner.new({
      character1: {
        name: "spider-man",
        description: "spider man will be the winner",
      },
      character2: {
        name: "A.I.M.",
        description: "you, will not be the winner here - Gamma",
      },
      seed: 1
    }).perform()

    assert_equal(winner[:name], "A.I.M.")
  end

  def test_winner_when_one_has_radioactive_magic_word
    winner = MarvelCombat::DetermineWinner.new({
      character1: {
        name: "spider-man",
        description: "spider man will be the winner - radioactive",
      },
      character2: {
        name: "A.I.M.",
        description: "you, will not be the winner here",
      },
      seed: 1
    }).perform()

    assert_equal(winner[:name], "spider-man")
  end

  def test_winner_when_one_has_radioactive_magic_word_and_the_other_gamma
    winner = MarvelCombat::DetermineWinner.new({
      character1: {
        name: "spider-man",
        description: "spider man will be the winner - radioactive",
      },
      character2: {
        name: "A.I.M.",
        description: "you, will not be the winner here - gamma",
      },
      seed: 1
    }).perform()

    assert_equal(winner[:name], "spider-man")
  end
end
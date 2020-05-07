require "minitest/autorun"
require_relative "./../../lib/services/marvel_combat/word.rb"

class TestDetermineWinner < Minitest::Test
  def test_that_second_word_is_returned
    word = MarvelCombat::Word.pick({ description: "description of character", position: 2 })

    assert_equal(word, "of")
  end

  def test_that_trailing_white_space_is_ignored
    word = MarvelCombat::Word.pick({ description: " description of character", position: 2 })

    assert_equal(word, "of")
  end

  def test_that_if_seed_is_larger_then_number_of_words_return_empty_string
    word = MarvelCombat::Word.pick({ description: "test", position: 4 })

    assert_equal(word, "")
  end
end
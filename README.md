# Marvel Combat Game

This game is using the Marvel API. If you do not already have a developer account, [click here](https://developer.marvel.com/) to register an account as you will need to provide your own API Public and Private Key.

## How to Run the Code

The general steps needed to play this awesome game in your terminal is setting two environment variables, installing the gems and then running a ruby file.

Below are the commands to run from the root directory _if on a MacOS_

```terminal
export MARVEL_API_PUBLIC_KEY=26f2bb3424615333e340cbce942470d
export MARVEL_API_PRIVATE_KEY=90e503423b4d132d732a5779cc199e7bfd897ea
bundle install
ruby marvel_combat_arena.rb
```

> Be sure to replace the fictitious Public Key and Private Key with your own.

### Some Marvel Characters

Providing this in case an end user does not know any characters off the top of their head and wants to play.

- A-Bomb (HAS)
- Spider-Man
- A.I.M.
- Aaron Stack

## Assumptions / Business Logic Decisions I Made

The longest word in the English language, according to a Google search, is "pneumonoultramicroscopicsilicovolcanoconiosis" which is 45 characters.
Therefore, if the WORD is a magic word, I bump the point count by 1000 + the length of the magic word to ensure it being greater than a WORD which is not a MAGIC WORD.

In the scenario where a character may have both magic words, I am only counting the largest MAGIC word. So if character 1 has "gamma", and the second character has "gamma and radioactive", character 2 would win because of having "radioactive" and not because of "gamma".

I also decided to make it case insensitive, so "Gamma" in the description is the same as "gammma".

Here are the conclusions from the questions I posed in the email on Monday which were left to me to decided:

1. In the user select the same character twice for a match (e.g. spider man vs spider man)? **I decided that would be fine**

2. What should happen if the two characters have the same WORD? Would that result in a tie? **If two characters end up with the same point count due to the WORD being the same length, I pick a random number and based on that, it picks a winner.**

3. What should happen if one character has the MAGIC WORD "Gamma" and the other has "Radioactive"? Would the winner then be determined by whosever MAGIC WORD is the longest? **The longest MAGIC WORD will determine the winner**

4. What should happen if one character does not have a description (e.g. Spider-dok) or it does not have a WORD at the SEED position? Should I treat the WORD length as 0 for that character? **This falls into the tie scenario (#3)**

5. Does the user need to enter the character name exactly (e.g. spider-man) or should it allow for partial names (e.g. spider) and then let the user pick from a list of possible names? **The name must be exactly as it is returned from the API but is not case sensitive so spider-man === SpIder-MaN**

## Some of My Design / Coding Style Considerations

Back in the day, I came across this article, [A Case for Use Cases](https://webuild.envato.com/blog/a-case-for-use-cases/). I have found the pattern helpful as a way to show the steps needed to complete a task, and highlighting the core functionality.

When it came to dealing with API keys, I thought about using a YAML file and putting it inside a "config" folder, as well as considered a .env file. I decided with setting environment variables before you run the ruby script, as shown above, because I figured most users of my game will run it once, so storing those keys in a some sort of file I felt would hurt the UX. Why edit a file if you don't have to?

Another thing is when it comes to passing parameters into a method, I more often than not, pass a hash object. I prefer this because if I need to modify the arguments, maybe adding a few additional ones which are optional, it's an easier change to implement. I also find it helpful when looking at a method call as it offers an opportunity to provide a little more clarity. For instance, naming is absolutely one of the hardest parts of writing code, by passing a hash, you give yourself a second opportunity to provide clarity to another developer who didn't write the code. The last reason behind this style is it makes it so the order in which params are passed in irrelevant.

When it came to third party gems, I wanted to avoid as many as possible and do it natively (as long as it made sense). Including any third party code is a serious thing, as it can expose you to risk (because it's not your source code) if you don't keep up with the latest updates as well as what the code is actually doing, and so as a developer, my first instinct is how can I do what I need without installing something else. Therefore I used only two gems: httparty, and minitest.

## Test

To run the test, run the follow commands from the root directory:

```terminal
bundle install
ruby test/all.rb
```

## Things I would have liked to included

- Some sort of linting like Rubocop (used that back in the day, not sure if there is a better one nowadays)
- Tests (more test)
- Instead of having to run `ruby test/all.rb` in in the terminal, using Rake.

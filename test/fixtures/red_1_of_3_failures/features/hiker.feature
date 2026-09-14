Feature: hitch-hiker playing scrabble

Scenario: earthling playing scrabble in the past
  Given the hitch-hiker selects some tiles
  When they spell 6 times 7
  Then the score is 42

Scenario: the score is two digits long
  Given the hitch-hiker selects some tiles
  When they spell 6 times 7
  Then the score has 3 digits

Scenario: the score is an even number
  Given the hitch-hiker selects some tiles
  When they spell 6 times 7
  Then the score is even

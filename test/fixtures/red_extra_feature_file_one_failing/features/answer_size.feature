Feature: the size of the answer

Scenario: the score is three digits long
  Given the hitch-hiker selects some tiles
  When they spell 6 times 7
  Then the score has 3 digits


# Making a Game, Project in Progress

### How the Game Works

Move yourself('o') to the stairs('S','D') with WASD keys, avoid the monsters('X'). Doors('|') need keys('k') to be opened.
Try to find the treasure('t'). good luck :)
Exit the game with 'p'

### To Play

```shell
ruby ./lib/play.rb
```

or

```shell
irb -r ./lib/game.rb
\> game = Game.new(Interface.new)
\> game.setup
\> game.main_loop
```


### Example Screenshot of the Game

![alt text](https://github.com/RaeRachael/exploration_game/blob/master/expample_screenshot_14_06.png)

## Comments About the Code Plan, Struggles and Aims

### Saturday 11th July

#### Coding Aims Completed
* Added SimpleCov to check test coverage
* Added tests to get coverage to 100%

### Sunday 14th June

#### Coding Aims Completed
* fixed personal rubocop
* Impoved code base via rubocop suggestions

#### Why Change Rubocop
So I felt that the 300+ offences that the default rubocop from makers were not all justified, and didn't fit my view of what bad ruby code looked like. In addition I didn't what the default spec_helper file to be included in the rubocop checks.
The particular rubocop checks that i didn't like can be seen in the .rubocop.yml file (I guess the most noticable is allowing `"strings without special characters, to use ""`). The issuse I was having in setting up my personalised rubocop was that I had named the file 'rubocop.yml' instead of '.rubocop.yml', taking extra care in file names is something that I am to focus on a little bit more in the future.

Additional benifits to having a personalised rubocop means that suggestions like using safe navigation (`&.`) can now be seen and utilised in the code, making it more readable and neater for other people to read. There are still a few offences, mostly due to a few methods being too long and complex, some of which may not be easy to fix (and fix might lead to messier code) but now I will aim to look at this methods and see if they can be simplified, if not at least now I know how to exclude them from rubocop checks.

#### Future Aims
As I have been learning javascript recently, there is now the possiblity to rewrite this game in javascript to make in avaliable on the web instead of being stuck in the terminal. This means that new development here will likely be paused until a javascript version is at the same or similar point. Then new features could be added to both versions at the same time, helping to develop insights into the differences and similarities of these languages and improve my understanding in both.

### Staurday 30th May

#### Coding Aims Completed
* Feature test scenarios
* Printing out only the local environment of the level

#### How the Game Looked Before
![alt text](https://github.com/RaeRachael/exploration_game/blob/master/sample_screenshot.png)

##### Feature Test Scenarios, Replacing Class Variables with Instance Variables
Creating the individual feature test was fine, get them to pass when run together caused a slight problem, as the game code used class varibales in the Interface Class. So the level scenario data from the first feature test was being used in all of them. Luckily changing the code so that only one Interface instance is used by all other objects (acheived via dependacy injection) meant that I could replace all class variables with instance variables. The dependacy injection also allowed me to tidy up the unit spec tests for the tile and moveable class objects. Also by only having one instance of the Interface class the code should take up less space when being run (which is good for being able to have larger levels in the future)

##### Printing Out the Local Environment
Finally for the first time in this project, since the #user_move method was created, there has been TDD being used. Thinking of the best way to go about testing this took quite a bit of time, but I eventually thought that testing the standard output against a regex would be the best way. This was mostly because I knew that the '.' symbol is treated as any character and that you can specify how many you would like in a row, (to get the correct syntax required a quick google) but making the test didn't take much time after the idea for it arrived. <br/>
Passing the test was interesting as the case when the player was by the edge of the specified level map lead to the program looking to interact with indexes outside of the Array range, to deal with this I added a buffer of empty tiles around the level maps when the level data is being made into a 3D array of Tiles. Also there is now a @sight instance variable for the player that determines how far the player can see.

#### Aims for the Next Steps
 * I think that at some point there be a menu for the user with save, load options as well at to play. (In the Game Class)
 * I think trying to implement different monster types, and possibly a way to fight back would be interesting.
 * Utilising the @sight instance variable such that the distance a player can see is variable - possible difficulty setting?, possible torch tiles that temporarily increase the line of sight?
 * Having a menu for the user when the game is started or paused (using the 'p' input that currently exits the game)


### Friday 22nd May

#### Coding Aims Completed
Managed to get RSpec tests for Tile types and Moveable types working, aren't using doubles at the moment (this could be down via dependancy injection in the future).
Also started to create feature tests for certain interactions, like the output of the game when the player and a monster share the same space. As this a test on the exit of the game, I had to set appropriate exit codes for each different exit out the game. (0 - user_move=p, 1 - monster-player, 2 - treasure-monster). In addition I had to create specific scenarios for each test, so had to make a way to start the game after laying out the scenario in the test, this lead to the creation of the play.rb file which makes playing the game from the command line possible.

#### Struggles
Because some of the tests cared about the message associated with certain exception states (SystemExit). I had the idea that it might be useful to create a custom exception class to handle the situation of the player moving up or down levels. This required quite a bit of working out how to give a custom exception class a message and to access it, and being able to handle that in both RSpec syntax and it rescue of the exception in the main code took quite awhile.

#### Aims for the Next Step

 * I think that at some point there be a menu for the user with save, load options as well at to play. (In the Game Class)
 * I think trying to implement different monster types, and possibly a way to fight back would be interesting.
 * Also printing out only the local environment of the level would lead to greater possibilities of the level design in terms of size.
 * Having a menu for the user when the game is started or paused (using the 'p' input that currently exits the game)
 * Create more feature test scenarios


### Friday 15th May

#### Struggles in Achieving Aims from Last Update (13th May)
So the code had gotten a little complicated, such that it was hard to collect all the methods using the same global variable into one file. But by writing out what information each of the main methods needed in each of the files I had, it quickly became clear that the level of interaction between them could be the source of a new class that holds methods that deal with the interactions, I named the class Interface and used class variables to hold the instances of the Tile and Moveable classes that the Interface works with.

#### A Visual Representation of the Current Code State.

![alt text](https://github.com/RaeRachael/exploration_game/blob/master/explore_game_15_may.png)

#### Aims for the Next Step

 * I think that at some point there be a menu for the user with save, load options as well at to play. (In the Game Class)
 * I think trying to implement different monster types, and possibly a way to fight back would be interesting.
 * Also printing out only the local environment of the level would lead to greater possibilities of the level design in terms of size.
 * Having a menu for the user when the game is started or paused (using the 'p' input that currently exits the game)
 * Bring back a testing system for current methods, and use it for future features


### Wednesday 13th May

[A blog post about my thought in relation to this project (11th May)](https://medium.com/@rachaelewins/functionality-in-toy-land-1e5700dca524)

#### What the Plan for the Project was Before Starting
Unfortunately I didn't make too much of a plan for the project before stating to write code for it. So there is a bit of work to make it have a more sensible layout behind the scenes.
However I was quite clear that I wanted to have something that took user input to move a character while other objects where also able to move.
So it made sense to have a process to take some data from the stdin to enable the movement of the player character.
Also there would need to be a timer aspect used to control when the non-player objects in the game would move (if they could).
There was also the intention to do this via a TDD process.

#### Struggles in the Coding Process

##### #read_move
As I wanted a real-time game it quickly became clear to me that that using #gets would not do and that finding a method to return a variable on each key press would be needed. So after a quick search I found the method #getch, which would also need 'io/console' to run, so I set up the first iteration of the method which would become #read_move.
As I was still attempting to follow the TDD process at this time, there was quite a bit of time spent trying to work out how to get the test to properly mock the user input and to pass that test, [record of what the test was](https://github.com/RaeRachael/exploration_game/commit/f2b972e35dee1f88f35197262eea7cf265b654af). Thankfully I did eventually find that $stdin and STDIN are different things.

An additional problem that I had with coding #read_move was that I did want the game to wait indefinitely for the user to input something, to work around this I found that Timeout could solve the issue, as if i run the #getch inside a Timeout block it will escape out of after a set time, so that the rest of the code can run (and in this case allows the monsters to move around the level).

A slight aside about the #getch method is that it makes abouting the process being run by ^c impossible, so I had to include a quit input earlier than expect, so #read_move can return values related to moving the player character and also to quite the game.

#### Aims for the Next Step

 * I would like to remove or at least reduce the reliance on the global variables that i current have.
 * I think that at some point there be a menu for the user with save, load options as well at to play.
 * I think trying to implement different monster types, and possibly a way to fight back would be interesting.
 * Also printing out only the local environment of the level would lead to greater possibilities of the level design in terms of size.

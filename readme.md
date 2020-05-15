## Attempt to make a basic exploration of a map game

# how the game works

move yourself('o') to the stairs('S','D') with wasd keys, avoid the monsters('X'). Doors('|') need keys('k') to be opened.
try to find the treasure('t'). good luck :)

exit the game with 'p

to play

```shell
ruby ./lib/game
```

Example screenshot of the game...
![alt text](https://github.com/RaeRachael/exploration_game/blob/master/sample_screenshot.png)

# comments about code plan, struggles and aims

## Friday 15th May

### struggles in achieving aims from last update (13th May)
So the code had gotten a little complicated, such that it was hard to collect all the methods using the same global variable into one file. But by writing out what information each of the main methods needed in each of the files I had, it quickly became clear that the level of interaction between them could be the source of a new class that holds methods that deal with the interactions, I named the class Interface and used class variables to hold the instances of the Tile and Moveable classes that the Interface works with...
A visual representation of the current code state.
![alt text](https://github.com/RaeRachael/exploration_game/blob/master/explore_game_15_may.png)

### aims for the next step

 * I think that at some point there be a menu for the user with save, load options as well at to play. (In the Game Class)
 * I think trying to implement different monster types, and possibly a way to fight back would be interesting.
 * Also printing out only the local environment of the level would lead to greater possibilities of the level design in terms of size.
 * Having a menu for the user when the game is started or paused (using the 'p' input that currently exits the game)


## Wednesday 13th May

[A blog post about my thought in relation to this project (11th May)](https://medium.com/@rachaelewins/functionality-in-toy-land-1e5700dca524)

### what the plan for the project was before starting
Unfortunately I didn't make too much of a plan for the project before stating to write code for it. So there is a bit of work to make it have a more sensible layout behind the scenes...
However I was quite clear that I wanted to have something that took user input to move a character while other objects where also able to move...
So it made sense to have a process to take some data from the stdin to enable the movement of the player character.
Also there would need to be a timer aspect used to control when the non-player objects in the game would move (if they could)....
There was also the intention to do this via a TDD process.

### struggles in the coding process

#### #read_move
As I wanted a real-time game it quickly became clear to me that that using #gets would not do and that finding a method to return a variable on each key press would be needed. So after a quick search I found the method #getch, which would also need 'io/console' to run, so I set up the first iteration of the method which would become #read_move....
As I was still attempting to follow the TDD process at this time, there was quite a bit of time spent trying to work out how to get the test to properly mock the user input and to pass that test, [record of what the test was](https://github.com/RaeRachael/exploration_game/commit/f2b972e35dee1f88f35197262eea7cf265b654af). Thankfully I did eventually find that $stdin and STDIN are different things.

An additional problem that I had with coding #read_move was that I did want the game to wait indefinitely for the user to input something, to work around this I found that Timeout could solve the issue, as if i run the #getch inside a Timeout block it will escape out of after a set time, so that the rest of the code can run (and in this case allows the monsters to move around the level).

A slight aside about the #getch method is that it makes abouting the process being run by ^c impossible, so I had to include a quit input earlier than expect, so #read_move can return values related to moving the player character and also to quite the game.

### aims for the next step

 * I would like to remove or at least reduce the reliance on the global variables that i current have.
 * I think that at some point there be a menu for the user with save, load options as well at to play.
 * I think trying to implement different monster types, and possibly a way to fight back would be interesting.
 * Also printing out only the local environment of the level would lead to greater possibilities of the level design in terms of size.

# FederalVulture

Thomas Lin, Taylor Wong, Edward Luo

<h2>
Tetris with Queue Implementation
</h2>

Final Project Proposal
Tetris with Queue Implementation

<h3>Implementation</h3>

We will be reimplementing the game Tetris to be played and run with Processing. It will implement the concept of queues that we learned this term. The tetromino shapes will be stored in a queue and dequeued one by one as they begin falling down. If the queue is depleted new random tetrominoes will be pushed in. We decided to use a queue because it is the easiest to conceptualize in terms of its FIFO (First In Last Out) properties. We can then utilize this to display what piece will appear next.

<h3>Rules</h3>

Our implementation of Tetris will follow the classic game’s rules and goals-- you rotate and move the tetrominoes to try and fill horizontal lines. Our main goals will be to create a working display and moving game pieces that will successfully follow the rules of Tetris in regards to how the pieces get placed/cleared, how to determine when the game is over, and how the pieces will move (orientation and grid movement). The game ends once a placed tetromino reaches the top of the grid.

<h3>Launch Instructions</h3>

1. Clone this repo: ```git clone git@github.com:tlin7/FederalVulture.git```
2. Change directory to Tetris: ```cd Tetris```
3. Open driver with Processing: ```processing Tetris.pde```
4. Press the play button

<b> ***NOTE*** </b> : The Processing Sound library MUST be installed before running. Being able to actually hear the sound, however, is not necessary for game play.

<h3>Controls</h3>

* Use the left and right arrow keys to move left and right
* Use 'A' and 'D' to rotate the piece counter clockwise and clockwise, respectively
* Use the down arrow key to make the piece fall faster
* Use the up arrow key to drop the piece immediately
* Other keys may be used as prompted

<h3>Bonus features</h3>

Bonus features that we have decided to include (but are not crucial to the core functionality of Tetris) are a scorekeeping display (which includes point bonus for accelerating the descent of the shapes), the ability for a user to choose the level they ant to play, display of the next shape to be played, the availability of help and pause screens, and background music.

# Toy Robot Simulator

## Description:
- The application is a simulation of a toy robot moving on a square tabletop,
of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but must be
prevented from falling to destruction. Any movement that would result in the
robot falling from the table must be prevented, however further valid movement
commands must still be allowed.

- Create an application that can read in commands of the following form:

    PLACE X,Y,F
    MOVE
    LEFT
    RIGHT
    REPORT

- PLACE will put the toy robot on the table in position X,Y and facing NORTH,
SOUTH, EAST or WEST.
- The origin (0,0) can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a PLACE command, after that, any
sequence of commands may be issued, in any order, including another PLACE
command. The application should discard all commands in the sequence until a
valid PLACE command has been executed.
- MOVE will move the toy robot one unit forward in the direction it is
currently facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction
without changing the position of the robot.
- REPORT will announce the X,Y and orientation of the robot.
- A robot that is not on the table can choose to ignore the MOVE, LEFT, RIGHT and REPORT commands.
- Provide test data to exercise the application.


## Constraints
The toy robot must not fall off the table during movement. This also includes
the initial placement of the toy robot.
Any move that would cause the robot to fall must be ignored.

## Example Input and Output
- a)
    PLACE 0,0,NORTH
    MOVE
    REPORT
    Output: 0,1,NORTH

- b)
    PLACE 0,0,NORTH
    LEFT
    REPORT
    Output: 0,0,WEST

- c)
    PLACE 1,2,EAST
    MOVE
    MOVE
    LEFT
    MOVE
    REPORT
    Output: 3,3,NORTH

## Development

```
➜  toy-robot-simulator git:(master) bundle
➜  toy-robot-simulator git:(master) bundle exec rspec

TRS::CommandParser
  discards invalid commands
  only removes invalid commands

TRS::Robot
  never allows out of bounds placements
  #do!
    executes an action per command
  when it has not been placed yet
    should be falsy
    does not REPORT anything
    does not MOVE
    does not rotate LEFT
    does not rotate RIGHT
    can only be placed with a PLACE command
  when it is already placed
    REPORTS its X,Y and orientation
    when the MOVE command is issued
      when the resulting position is within bounds
        moves north
        moves south
        moves east
        moves west
      when the resulting position is out of bounds
        does not move north
        does not move south
        does not move east
        does not move west
    when the LEFT command is issued
      rotates LEFT
    when the RIGHT command is issued
      rotates RIGHT

TRS
  #input_command
    issues PLACE, MOVE and REPORT to the robot
    issues PLACE, LEFT and REPORT to the robot
    issues PLACE, MOVE, MOVE, LEFT, MOVE, and REPORT to the robot
```

## About the Test CLI
We have two options, first one is an interactive command line that can be
started with the `bin/trs` script:

```
➜  toy-robot-simulator git:(master) ✗ bin/trs
 Press ctr-c to exit
 Valid commands:
   PLACE X,Y,DIRECTION
   MOVE
   LEFT
   RIGHT
   REPORT
 Example:
   PLACE 0,0,NORTH
   LEFT
   REPORT
   Output: 0,0,WEST
$ place 0,0,es
Invalid command
$ place 0,0,east
$ move
$ report
Output: 1,0,EAST
$ place 3,3,nor
Invalid command
$ place 3,3,north
$ report
Output: 3,3,NORTH
$ move
$ move
Invalid command
$ report
Output: 3,4,NORTH
$ move
Invalid command
$ report
Output: 3,4,NORTH
$ ^CKilling the robot!
```

The second option is to call the same script with one parameter, this parameter
is the name of a file containing valid commands, one per line:

```
➜  toy-robot-simulator git:(master) ✗ bin/trs spec/support/robot_commands.txt
CMD: place ["1", "2", "EAST"]
CMD: move
CMD: move
CMD: left
CMD: move
CMD: report
Output: 3,3,NORTH
CMD: move
CMD: move
CMD: report
Output: 3,4,NORTH
```

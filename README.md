#Introduction

The goal, And based on set of clues, put nine distinct gures in a 3x3 board.

Each set of clues be From now on called the challenge.

Each set of clues be From now on called desa wire. It follows the shows challenge a wire challenge.




#The META-FORMS in Prolog

Whether each square of the board by a pair where the first element is the line and
second column occupied by this house, with lines identi ed by constant top, center and 
bottom and the columns by left, middle and right.


##The Board

How represents to the board in Prolog, this, and represented by a list of nine elements, 
where correspond first homes the top line, the following line center and last bottom row
of the board (the correspondence should be done from left to right).


##The Peace

Considered to be three types of pieces triangle, circle and square and three colors blue, yellow and 
red. The nine parts are combinations of a shape with a color, and the unique parts for each 
pair (shape, color), ie there is only one triangle yellow, blue, etc. 
Each piece will be represented in Prolog functor through sin, of arity 2, and the constants 
triangle, circle and square are used to represent, respectively, the triangle shapes, 
circle and square, and blue, yellow and red used constants to represent colors with 
the same name. Thus, for example, the term sin (square, blue) is the blue square.


##The Clues

As stated in Annex A can consult the description of the tracks previously Implemented
(code concerning These clues, And provided with the statement this year).

The Following is a description than Dog have to do this year.

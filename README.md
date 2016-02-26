# cs193p-pa1


## Main tasks

1. [x] Get the Calculator working as demonstrated in lectures 1 and 2. The Autolayout portion at the end of the lecture is extra credit, but give it a try because getting good at autolayout requires experience. If you do not do autolayout, be sure to position everything so that it is visible on all iPhones (i.e. the upper left corner of the scene).
2. [x] Your calculator already works with floating point numbers (e.g. if you touch 3 ↲ 4 ÷, it will properly show 0.75), however, there is no way for the user to enter a floating point number directly. Fix this by allowing legal floating point numbers to be entered (e.g. “192.168.0.1” is not a legal floating point number!). You will have to add a new “.” button to your Calculator. Don’t worry too much about precision or significant digits in this assignment.
3. [x] Add the following operations to your Calculator:
  * [x] sin: calculates the sine of the top operand on the stack
  * [x] cos: calculates the cosine of the top operand on the stack
  * [x] π: calculates (well, conjures up) the value of π. For example, 3 π × should put three times the value of π into the display on your calculator. Ditto 3 ↲ π x and also π 3 ×.
4. [X] Add a UILabel to your UI which shows a history of every operand and operation input by the user. Place it at an appropriate location in your UI.
5. [X] Add a C button that clears everything (your display, the new UILabel you added above, etc.). The Calculator should be in the same state as it is at application startup after you touch this new button.
6. [X] Avoid the problems listed in the Evaluation section below. This list grows as the quarter progresses, so be sure to check it again with each assignment. 

## Extra Credit
1. [x] Implement a “backspace” button for the user to touch if they hit the wrong digit button. This is not intended to be “undo,” so if the user hits the wrong operation button, he or she is out of luck! It is up to you to decide how to handle the case where the user backspaces away the entire number they are in the middle of typing, but having the display go completely blank is probably not very user-friendly.
You might find the global functions countElements and dropLast to be a great help with this. Both can take a String as their only argument. The first one is what you would generally think of as “length” and the other drops the last character from the String (and returns the result of doing so). You might be kind of weirded out if you alt-click on these functions. The types of the arguments and return values would require some significant explanation which there is not room for here but, in short, String is actually a collection of characters that can be indexed into and sliced into sub-collections of characters. That is why countElements (which takes a collection) and dropLast (which takes a sliceable thing) work on String.
2. [x] When the user hits an operation button, put an = on the end of the UILabel you added in the Required Task above. Thus the user will be able to tell whether the number in the Calculator’s display is the result of a calculation or a number that the user has just entered. Don’t end up with multiple occurrences of = in your UILabel.
3. [x] Add a ᐩ/- operation which changes the sign of the number in the display. Be careful with this one. If the user is in the middle of entering a number, you probably want to change the sign of that number and allow typing to continue, not force an enter like other operations do. On the other hand, if the user is not in the middle of typing a number, then this operation would work just like any other unary operation (e.g. cos).
4. [x] Change the computed instance variable displayValue to be an Optional Double rather than a Double. Its value should be nil if the contents of display.text cannot be interpreted as a Double (you’ll need to use the documentation to understand the NSNumberFormatter code). Setting its value to nil should clear the display out.
5. [ ] Use Autolayout to make your calculator look good on all different kinds of iPhones in both Portrait and Landscape orientations (don’t worry about iPads for now). Just like we used ctrl-drag to the edges of our scene to position display, you can you ctrl-drag between your UILabels (and/or your C button) to fix their vertical/horizontal spacing relative to each other. Use the blue gridlines! It’s probably a good idea to reset all of your autolayout (via the button in lower right corner), then use ctrl-drag to add constraints to things that are not part of the grid of keypad and operation buttons, then use the buttons in the lower right to lay out those (after you’ve moved them in to place relative to your UILabel(s), etc., using dashed blue lines, of course!).

## Evaluation
In all of the assignments this quarter, writing quality code that builds without warnings or errors, and then testing the resulting application and iterating until it functions properly is the goal.
Here are the most common reasons assignments are marked down:  

* Project does not build.
* Project does not build without warnings.
* One or more items in the Required Tasks section was not satisfied.
* A fundamental concept was not understood.
* Code is visually sloppy and hard to read (e.g. indentation is not consistent, etc.).
* Your solution is difficult (or impossible) for someone reading the code to understand due to lack of comments, poor variable/method names, poor solution structure, long methods, etc.  

Often students ask “how much commenting of my code do I need to do?” The answer is that your code must be easily and completely understandable by anyone reading it. You can assume that the reader knows the SDK, but should not assume that they already know the (or a) solution to the problem.

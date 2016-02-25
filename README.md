# cs193p-pa1


## Main tasks

1. [x] Get the Calculator working as demonstrated in lectures 1 and 2. The Autolayout portion at the end of the lecture is extra credit, but give it a try because getting good at autolayout requires experience. If you do not do autolayout, be sure to position everything so that it is visible on all iPhones (i.e. the upper left corner of the scene).
2. [ ] Your calculator already works with floating point numbers (e.g. if you touch 3 ↲ 4 ÷, it will properly show 0.75), however, there is no way for the user to enter a floating point number directly. Fix this by allowing legal floating point numbers to be entered (e.g. “192.168.0.1” is not a legal floating point number!). You will have to add a new “.” button to your Calculator. Don’t worry too much about precision or significant digits in this assignment.
3. [ ] Add the following operations to your Calculator:
  * [ ] sin: calculates the sine of the top operand on the stack
  * [ ] cos: calculates the cosine of the top operand on the stack
  * [ ] π: calculates (well, conjures up) the value of π. For example, 3 π × should put three times the value of π into the display on your calculator. Ditto 3 ↲ π x and also π 3 ×.
4. [ ] Add a UILabel to your UI which shows a history of every operand and operation input by the user. Place it at an appropriate location in your UI.
5. [ ] Add a C button that clears everything (your display, the new UILabel you added above, etc.). The Calculator should be in the same state as it is at application startup after you touch this new button.
6. [ ] Avoid the problems listed in the Evaluation section below. This list grows as the quarter progresses, so be sure to check it again with each assignment. 

## Extra Credit


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

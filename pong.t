%############################################################################# 
%####                    Created by : Anas Ahmed                          ####  
%####                    Program: Pong Wars                               ####  
%#############################################################################

var window : int 
window := Window.Open ("graphics:600;400;nobuttonbar;position:top;right") 
%this runs program in new window

process music %this command lets you make a process
    loop %for this process I am made a loop that plays music
	Music.PlayFile ("Music.mp3") %finds a music file to play
    end loop
end music
fork music %when you fork a process it lets you play it in background

var ballx, bally : int %these are coordinates of the ball's location
var velx, vely : int %the velocity of coordinate( the change in x and change in y) of ball
var p1y, p2y : int := maxy div 2 %coordinate of y location of player 1 and player 2 bar
var p1score, p2score : int := 0 %score of player 1 and 2, starts at 0
var chars : array char of boolean %this var lets you enter keys on keyboard
var difficulty, size : int %difficulty of game, size of bar
var font1 : int := Font.New ("Impact:50")%adds a font
var font2 : int := Font.New ("Calibri:15")% another font
var name1,name2 : string  %name of player 1 and 2
var score:int %the maximum score to play up to
ballx := maxx div 2 %location of ball at start
bally := maxy div 2 
%Displays Name of Game with the font
Font.Draw ("Loading Please Wait...", maxx div 2 - 50, maxy div 2 - 50, font2, black)
Font.Draw ("PongWars", maxx div 2 - 150, maxy div 2, font1, black)
delay (2000) %waits two seconds
cls
%next few lines gives instructions and input name and difficulty of game"
put "MENU"
put "-----"
put "Enter Player1 name: " ..
get name1
put "Enter Player2 name: " ..
get name2
put "Welcome to PongWars ", name1, " and ", name2
put "This is a two player game, make the ball go out on opponents side to win."
put ""
put name1, " move up with W and down with S, ",name2," move up with up arrow key and down with down arrow key."
put ""
put "Enter Score to play to: "..
get score
put "Enter Difficulty, 1 for easy, 2 for hard, 3 for extreme."
get difficulty
if difficulty = 1 then % if difficulty is easy
    velx := 3 % speed of ball is less
    vely := 3
    size := 75 % and size of bar is big
elsif difficulty = 2 then % if difficulty is hard
    velx := 5 % speed of ball is more then easy
    vely := 5
    size := 60 % size of bar is small
elsif difficulty = 3 then
    velx := 8 %speed if really fast
    vely := 8
    size := 60 % size of bar is same as hard mode
end if
cls
%Displays Ready,Set,Go with 1 second delay between
Font.Draw ("READY", maxx div 2 - 50, maxy div 2, font2, black)
delay (1000)
cls
Font.Draw ("SET", maxx div 2 - 50, maxy div 2, font2, black)
delay (1000)
cls
Font.Draw ("GO!", maxx div 2 - 50, maxy div 2, font2, black)
delay (1000)
cls
%the game starts from now
setscreen ("offscreenonly") %when you enter this code, it hides graphic
%until you enter View.Update code, this helps to get rid of flicker


loop
    put name1," Score:" .. %this puts the Score of players on top of screen
    put p1score : 20 .. % this uses space formatting
    put " " : 10 ..
    put name2," Score:" ..
    put p2score : 20
    drawfillbox (0, p1y, 10, p1y + size, red) %draws p1 bar with y location and size
    drawfillbox (maxx, p2y, maxx - 10, p2y + size, blue)%draws p2 bar with y location and size
    Input.KeyDown (chars)%you have to enter this down to check to see if key is press down
    if p1y + size < maxy then %this stops bar from moving out of canvas
	if chars ('w') then %if letter w is pressed...
	    p1y += 10 %y location of p1 increases by 10
	end if
    end if
    if p1y > 0 then %this stops bar from moving out of canvas
	if chars ('s') then %if letter s is pressed..
	    p1y -= 10 % y coordinate if decreased by 10
	end if
    end if

    if p2y + size < maxy then %same for player 2
	if chars (KEY_UP_ARROW) then %if up arrow is pressed...
	    p2y += 10  % bar y location increases by 10
	end if
    end if
    if p2y > 0 then %again
	if chars (KEY_DOWN_ARROW) then %if down arrow is pressed...
	    p2y -= 10 %y location decreases by 10
	end if
    end if
    drawfilloval (ballx, bally, 10, 10, blue)%draws a ball
    delay (10)%delays it a bit so we can see the ball
    %this long code checks to see if the ball touches either player bars
    if ballx - 10 < 10 and bally > p1y and bally < p1y + size or ballx + 10 > maxx - 10 and bally > p2y and bally < p2y + size then
	velx := velx * -1 %if it does then the velocity reverses and changes direction
    end if
    if bally + 10 > maxy or bally - 10 < 0 then %same for the top and bottem canvas, if it touches the y velocity changes direction by 90 degree
	vely := vely * -1
    end if
    ballx := ballx + velx %the changes in x is added to position of ball
    bally := bally + vely %the change in y is added to position of ball
    View.Update%updates the view
    cls %clears screen so it can redraw image in loop, so it doesnt leave a trail behind
    if ballx < 0 then %if the ball has went past the player1 bar
	p2score += 1 % then player2 gets a point/score
	delay (1000)%freezes game for a second
	ballx := maxx div 2%resets ball location to start again
	bally := maxy div 2
	velx *= -1 %direction of ball changes to player who scored
	p1y := maxy div 2 %bar location is reset
	p2y := maxy div 2
    end if
    if ballx > maxx then %same for other player
	delay (1000)
	p1score += 1 %if player 1 score he gets point
	ballx := maxx div 2%location of ball is reset
	bally := maxy div 2
	velx *= -1%direction of ball is changed to the player who scored
	p1y := maxy div 2%location of bars are reseted for both players
	p2y := maxy div 2
    end if
    exit when p1score = score or p2score = score %When any of the players meet
end loop%the score criteria the game ends
cls
%then whoever has highest score is pronounced the winner of game
if p1score> p2score then
put name1," won the Game"
elsif p2score> p1score then
put name2," won the Game"
end if
View.Update

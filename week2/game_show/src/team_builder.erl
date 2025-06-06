-module(team_builder). % This is the name of the file, minus the .erl extension

% This is a list of the functions that can be called from outside this module
-export([add/2,divide/2,lower_divide/2,remainder/2,difference/2]). 

% This function has either integers or floats as its value, 
% depending on the parameters sent in
add(A, B)->
	A + B. % fill out the body of this function

% This function has floats as its value
divide(Dividend, Divisor)->
	Dividend / Divisor.

% This function has as its value the greatest integer less than the 
% float that is the result of division
lower_divide(Dividend, Divisor)->
	Dividend div Divisor.

% This function has as its value an integer that is the remainder of doing the division
remainder(Dividend, Divisor)->
	Dividend rem Divisor.

% Here is an example of a completed function. This one is passing its unit tests.
difference(Minuend, Subtrahend)->
	Minuend - Subtrahend.



-ifdef(EUNIT).
%
% Unit tests go here. 
%

-include_lib("eunit/include/eunit.hrl").

% This tests the completed difference function
difference_test_()->
	[?_assertEqual(3, difference(9, 6)),% happy path, tests the obvious case
	 % Less obvious things we need to test start start here. Let's test the edge cases.
	 ?_assertEqual(0, difference(0, 0)),
	 ?_assert((0.2872 >= difference(0.756, 0.4689)) and (0.2870  =< difference(0.756, 0.4689))),
	 ?_assertEqual(-12_345_678_894_321_002_220, difference(3_456_782_835,12_345_678_897_777_785_055)),
	 ?_assertEqual(17, difference(10,-7)),
	 ?_assertEqual(-17, difference(-10,7)),
	 ?_assertEqual(-3, difference(-10,-7))
	].

% This tests the add function.
add_test_() ->
	[?_assertEqual(15, add(9, 6)), % Tests the happy path, the obvious case
	 % Less obvious things we need to test start start here. Let's test the edge cases.
	 ?_assertEqual(0, add(0, 0)),
	 ?_assert((1.23445 >= add(0.756, 0.4689)) and (add(0.756, 0.4689) =< 1.3)),
	 ?_assertEqual(12_345_678_901_234_567_890, add(3_456_782_835,12_345_678_897_777_785_055)),
	 ?_assertEqual(-17, add(-10, -7)),
	 ?_assertEqual(-17, add(20, -37))
	].

% This tests the divide function.
divide_test_() ->
	[?_assertEqual(2.0, divide(10, 5)), % Tests the happy path, the obvious case
	 % Less obvious things we need to test start start here. Let's test the edge cases.
	 ?_assertEqual(0.75, divide(3, 4)),
	 % The following check can be broken up into two checks instead of using "and"
	 ?_assert(3.5714285713 =< divide(1.25, 0.35)), 
	 ?_assert(3.5714285715 >= divide(1.25, 0.35)),
	 ?_assert((-0.6666666 >= divide(2, -3)) and (-0.7 =< divide(2, -3))),
	 ?_assert((-0.6666666 >= divide(-2, 3)) and (-0.7 =< divide(2, -3))),
	 ?_assert((0.6666666 =< divide(-2, -3)) and (0.7 >= divide(2, -3)))
	 % Division by zero not covered here because you don't know how to deal with that yet
	].

% This tests the lower_divide function.
lower_divide_test_() ->
	[?_assertEqual(2, lower_divide(10, 5)), % Tests the happy path, the obvious case
	 % Less obvious things we need to test start start here. Let's test the edge cases.
	 ?_assertEqual(-2, lower_divide(-10, 5)),
	 ?_assertEqual(-2, lower_divide(10, -5)),
	 ?_assertEqual(2, lower_divide(-10, -5)),
	 ?_assertEqual(0, lower_divide(5, 10)),	 
	 ?_assertEqual(0, lower_divide(2, 3)),
	 ?_assertEqual(0, lower_divide(-2, 10)),
	 ?_assertEqual(0, lower_divide(2, -10))
	].

% This tests the remainder function.
remainder_test_()->
	[?_assertEqual(0, remainder(10, 5)),% happy path, tests the obvious case
	 % Less obvious things we need to test start start here. Let's test the edge cases.
	 ?_assertEqual(5, remainder(5, 10)),
	 ?_assertEqual(-5, remainder(-5, 10)),
	 ?_assertEqual(-5, remainder(-5, -10)),
	 ?_assertEqual(0, remainder(0, 7))
	 % You do not yet know how to handle the divisor being zero or dealing with float-type numbers
	 % so you don't need to test those cases yet
	].


% Here are some additional unit tests for you to complete. 


% Create a list of 10 random integers between 1 and 10
% Hint: use "rand:uniform(10)" to create a single random integer between 1 and 10
random_list_test_() ->
	Random_numbers = [rand:uniform(10) || _ <- lists:seq(1,10)], % TODO: Replace this with a list of 10 random integers 
	[?_assert(is_list(Random_numbers)), % This checks that Random_numbers is a list
	 ?_assertEqual(10, length(Random_numbers)), % This checks that Random_numbers has 10 elements
	 ?_assertEqual([], lists:filter(fun(N)-> N > 10 end, Random_numbers)) % This checks that all the numbers are between 1 and 10
	].

% Create a list of at least 8 tuples where each tuple consists of 
% a name, as an atom, a gender, as an atom, and a height, as a float in that order. 
% For example, one tuple might be {john, male, 1.8}.
person_tuple_list_test_() ->
	People = [{jim, male, 5.4}, {george, male, 6.1}, {fred, male, 2.3}, {quentin, male, 9.9}, {cynthia, female, 8.2}, {sally, female, 3.8}, {betty, female, 4.2}, {sarah, female, 2.4}], % TODO: Replace this with the list of tuples described in the previous comment
	[?_assert(is_list(People)), % This checks that People is a list
	 ?_assert(length(People) >= 8), % This checks that People has at least 8 elements
	 
	 % This checks that all the elements of People are tuples
	 ?_assert(lists:all(fun(Person)-> is_tuple(Person) end, People)), 

	 % This checks that all the elements of People are of the form {Name, Gender, Height}
	 ?_assert(lists:all(fun({Name, Gender, Height})-> is_atom(Name) and is_atom(Gender) and is_float(Height) end, People))
	].

% Create a list of genders that includes male, female, and other
gender_list_test_()->
	Genders = [male, female, other], % TODO: Replace this with a list of genders including male, female, and other
	[?_assert(lists:member(male, Genders)), % This checks that male is in the list
	 ?_assert(lists:member(female, Genders)), % This checks that female is in the list
	 ?_assert(lists:member(other, Genders)), % This checks that other is in the list
	 ?_assertNot(lists:member(none, Genders)) % This checks that none is not in the list
	].
-endif.

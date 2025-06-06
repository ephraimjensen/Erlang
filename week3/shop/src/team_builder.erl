-module(team_builder).
-export([divide/2, lower_divide/2, remainder/2]).

% This function has floats as its value
% factorial(N) when N == 0 -> 1;
divide(Dividend, Divisor) when Divisor == 0 -> fail;
divide(Dividend, Divisor) when Divisor /= 0->
	Dividend / Divisor.

% This function has as its value the greatest integer less than the float that
% is the result of division
lower_divide(Dividend, Divisor) when Divisor == 0 -> fail;
lower_divide(Dividend, Divisor) ->
	Dividend div Divisor.

% This function has as its value an integer that is the remainder of doing the
% division
% 
remainder(Dividend, 0)->
	fail;
remainder(Dividend, Divisor) when is_float(Dividend)->
	fail;
remainder(Dividend, Divisor) when is_float(Divisor) ->
	fail;
remainder(Dividend, Divisor)->
	Dividend rem Divisor.



-ifdef(EUNIT).
%
% Unit tests go here. 
%

-include_lib("eunit/include/eunit.hrl").

% This tests the divide/2 function
divide_test_() ->
	[
	 % happy path, tests the obvious case. If we divide 10 and 5 we want it to 
	 % return the float 2.0
	 ?_assertEqual(2.0, divide(10, 5)),
	 
	 % Less obvious things we need to test start start here. Let's test the edge cases.
	 ?_assertEqual(fail, divide(3, 0)), % This should return the atom fail if we try to divide by 0.
	 ?_assertEqual(0.75, divide(3, 4)), 

	 % This next check can be broken up into two checks instead of using "and"
	 ?_assert(3.5714285713 =< divide(1.25, 0.35)),
	 ?_assert(3.5714285715 >= divide(1.25, 0.35)),
	
	 % Or we can use "and" to test both conditions
	 ?_assert((-0.6666666 >= divide(2, -3)) and (-0.7 =< divide(2, -3))),
	 ?_assert((-0.6666666 >= divide(-2, 3)) and (-0.7 =< divide(2, -3))),
	 ?_assert((0.6666666 =< divide(-2, -3)) and (0.7 >= divide(2, -3)))
	].

% This tests the lower_divide/2 function
lower_divide_test_() ->
	[?_assertEqual(2, lower_divide(10, 5)), % happy path, tests the obvious case
	 
	 % Less obvious things we need to test start start here. Let's test the edge cases.
	 ?_assertEqual(fail, lower_divide(10, 0)), % Dividing by 0 should return the atom fail.
	 ?_assertEqual(-2, lower_divide(-10, 5)),
	 ?_assertEqual(-2, lower_divide(10, -5)),
	 ?_assertEqual(2, lower_divide(-10 ,-5)),
	 ?_assertEqual(0, lower_divide(5, 10)),	 
	 ?_assertEqual(0, lower_divide(2, 3)),
	 ?_assertEqual(0, lower_divide(-2, 10)),
	 ?_assertEqual(0, lower_divide(2, -10))
	].

% This tests the remainder/2 function
remainder_test_()->
	[?_assertEqual(0, remainder(10, 5)), % happy path, tests the obvious case
	 
	% Less obvious things we need to test start start here. Let's test the edge cases.
	 ?_assertEqual(fail, remainder(5, 0)),
	 ?_assertEqual(fail, remainder(5.0, 2.0)),
	 ?_assertEqual(5, remainder(5, 10)),
	 ?_assertEqual(-5, remainder(-5, 10)),
	 ?_assertEqual(-5, remainder(-5, -10)),
	 ?_assertEqual(0, remainder(0, 7))
	].
-endif.
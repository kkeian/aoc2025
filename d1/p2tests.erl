-module(p2tests).
-export([run_zero_starts/0, run_nz_starts/0, run_normalize/0]).
-import(p2, [count_crossings/2, normalize/1]).

run_zero_starts() ->
	0 = count_crossings(0, 55),
	1 = count_crossings(0, 100),
	2 = count_crossings(0, 200),
	0 = count_crossings(0, -1),
	1 = count_crossings(0, -100),
	2 = count_crossings(0, -200),
	1 = count_crossings(0, 101),
	1 = count_crossings(0, -101),
	2 = count_crossings(0, -238),
	ok.
	
run_nz_starts() ->
	0 = count_crossings(1, 2),
	0 = count_crossings(1, 99),
	1 = count_crossings(1, 100),
	2 = count_crossings(1, 200),
	1 = count_crossings(1, -1),
	2 = count_crossings(1, -100),
	3 = count_crossings(1, -200),
	1 = count_crossings(1, 101),
	2 = count_crossings(1, -101),
	ok.
	
run_normalize() ->
	1 = normalize(1),
	99 = normalize(99),
	99 = normalize(-1),
	1 = normalize(-99),
	97 = normalize(-3),
	23 = normalize(323),
	77 = normalize(-323),
	0 = normalize(100),
	0 = normalize(-200),
	0 = normalize(300),
	ok.
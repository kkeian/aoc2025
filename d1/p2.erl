-module(p2).
-export([start/0, count_crossings/2, normalize/1]).

start() ->
	{ok, InFile} = file:open(input, [read, {encoding, utf8}]),
	Lines = lists:reverse(get_lines(InFile)),
	ok = file:close(InFile),
	Password = get_password(Lines),
	io:fwrite("~w~n", [Password]).
	
get_lines(Fd) ->
	get_lines(Fd, []).

get_lines(Fd, Lines) ->
	case
		io:fread(Fd, '', "~1tc~u\n")
	of
		eof ->
			Lines;
		{ok, [Dir, Dist]} ->
			get_lines(Fd, [#{list_to_atom(string:lowercase(Dir)) => Dist} | Lines])
	end.
	
get_password(Lines) ->
	get_password(Lines, 50, 0).
	
get_password([#{l := Dist} | R], Pos, Pw) ->
	get_password(R, normalize(Pos-Dist), Pw+count_crossings(Pos, Pos-Dist));
get_password([#{r := Dist} | R], Pos, Pw) ->
	get_password(R, normalize(Pos+Dist),  Pw+count_crossings(Pos, Pos+Dist));
get_password([], _, Pw) ->
	Pw.
	
count_crossings(0, Curr) when (Curr rem 100) =:= 0 ->
	if
		Curr < -99 ->
			-(Curr div 100);
		Curr > 99 ->
			Curr div 100
	end;
count_crossings(0, Curr) ->
	if
		Curr < -100 ->
			-(Curr div 100);
		Curr > 100 ->
			Curr div 100;
		true ->
			0
	end;
count_crossings(_, 0) ->
	1;
count_crossings(_, Curr) when (Curr rem 100) =:= 0 ->
	if
		Curr > 99 ->
			Curr div 100;
		Curr < -99 ->
			1 + -(Curr div 100)
	end;
count_crossings(_, Curr) ->
	if
		Curr < -100 ->
			1 + -(Curr div 100);
		Curr < 0 ->
			1;
		100 < Curr ->
			Curr div 100;
		true ->
			0
	end.
	
normalize(Pos) when Pos rem 100 =:= 0 ->
	0;
normalize(Pos) ->
	if
		Pos < 0 ->
			100 + (Pos rem 100);
		Pos > 99 ->
			Pos rem 100;
		true ->
			Pos
	end.
-module(p1).
-export([start/0]).
-compile(debug).

start() ->
	{ok, InFile} = file:open(input, [read, {encoding, utf8}]),
	Lines = lists:reverse(get_lines(InFile)),
	ok = file:close(InFile),
	io:fwrite("~p~n~w~n", [Lines, length(Lines)]),
	End = get_password(Lines, 50),
	io:fwrite("~p~n", [End]).	
	
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
	
get_password(L, 50) ->
	get_password(L, 50, 0).
get_password([], _EndPos, Pw) ->
	Pw;
get_password([#{l := Dist} | Rest], Pos, Pw) ->
	case
		normalize_pos(Pos - Dist)
	of
		0 ->
			get_password(Rest, 0, Pw+1);
		N ->
			get_password(Rest, N, Pw)
	end;
get_password([#{r := Dist} | Rest], Pos, Pw) ->
	case
		normalize_pos(Pos + Dist)
	of
		0 ->
			get_password(Rest, 0, Pw+1);
		N ->
			get_password(Rest, N, Pw)
	end.
	
normalize_pos(P) ->
	P rem 100.
	
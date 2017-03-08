%%%-------------------------------------------------------------------
%%% @author Tom Kelher
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. jan 2017 21:09
%%%-------------------------------------------------------------------
-module(agendaProcess).
-author("Tom Kelher").

%% API
-export([ start/0]).

start() ->  Agenda = spawn(agenda_process, loop2,[0]),
  Teller = spawn(agenda_process,loop,[0]),
  Agenda!create,
  Teller!tel .

loop2() -> receive
             stop -> ok;
             create -> ets:new('Logboek', [public, ordered_set, {keypos, 1}]),loop2()
           end.

loop(C) -> receive
             stop -> ok;
             reset -> loop(0);
             inc -> loop(C+1);
             tel -> ets:insert_new('Logboek',C),loop(C);
             {get,P} -> P!C, loop(C)
           end.
%%%-------------------------------------------------------------------
%%% @author Tom Kelher
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. jan 2017 18:37
%%%-------------------------------------------------------------------
-module(agenda).
-author("Tom Kelher").

%% API
-export([add/4,start/0,init/0,deletefirst/0,firstEvent/0,nextEvent/0]).

start() -> PID = spawn(?MODULE,init,[]),
  register(agendake,PID).

init()  -> Tabel = ets:new('Agenda', [named_table,public, ordered_set,{keypos, 1}]),
  ets:insert_new('Agenda',{infinity,event_manager,stop,[]}),
  loop(Tabel).

loop(Tabel) -> receive
                 {add,{S,M,F,Args}}  ->  ets:insert_new('Agenda', {S,M,F,Args}),
                   %logboekje:add_to_logboek(Task),
                   io:format("Task ~p at Time = ~p is added in Agenda ~n",[F,S]),
                   loop(Tabel);

                 {Ref1,PID,next} -> Begin = ets:first('Agenda'),
                   PID ! {Ref1,Begin},
                   loop(Tabel);

                 {Ref2,PID,first} -> K = ets:first('Agenda'),
                   First = ets:lookup('Agenda',K),
                   %io:format("~n In First zit ~p~n",[First]),
                   W = lists:keyfind(K,1,First),
                   PID ! {Ref2,W},
                   loop(Tabel);

                 {delete} -> K = ets:first('Agenda'),
                   ets:delete('Agenda', K),
                   io:format("Task deleted in Agenda ~n"),
                   loop(Tabel)

               end.

add(S,M,F,Args) -> agendake ! {add,{S,M,F,Args}}.

nextEvent() -> Ref1 = make_ref(),
  agendake ! {Ref1,self(),next},
  receive
    {Ref1,Begin} -> Begin
  end.

firstEvent() -> Ref2 = make_ref(),
  agendake ! {Ref2,self(),first},
  receive
    {Ref2,W} -> W
  end.

deletefirst() -> agendake ! {delete}.


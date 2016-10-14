%%%-------------------------------------------------------------------
%%% @author
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. okt 2016 16:41
%%%-------------------------------------------------------------------
-module(agenda_process).
-author("Wastedpenguin").

%% API
-export([start/0]).

start() -> spawn(agenda_process,loop,[0]).

loop() -> receive
            maak -> ets:new(tabel, [ordered_set,{keypos,1}]);
            {T,AI} -> ets:insert_new(T,AI);
            {T,Sleutel} -> ets:delete(T,Sleutel)
          end.



%% API
-export([start/0, loop/1, create/0, add/1]).


start() ->  create(),
  Loop_PID = spawn(main, loop, [0]),
  timer:apply_interval(1000, main,add(Loop_PID),[Loop_PID]).

create() -> ets:new('Logboek', [ordered_set, {keypos, 1}]).

add(Loop_PID) ->  Value = Loop_PID ! {get, self()},
  ets:insert_new(16400, {5, 5}).

loop(C) -> receive
             stop -> ok;
             reset -> loop(0);
             inc -> loop(C+1);
             {get,P} -> P!C, loop(C)
           end.

%logboek(C) -> receive
%               new -> ets:new(logboek, [ordered_set, {keypos, 1}]);
%              add -> ets:insert_new(16400, {'test', 'test'})
%             %verwijder -> ets:delete("taken",C);
%            %{get,P} -> ets:lookup("taken",P)
%         end.
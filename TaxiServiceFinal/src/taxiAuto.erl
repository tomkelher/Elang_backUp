%%%-------------------------------------------------------------------
%%% @author Tom Kelher
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. jan 2017 17:11
%%%-------------------------------------------------------------------
-module(taxiAuto).
-author("Tom Kelher").

%% API
-export([create/1, init/1]).

create(Naam) -> PID = spawn(?MODULE,init,[Naam]),
  autoManager:add(PID),
  logboek:add(Naam),
  PID.


init(Naam) ->   Tabel = ets:new(Naam, [public, ordered_set,{keypos, 1}]),
  loop(Tabel).

loop(Args) -> receive
                {boek, Activiteit, Start, Einde, Bestemming} ->
                  ets:insert_new(Args, {Activiteit,Start,Einde,Bestemming}),
                  loop(Args);

                {delete} ->
                  autoManager ! {delete_auto, self()},
                  ok                                   % delete auto door process te killen
              end.
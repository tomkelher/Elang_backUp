%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. jan 2017 1:21
%%%-------------------------------------------------------------------
-module('TaxiAuto').
-author("Eigenaar").

-export([create/1, init/1]).

create(Naam) -> PID = spawn(?MODULE,init,[Naam]),
  auto_manager:add(PID),
  logboekje:add(Naam),
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



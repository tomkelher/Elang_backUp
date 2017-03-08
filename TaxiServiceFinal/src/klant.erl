%%%-------------------------------------------------------------------
%%% @author Tom Kelher
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. jan 2017 17:11
%%%-------------------------------------------------------------------
-module(klant).
-author("Tom Kelher").

%% API
-export([create/1,init/1]).

create(Naam) -> PID = spawn(?MODULE,init,[Naam]),
  logboek:add(Naam),
  PID.


init(Naam) ->  Tabel = ets:new(Naam, [named_table,public, ordered_set, {keypos, 1}]),
  loop(Tabel).

loop(Args) -> receive

                {boek,PID,Start,Eind} -> ets:insert_new(Args,{PID,Start,Eind}),
                  loop(Args);

                {delete,PID} -> ets:delete(Args,PID),
                  loop(Args);
                stop -> ok
              end.


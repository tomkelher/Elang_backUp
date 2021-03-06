%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. okt 2016 11:14
%%%-------------------------------------------------------------------
-module('klant').
-author("Eigenaar").



%% API
-export([create/1,init/1]).

create(Naam) -> PID = spawn(?MODULE,init,[Naam]),
  logboekje:add(Naam),
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
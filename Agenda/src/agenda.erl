%%%-------------------------------------------------------------------
%%% @author
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. sep 2016 14:14
%%%-------------------------------------------------------------------
-module(agenda).
-author("Tom").

%% API
-export([maak/0, insert/2, delete/2]).

maak() -> ets:new(tabel, [ordered_set,{keypos,1}]).

insert(T,AI) -> ets:insert_new(T,AI).

delete(T,Sleutel) -> ets:delete(T,Sleutel).


%%%-------------------------------------------------------------------
%%% @author Tom Kelher
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. jan 2017 21:15
%%%-------------------------------------------------------------------
-module(main).
-author("Tom Kelher").

%% API
-export([start/0]).



start() ->  compile:file(activiteiten),
  compile:file(agenda),
  compile:file(taxiAuto),
  compile:file(autoManager),
  compile:file(eventManager),
  compile:file(klant),
  compile:file(freelancer),
  compile:file(logboek),
  observer:start(),
  logboek:start(),

  autoManager:start(),
  eventManager:start(),
  agenda:start(),

  Mama = klant:create(mama),
  Papa = klant:create(papa),
  Freelancer1 = klant:create(freelancer1),
  Auto1 = taxiAuto:create(auto1),
  Auto2 = taxiAuto:create(auto2),
  Auto3 = taxiAuto:create(auto3),

  {ok,Time} = eventManager:getTime(),
  io:format("The time is ~p~n",[Time]),
  Act1 = activiteiten:create(Time + 2000,   Time + 10000,"Werk",[Mama],Auto1),
  Act2 = activiteiten:create(Time + 3000,   Time + 30000,"Werk",[Papa],Auto2),
  Act3 = activiteiten:create(Time + 2000,   Time + 100000,"winkelen",[Freelancer1],Auto3),
  Act4 = activiteiten:create(Time + 110000, Time + 200000,"kinderen halen",[Freelancer1],Auto3).

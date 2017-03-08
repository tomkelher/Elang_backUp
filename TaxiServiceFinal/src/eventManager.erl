%%%-------------------------------------------------------------------
%%% @author Tom Kelher
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. jan 2017 21:14
%%%-------------------------------------------------------------------
-module(eventManager).
-author("Tom Kelher").


%% API
-export([start/0,loop/1,stop/0,getTime/0,add_event/4]).

start() -> PID = spawn(?MODULE,loop,[erlang:timestamp()]),
  register(eventManager,PID).

stop() -> eventManager ! stop.

add_event(Start,Module,Function,Args) -> eventManager ! {add,{Start,Module,Function,Args}}.

getTime() -> UniqueRef = make_ref(),
  eventManager ! {getTime,self(),UniqueRef},
  receive
    {UniqueRef,Time} -> {ok,Time}
  end.

loop(StartingTime) ->

  Time = timer:now_diff(erlang:timestamp(),StartingTime),
  TimeNextEvent = agenda:nextEvent(),

  if
    TimeNextEvent =< Time ->
      % doe taak;
      {_,M,F,Args} = agenda:firstEvent(),
      spawn(M,F,[Args]),
      agenda:deletefirst(),
      loop(StartingTime);
    true ->
      % wacht tot taak
      WaitTime = if
                   TimeNextEvent =:= infinity ->
                     infinity;
                   true ->
                     (TimeNextEvent - Time) div 1000 +1
                 end,

      receive
        {getTime,PID,Ref} -> Now = timer:now_diff(erlang:timestamp(),StartingTime) div 1000,
          PID ! {Ref,Now},
          loop(StartingTime);
        {add,{Start,Module,Function,Args}} ->
          agenda:add(Start*1000,Module,Function,Args),
          loop(StartingTime);
        stop -> ok
      after
        WaitTime -> loop(StartingTime)
      end
  end.

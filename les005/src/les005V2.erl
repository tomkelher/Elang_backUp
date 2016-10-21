%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. okt 2016 10:13
%%%-------------------------------------------------------------------
-module(les005V2).
-author("Eigenaar").

%% API
-export([]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-record(studenten,{naam=[]}).
-record(vakken,{naam=[], punt=[]}).

%oef 1 -> studenten met minstens 3

%telAantalBuizen({Student, Examens}) ->
%  {student, lists:foldl(fun(#vakken{naam=_,punt=P},Teller) ->
%    if P>= 10 -> Teller;true -> Teller+1 end
%  end,
%  0,  Examens}.

%oef 2 -> studenten die op alles geslaagd zijn



%oef 3 Studenten met gewogen percentage <54 en 1 onvoldoende +  tussen 54 en 58 met 2 onvoldoendes.


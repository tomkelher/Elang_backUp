%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. okt 2016 10:13
%%%-------------------------------------------------------------------
-module(les005).
-author("Eigenaar").

%% API
-export([testSuiteOef1/0,testSuiteOef2/0,testSuiteOef3/0]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-record(examen,{vak="", punt=0}).
-record(student,{naam="", examens=[]}).
%oef 1 -> studenten met minstens 3  onvoldoenden
buizen(L) -> lists:filter(fun(#examen{vak=_,punt=P})-> P<10 end, L).
testSuiteOef1() ->
  Student = [
    #student{naam="Sander",examens=[#examen{vak="Wiskunde",punt=8},#examen{vak="B",punt=15},#examen{vak="C",punt=16},#examen{vak="D",punt=15}]},
    #student{naam="Tom",examens=[#examen{vak="Wiskunde",punt=12},#examen{vak="B",punt=8},#examen{vak="C",punt=3},#examen{vak="D",punt=7}]},
    #student{naam="Gijs",examens=[#examen{vak="Fysica",punt=8},#examen{vak="B",punt=16},#examen{vak="C",punt=13},#examen{vak="D",punt=10}]}
  ],
  minderGoedeStudenten(Student).
minstens3Buizen(Examens) -> length(buizen(Examens))>=3.
minderGoedeStudenten(Studs) -> lists:filter(fun(#student{naam=_,examens = Exs }) -> minstens3Buizen(Exs) end,Studs).


%oef 2 -> studenten die op alles geslaagd zijn
allesGeslaagd(Studs) ->  lists:filter(fun(#student{naam=_,examens = Exs}) ->
  GeslaagdeVakken = lists:filter(fun(#examen{vak=_,punt = P}) -> P >=10 end,Exs),
  AantalGeslaagd = length(GeslaagdeVakken),
  TotaalAantal = length(Exs),
  AantalGeslaagd == TotaalAantal end, Studs).
testSuiteOef2() ->
  Student = [
    #student{naam="Sander",examens=[#examen{vak="Wiskunde",punt=8},#examen{vak="B",punt=15},#examen{vak="C",punt=16},#examen{vak="D",punt=15}]},
    #student{naam="Tom",examens=[#examen{vak="Wiskunde",punt=12},#examen{vak="B",punt=10},#examen{vak="C",punt=10},#examen{vak="D",punt=20}]},
    #student{naam="Gijs",examens=[#examen{vak="Fysica",punt=8},#examen{vak="B",punt=16},#examen{vak="C",punt=13},#examen{vak="D",punt=10}]}
  ],
  allesGeslaagd(Student).


%oef 3 Studenten met gewogen percentage <54 en 1 onvoldoende +  tussen 54 en 58 met 2 onvoldoendes.
gewogenPerc(Studs) -> lists:filter(fun(#student{naam=_,examens = Exs}) ->
  GeslaagdeVakken = lists:filter(fun(#examen{vak=_,punt = P}) -> P >=10 end,Exs),
  ((gemiddeldeBer(Exs#examen.punt) < 54 andalso (length(Exs) - length(GeslaagdeVakken)) == 1) or
  (gemiddeldeBer(Exs#examen.punt) < 58 andalso gemiddeldeBer(Exs#examen.punt) > 54 andalso (length(Exs) - length(GeslaagdeVakken)) == 2))
end, Studs).
gemiddeldeBer(Lijst) -> lists:sum(Lijst)/ length(Lijst).
testSuiteOef3() ->
  Student = [
    #student{naam="Sander",examens=[#examen{vak="Wiskunde",punt=8},#examen{vak="B",punt=15},#examen{vak="C",punt=16},#examen{vak="D",punt=15}]},
    #student{naam="Tom",examens=[#examen{vak="Wiskunde",punt=12},#examen{vak="B",punt=10},#examen{vak="C",punt=10},#examen{vak="D",punt=20}]},
    #student{naam="Gijs",examens=[#examen{vak="Fysica",punt=8},#examen{vak="B",punt=16},#examen{vak="C",punt=13},#examen{vak="D",punt=10}]}
  ],
  gewogenPerc(Student).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-record(examen,{vak="", punt=0}).
-record(student,{naam="", examens=[]}).


%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. sep 2016 12:20
%%%-------------------------------------------------------------------
-module(main).
-author("Eigenaar").

%% API
-export([kalender/0]).

%start() -> spawn(main,loop,[0]).


%%shell commands
%%P = main:start().
%%P!inc.
%%P!{get,self()}.
%%c:flush().
%loop(C) -> receive
%             stop -> ok;
%             reset -> loop(0);
%             inc -> loop(C+1);
%             {get,P} -> P!C, loop(C)
 %          end.
%

%%datastructuren lijsten en tuppits, er is een bibliotheek bibliotheek ETS (erlang ets-> google)
%% hash tabbelen en geavanceerde binaiere bomen. Bomen is een data structuur met een root, velden met gegevens en verwijzingen naar verdere gegevens
%%-> gesorteerde verzameling van data, zijn meestal binair, en er zijn technieken om die bijna perfect gebalanceert te houden
%%log2(n) is typisch de efficientie.
%%observer in console laat toe om die tabellen en dergelijke te bekijken
%%eender welke datastructuur mag daarin zitten
%start() -> spawn(main,agenda,[0]).
%agenda(C) -> receive
 %            add -> ets:insert_new("taken", C);
  %           verwijder -> ets:delete("taken",C);
   %          {get,P} -> ets:lookup("taken",P)
    %       end.

kalender() -> ets:new(dag,[ordered_set, {keypos,1}]).

%in shell:
%c(main).
%------>{ok,main}

%main:kalender().
%------>16400

%observer:start().
%------>ok


%%teller lopen, en dan een module die da start, en dan een ets tabel creeren die een naam "logboek" heeft met spawn
%%creeren
%%teller aanpassen, telkens als er een inrement gebeurd wegschrijven naar dat logboek (ook bij reset)
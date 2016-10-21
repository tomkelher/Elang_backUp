%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. okt 2016 15:17
%%%-------------------------------------------------------------------
-module(wedstrijd).
-author("Eigenaar").

%% API
-export([]).

%per ticket is er een eigenaar (persoon) en een aantal gegevens [vak, rij, stoel]
-record(ticketverkoop,{persoon="", ticket=[]}).


-module(chat_app_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
    chat_server:start(),
    {ok, self()}.

stop(_State) ->
    ok.
% chat_client:start("bob").
% chat_client:start("alice").
% chat_client:start("steven").
% chat_client:start("brenda").
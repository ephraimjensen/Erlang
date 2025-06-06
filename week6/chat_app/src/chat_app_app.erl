
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

% chat_client:send("bob", {"alice", "Hello Alice!!"}).
% % chat_client:send("alice", {"bob", "Howdy Bob."}).
% chat_client:send("bob", {"steven", "Are you there Steven?"}).
% % 
% chat_client:start("steven").
% chat_client:send("bob", {"steven", "Are you there Steven?"}).
% chat_client:send("steven", {"bob", "I'm here now"}).
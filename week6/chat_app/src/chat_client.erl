
-module(chat_client).
-export([start/1, send/2, loop/1]).

start(Username) ->
    Pid = spawn(?MODULE, loop, [Username]),
    chat_server ! {register, Username, Pid},
    Pid.

loop(Username) ->
    receive
        {message, From, Msg} ->
            io:format("[~s] ~s: ~s~n", [Username, From, Msg]),
            loop(Username);

        {info, Msg} ->
            io:format("[~s info] ~s~n", [Username, Msg]),
            loop(Username);

        {error, Msg} ->
            io:format("[~s error] ~s~n", [Username, Msg]),
            loop(Username)
    end.

send(From, {To, Msg}) ->
    chat_server ! {send_message, From, {To, Msg}}.

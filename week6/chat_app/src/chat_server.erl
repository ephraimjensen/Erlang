
-module(chat_server).
-export([start/0]).

start() ->
    case whereis(chat_server) of
        undefined -> ok;
        Pid -> exit(Pid, kill)
    end,
    register(chat_server, spawn(fun() -> loop(#{} ) end)).

loop(UserMap) ->
    receive
        {register, Username, Pid} ->
            NewMap = maps:put(Username, Pid, UserMap),
            Pid ! {info, "Welcome, " ++ Username ++ "!"},
            loop(NewMap);

        {send_message, FromUser, {ToUser, Msg}} ->
            case maps:find(ToUser, UserMap) of
                {ok, ToPid} ->
                    ToPid ! {message, FromUser, Msg},
                    loop(UserMap);
                error ->
                    maps:get(FromUser, UserMap) ! {error, "User not found"},
                    loop(UserMap)
            end
    end.
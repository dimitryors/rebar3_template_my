-module({{ name }}_gen_statem).

-define(SERVER, ?MODULE).

-behaviour(gen_statem).


%% Application callbacks
-export([start_link/0, button/1, stop/0]).
-export([init/1, callback_mode/0, locked/3, open/3, terminate/3, code_change/4]).


%%====================================================================
%% API common
%%====================================================================

start_link() ->
    gen_statem:start_link({local, ?SERVER}, ?MODULE, [], []).

button(Digit) ->
    gen_statem:cast(?SERVER, {button, Digit}).

init(Code) ->
    do_lock(),
    Data = #{code => Code, remaining => Code},
    {ok, locked, Data}.

callback_mode() ->
    state_functions.
%%--------------------------------------------------------------------
stop() ->
    gen_statem:call(?SERVER, stop).


%%====================================================================
%% API user
%%====================================================================

% gen_server:cast(?MODULE, {_Some}).
% gen_server:call(?MODULE, {_Some}).

%%====================================================================
%% Internal functions
%%====================================================================

locked(cast, {button,Digit}, Data0) ->
    case analyze_lock(Digit, Data0) of
	{open = StateName, Data} ->
	    {next_state, StateName, Data, 10000};
	{StateName, Data} ->
	    {next_state, StateName, Data}
    end;
locked({call, From}, Msg, Data) ->    
    handle_call(From, Msg, Data);
locked({info, Msg}, StateName, Data) ->    
    handle_info(Msg, StateName, Data).

open(timeout, _, Data) ->
    do_lock(),
    {next_state, locked, Data};
open(cast, {button,_}, Data) ->
    {next_state, locked, Data};
open({call, From}, Msg, Data) ->    
    handle_call(From, Msg, Data);
open(info, Msg, Data) ->    
    handle_info(Msg, open, Data).

terminate(_Reason, State, _Data) ->
    State =/= locked andalso do_lock(),
    ok.
code_change(_Vsn, State, Data, _Extra) ->
    {ok, State, Data}.

handle_call(From, stop, Data) ->
     {stop_and_reply, normal,  {reply, From, ok}, Data}.

handle_info(Info, StateName, Data) ->
    {stop, {shutdown, {unexpected, Info, StateName}}, StateName, Data}.

analyze_lock(Digit, #{code := Code, remaining := Remaining} = Data) ->
     case Remaining of
         [Digit] ->
	     do_unlock(),
	     {open,  Data#{remaining := Code}};
         [Digit|Rest] -> % Incomplete   
             {locked, Data#{remaining := Rest}};
         _Wrong ->
             {locked, Data#{remaining := Code}}
     end.

do_lock() ->
    io:format("Lock~n", []).
do_unlock() ->
    io:format("Unlock~n", []).

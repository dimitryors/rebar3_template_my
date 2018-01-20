-module({{ name }}_gen_server).

-behaviour(gen_server).

-define(SERVER, ?MODULE).
-record(state, {}).

%% Application callbacks
-export([start_link/0, stop/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%%====================================================================
%% API common
%%====================================================================

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init([]) ->
    State = #state{},
    {ok, State}.

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% API user
%%====================================================================

% alloc() ->
%    gen_server:call(?MODULE, alloc).

% free(Ch) ->
%     gen_server:cast(?MODULE, {free, Ch}).


%%====================================================================
%% Internal functions
%%====================================================================

handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

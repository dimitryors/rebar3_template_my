-module({{name}}_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    ChildSpecList = [ child({{ name }}_gen_server, worker),
		      child({{ name }}_gen_statem, worker)
                    ],
    SupFlags = #{   strategy    => one_for_one,
                    intensity   => 10,
                    period      => 10
                },
    {ok, { SupFlags, ChildSpecList} }.

%%====================================================================
%% Internal functions
%%====================================================================

child(Module, Type) ->
    #{  id          => Module,
        start       => {Module, start_link, []},
        restart     => permanent,
        shutdown    => 5000,
        type        => Type,
        modules     => [Module]
    }.

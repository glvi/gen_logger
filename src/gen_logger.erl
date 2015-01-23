%%------------------------------------------------------------------------------
%% Copyright (c) 2015, Feng Lee <feng@emqtt.io>
%% 
%% Permission is hereby granted, free of charge, to any person obtaining a copy
%% of this software and associated documentation files (the "Software"), to deal
%% in the Software without restriction, including without limitation the rights
%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%% copies of the Software, and to permit persons to whom the Software is
%% furnished to do so, subject to the following conditions:
%% 
%% The above copyright notice and this permission notice shall be included in all
%% copies or substantial portions of the Software.
%% 
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%% SOFTWARE.
%%------------------------------------------------------------------------------

-module(gen_logger).

%%%=========================================================================
%%%  API
%%%=========================================================================
-export([debug/1, debug/2,
         info/1, info/2,
         warning/1, warning/2,
         error/1, error/2,
         critical/1, critical/2]).

%%%=========================================================================
%%%  Behaviour
%%%=========================================================================

-ifdef(use_specs).

%%%=========================================================================
%%%  Callbacks
%%%=========================================================================

-callback debug(Msg :: string()) -> ok. 
-callback debug(Msg :: string(), Args :: list()) -> ok. 

-callback info(Msg :: string()) -> ok. 
-callback info(Msg :: string(), Args :: list()) -> ok. 

-callback warning(Msg :: string()) -> ok. 
-callback warning(Msg :: string(), Args :: list()) -> ok. 

-callback error(Msg :: string()) -> ok. 
-callback error(Msg :: string(), Args :: list()) -> ok. 

-callback critical(Msg :: string()) -> ok. 
-callback critical(Msg :: string(), Args :: list()) -> ok. 

-else.

-export([behaviour_info/1]).

behaviour_info(callbacks) ->
    [{debug, 1}, {debug, 2},
     {info, 1}, {info, 2},
     {warning, 1}, {warning, 2},
     {error, 1}, {error, 2},
     {critical, 1}, {critical, 2}];
behaviour_info(_Other) ->
    undefined.

-endif.

%%%=========================================================================
%%%  error_logger default
%%%=========================================================================

debug(Msg) ->
    error_logger:info_msg([" [debug] " | Msg]).

debug(Format, Args) ->
    error_logger:info_msg([" [debug] " | Format], Args).

info(Msg) ->
    error_logger:info_msg([" [info] " | Msg]).

info(Format, Args) ->
    error_logger:info_msg([" [info] " | Format], Args).

warning(Msg) ->
    error_logger:warning_msg([" [warning] " | Msg]).

warning(Format, Args) ->
    error_logger:warning_msg([" [warning] " | Format], Args).

error(Msg) ->
    error_logger:error_msg([" [error] " | Msg]).

error(Format, Args) ->
    error_logger:error_msg([" [error] " | Format], Args).

critical(Msg) ->
    error_logger:error_msg([" [critical] " | Msg]).

critical(Format, Args) ->
    error_logger:error_msg([" [critical] " | Format], Args).



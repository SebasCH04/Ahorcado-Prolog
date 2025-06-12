:- module(main, [run/0]).
:- use_module(game_logic).

%muestra bienvenida y lanza el bucle de juego
run :-
    write('=== ¡Bienvenido al Ahorcado! ==='), nl,
    play_loop.

%ejecuta una partida y pregunta si se quiere jugar de nuevo
play_loop :-
    game_logic:start, %inicia una partida limpia
    prompt_replay.

%pide al usuario si desea reiniciar
prompt_replay :-
    write('Quieres jugar otra vez? (s/n): '), 
    flush_output(current_output),
    read_line_to_string(user_input, Input),
    ( Input = "s" ->
         nl, play_loop
    ;  write('Gracias por jugar!!!'), nl
    ).
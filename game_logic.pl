:- module(game_logic, [start/0]).
:- use_module(palabras).
:- use_module(display).
:- dynamic guessed/1.

%seleccionar el modo de ingreso de la palabra secreta y los intentos a usar
start :-
    retractall(guessed(_)),
    write('Seleccione el modo: '), nl,
    write('1: Palabra secreta aleatoria.'), nl,
    write('2: Ingresar palabra secreta.'), nl,
    flush_output(current_output),
    read_line_to_string(user_input, Input),
    ( Input = "2" ->
         palabras:leer_palabra_secreta(Word)
    ;  palabras:palabra_secreta(Word)
    ),
    atom_chars(Word, Letters),
    % Pregunta si se quiere usar el número predeterminado de intentos (7)
    write('Usar el número de intentos predeterminado (7)? (s/n): '),
    flush_output(current_output),
    read_line_to_string(user_input, UseDefault),
    ( UseDefault = "s" ->
         Attempts = 7
    ;  
         write('Ingrese el número de intentos: '),
         flush_output(current_output),
         read_line_to_string(user_input, AttemptsInput),
         number_string(Attempts, AttemptsInput)
    ),
    play(Letters, [], Attempts).
    
%verifica si todas las letras de la palabra han sido adivinadas
all_guessed(Word, Guessed) :-
    forall(member(L, Word), member(L, Guessed)).
    
%bucle principal: play(+WordChars, +GuessedLetters, +AttemptsLeft)
play(_, _, 0) :- 
    write('Oh no, has perdido, eres muy malo!'), nl.
play(Word, Gs, _) :-
    all_guessed(Word, Gs), !,
    write('Felicidades, adivinaste la palabra secreta!'), nl.
play(Word, Gs, N) :-
    display_state(Word, Gs, N),
    write('Ingrese una letra: '),
    flush_output(current_output),
    read_line_to_string(user_input, LetterInput),
    %asumimos que la entrada es una cadena de un caracter
    string_lower(LetterInput, LowerCase),
    string_chars(LowerCase, [L|_]),
    process_guess(L, Word, Gs, N, Gs2, N2),
    play(Word, Gs2, N2).

%procesa un intento, se agrega el parametro N_in de intentos actuales y N_out de intentos tras el intento
process_guess(L, _, Gs, N, Gs, N) :-
    member(L, Gs), !,
    write('La letra ya fue usada.'), nl.
process_guess(L, Word, Gs, N, [L|Gs], NNew) :-
    \+ member(L, Word), !,
    NNew is N - 1,
    write('Incorrecto! :('), nl.
process_guess(L, _, Gs, N, [L|Gs], N) :-
    write('Correcto! :)'), nl.
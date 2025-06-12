:- module(display, [display_state/3]).
:- use_module(library(lists)).

%display_state(+WordChars, +Guessed, +Attempts)
display_state(W, Gs, N) :-
    maplist(reveal(Gs), W, Out),
    atomic_list_concat(Out, ' ', S),
    write(S), write('   Intentos: '), write(N), nl.

reveal(Gs, C, C)    :- member(C, Gs), !.
reveal(_,  _, '_').
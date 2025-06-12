:- module(palabras, [palabra_secreta/1, leer_palabra_secreta/1]).

%lista de palabras posibles
palabra([
    %animales
    perro, gato, elefante, jirafa, leon, tigre, cebra, mono, delfin, ballena, 
    tiburon, pinguino, aguila, colibri, serpiente, lagarto, rana, tortuga, 
    cocodrilo, caballo, vaca, oveja, cerdo, gallina, pato, abeja, mariposa, 
    escorpion, camello,

    %frutas y vegetales
    manzana, platano, naranja, uva, fresa, sandia, melon, mango, kiwi,
    limon, cereza, durazno, pera, tomate, zanahoria, lechuga, cebolla, papa,
    pepino, calabaza, brocoli, espinaca, ajo, pimiento,

    %tecnologia
    computadora, teclado, mouse, monitor, impresora, internet, algoritmo,
    programa, software, hardware, red, servidor, aplicacion, celular, tablet,
    camara, robot, drone, bateria, circuito, memoria, procesador, disco,

    %deportes
    futbol, baloncesto, tenis, beisbol, natacion, ciclismo, atletismo, boxeo,
    voleibol, hockey, gimnasia, yoga, esgrima, surf, skate, ajedrez, rugby,
    badminton, golf, karate,

    %profesiones
    medico, profesor, ingeniero, abogado, arquitecto, cientifico, artista,
    musico, escritor, cocinero, bombero, policia, astronauta, agricultor,
    veterinario, periodista, programador, contador, psicologo,

    %geografia
    rio, oceano, desierto, bosque, selva, volcan, isla, continente,
    pais, ciudad, pueblo, capital, playa, valle, cascada, lago, delta, península,
    archipielago,

    %objetos cotidianos
    silla, mesa, libro, lapiz, reloj, lampara, ventana, puerta, espejo, cuchara,
    tenedor, vaso, plato, ropa, zapato, sombrero, gafas, maleta, llave, moneda,
    bolsa, cama, almohada, televisor, radio,

    %ciencias
    matematica, fisica, quimica, biologia, astronomia, geologia, ecologia,
    psicologia, sociologia, filosofia, genetica, energia, particula, evolucion,
    experimento, teoria, formula, elemento, molecula, atomo, celula, organismo,

    %transporte
    automovil, bicicleta, avion, tren, barco, autobus, motocicleta, camion,
    helicoptero, submarino, cohete, tranvia, metro, taxi, carroza, carretilla
]).

%selecciona aleatoriamente una palabra de la lista
palabra_secreta(Pal) :-
    palabra(L),
    random_member(Pal, L).

%helper para validar que la palabra contenga solo letras
valid_word(Word) :-
    string_chars(Word, Chars),
    all_letters(Chars).

all_letters([]).
all_letters([H|T]) :-
    char_type(H, alpha),
    all_letters(T).

%lee una palabra de la consola sin mostrar la entrada y valida que solo tenga letras
leer_palabra_secreta(Palabra) :-
    process_create(path(bash), ['-c', 'read -s -p "Ingrese la palabra secreta: " p; echo $p'], [stdout(pipe(Out))]),
    read_line_to_string(Out, TempWord),
    close(Out),
    nl,
    ( valid_word(TempWord) ->
         Palabra = TempWord
    ;   writeln('La palabra ingresada es inválida. Solo se permiten letras.'),
         leer_palabra_secreta(Palabra)
    ).
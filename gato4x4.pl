%==================================================================
% García Tello Axel
% Tarea 6. Gato 4x4
% Construya un agente Prolog para jugar Gato 4x4 contra un oponente
% humano...
% Las reglas son exactamente las mismas que el Gato tradicional; se
% puede ganar alineando cuatro tiros en linea horizontal, vertical o
% sobre las dos diagonales principales...
% Se debe resolver usando Mini Max con podas a-B.
% Muy importante desplegar el tablero al inicio del juego y después
% de cada turno...
%
% Predicados relevantes:
%   valor(<Tablero>,<Valor>).
%   max(<Filas>,<Celdas>,<Tablero>,<Profundidad>,<AEntrada>,
%       <BEntrada>,<Resultado>,<ASalia>,<BSalida>).
%   min(<Filas>,<Celdas>,<Tablero>,<Profundidad>,<AEntrada>,
%       <BEntrada>,<Resultado>,<ASalia>,<BSalida>).
%   iniciar_juego
%==================================================================

%==================================================================
% Base de conocimiento
% profundidad/1.
% Establece la profundidad de las jugadas a evaluar.
%==================================================================

profundidad(5).
:-dynamic(profundidad/1).

%==================================================================
% igual/2.
% Evalua si los 2 objetos ingresados son iguales.
%==================================================================

igual(X,X).

%==================================================================
% gana_x/1.
% Dado el tablero, verifica si "x" ganó el juego.
%==================================================================

gana_x([["x","x","x","x"]|_]).
gana_x([_,["x","x","x","x"]|_]).
gana_x([_,_,["x","x","x","x"]|_]).
gana_x([_,_,_,["x","x","x","x"]]).
gana_x([["x"|_],["x"|_],["x"|_],["x"|_]]).
gana_x([[_,"x"|_],[_,"x"|_],[_,"x"|_],[_,"x"|_]]).
gana_x([[_,_,"x"|_],[_,_,"x"|_],[_,_,"x"|_],[_,_,"x"|_]]).
gana_x([[_,_,_,"x"],[_,_,_,"x"],[_,_,_,"x"],[_,_,_,"x"]]).
gana_x([["x"|_],[_,"x"|_],[_,_,"x"|_],[_,_,_,"x"]]).
gana_x([[_,_,_,"x"],[_,_,"x"|_],[_,"x"|_],["x"|_]]).

%==================================================================
% gana_o/1.
% Dado el tablero, verifica si "o" ganó el juego.
%==================================================================

gana_o([["o","o","o","o"]|_]).
gana_o([_,["o","o","o","o"]|_]).
gana_o([_,_,["o","o","o","o"]|_]).
gana_o([_,_,_,["o","o","o","o"]]).
gana_o([["o"|_],["o"|_],["o"|_],["o"|_]]).
gana_o([[_,"o"|_],[_,"o"|_],[_,"o"|_],[_,"o"|_]]).
gana_o([[_,_,"o"|_],[_,_,"o"|_],[_,_,"o"|_],[_,_,"o"|_]]).
gana_o([[_,_,_,"o"],[_,_,_,"o"],[_,_,_,"o"],[_,_,_,"o"]]).
gana_o([["o"|_],[_,"o"|_],[_,_,"o"|_],[_,_,_,"o"]]).
gana_o([[_,_,_,"o"],[_,_,"o"|_],[_,"o"|_],["o"|_]]).

%==================================================================
% empate/1.
% Dado el tablero, verifica si no existen más jugadas.
%==================================================================

empate(
        [[A1,A2,A3,A4],[B1,B2,B3,B4],[C1,C2,C3,C4],[D1,D2,D3,D4]]
    ):- \+ A1 =:= " ", \+ A2 =:= " ", \+ A3 =:= " ", \+ A4 =:= " ",
        \+ B1 =:= " ", \+ B2 =:= " ", \+ B3 =:= " ", \+ B4 =:= " ",
        \+ C1 =:= " ", \+ C2 =:= " ", \+ C3 =:= " ", \+ C4 =:= " ",
        \+ D1 =:= " ", \+ D2 =:= " ", \+ D3 =:= " ", \+ D4 =:= " ".

%==================================================================
% imprimir_tablero/1.
% Imprime el tablero ingresado.
%==================================================================

imprimir_tablero(
        [[A1,A2,A3,A4],[B1,B2,B3,B4],[C1,C2,C3,C4],[D1,D2,D3,D4]]
    ):- write("  1 2 3 4\n"),
        write("  -+-+-+-\n"),
        write("a "),write(A1),write("|"),write(A2),write("|"),
            write(A3),write("|"),write(A4),write("\n"),
        write("  -+-+-+-\n"),
        write("b "),write(B1),write("|"),write(B2),write("|"),
            write(B3),write("|"),write(B4),write("\n"),
        write("  -+-+-+-\n"),
        write("c "),write(C1),write("|"),write(C2),write("|"),
            write(C3),write("|"),write(C4),write("\n"),
        write("  -+-+-+-\n"),
        write("d "),write(D1),write("|"),write(D2),write("|"),
            write(D3),write("|"),write(D4),write("\n"),
        write("  -+-+-+-\n").

%==================================================================
% jugada/4.
% Dadas las coordenadas en el tablero y el tablero de juego, nos
% devuelve un nuevo tablero con la jugada de "o".
%==================================================================

jugada(1,a,[[Anterior|Rest]|Resto],            [["o"|Rest]|Resto]):-             Anterior =:= " ".
jugada(2,a,[[A1,Anterior|Rest]|Resto],         [[A1,"o"|Rest]|Resto]):-          Anterior =:= " ".
jugada(3,a,[[A1,A2,Anterior|Rest]|Resto],      [[A1,A2,"o"|Rest]|Resto]):-       Anterior =:= " ".
jugada(4,a,[[A1,A2,A3,Anterior]|Resto],        [[A1,A2,A3,"o"]|Resto]):-         Anterior =:= " ".

jugada(1,b,[L1,[Anterior|Rest]|Resto],         [L1,["o"|Rest]|Resto]):-          Anterior =:= " ".
jugada(2,b,[L1,[A1,Anterior|Rest]|Resto],      [L1,[A1,"o"|Rest]|Resto]):-       Anterior =:= " ".
jugada(3,b,[L1,[A1,A2,Anterior|Rest]|Resto],   [L1,[A1,A2,"o"|Rest]|Resto]):-    Anterior =:= " ".
jugada(4,b,[L1,[A1,A2,A3,Anterior]|Resto],     [L1,[A1,A2,A3,"o"]|Resto]):-      Anterior =:= " ".

jugada(1,c,[L1,L2,[Anterior|Rest]|Resto],      [L1,L2,["o"|Rest]|Resto]):-       Anterior =:= " ".
jugada(2,c,[L1,L2,[A1,Anterior|Rest]|Resto],   [L1,L2,[A1,"o"|Rest]|Resto]):-    Anterior =:= " ".
jugada(3,c,[L1,L2,[A1,A2,Anterior|Rest]|Resto],[L1,L2,[A1,A2,"o"|Rest]|Resto]):- Anterior =:= " ".
jugada(4,c,[L1,L2,[A1,A2,A3,Anterior]|Resto],  [L1,L2,[A1,A2,A3,"o"]|Resto]):-   Anterior =:= " ".

jugada(1,d,[L1,L2,L3,[Anterior|Rest]],         [L1,L2,L3,["o"|Rest]]):-          Anterior =:= " ".
jugada(2,d,[L1,L2,L3,[A1,Anterior|Rest]],      [L1,L2,L3,[A1,"o"|Rest]]):-       Anterior =:= " ".
jugada(3,d,[L1,L2,L3,[A1,A2,Anterior|Rest]],   [L1,L2,L3,[A1,A2,"o"|Rest]]):-    Anterior =:= " ".
jugada(4,d,[L1,L2,L3,[A1,A2,A3,Anterior]],     [L1,L2,L3,[A1,A2,A3,"o"]]):-      Anterior =:= " ".

%==================================================================
% mi_valor/2.
% Dado un tablero de juego, establece cuantas lineas de gane tiene
% nuestro agente jugador.
%==================================================================

mi_valor(
        [[A1,A2,A3,A4],[B1,B2,B3,B4],[C1,C2,C3,C4],[D1,D2,D3,D4]],
        Valor
    ):- V1 is 0,
        (
            (A1 =:= "o"; A2 =:= "o"; A3 =:= "o"; A4 =:= "o") ->
                V2 is V1+0;
                V2 is V1+1
        ),
        (
            (B1 =:= "o"; B2 =:= "o"; B3 =:= "o"; B4 =:= "o") ->
                V3 is V2+0;
                V3 is V2+1
        ),
        (
            (C1 =:= "o"; C2 =:= "o"; C3 =:= "o"; C4 =:= "o") ->
                V4 is V3+0;
                V4 is V3+1
        ),
        (
            (D1 =:= "o"; D2 =:= "o"; D3 =:= "o"; D4 =:= "o") ->
                V5 is V4+0;
                V5 is V4+1
        ),
        (
            (A1 =:= "o"; B1 =:= "o"; C1 =:= "o"; D1 =:= "o") ->
                V6 is V5+0;
                V6 is V5+1
        ),
        (
            (A2 =:= "o"; B2 =:= "o"; C2 =:= "o"; D2 =:= "o") ->
                V7 is V6+0;
                V7 is V6+1
        ),
        (
            (A3 =:= "o"; B3 =:= "o"; C3 =:= "o"; D3 =:= "o") ->
                V8 is V7+0;
                V8 is V7+1
        ),
        (
            (A4 =:= "o"; B4 =:= "o"; C4 =:= "o"; D4 =:= "o") ->
                V9 is V8+0;
                V9 is V8+1
        ),
        (
            (A1 =:= "o"; B2 =:= "o"; C3 =:= "o"; D4 =:= "o") ->
                V10 is V9+0;
                V10 is V9+1
        ),
        (
            (A4 =:= "o"; B3 =:= "o"; C2 =:= "o"; D1 =:= "o") ->
                V11 is V10+0;
                V11 is V10+1
        ),
        Valor is V11.

%==================================================================
% valor_oponente/2.
% Dado un tablero de juego, establece cuantas lineas de juego
% tienen nuestro oponente (humano).
%==================================================================

valor_oponente(
        [[A1,A2,A3,A4],[B1,B2,B3,B4],[C1,C2,C3,C4],[D1,D2,D3,D4]],
        Valor
    ):- V1 is 0,
        (
            (A1 =:= "x"; A2 =:= "x"; A3 =:= "x"; A4 =:= "x") ->
                V2 is V1+0;
                V2 is V1+1
        ),
        (
            (B1 =:= "x"; B2 =:= "x"; B3 =:= "x"; B4 =:= "x") ->
                V3 is V2+0;
                V3 is V2+1
        ),
        (
            (C1 =:= "x"; C2 =:= "x"; C3 =:= "x"; C4 =:= "x") ->
                V4 is V3+0;
                V4 is V3+1
        ),
        (
            (D1 =:= "x"; D2 =:= "x"; D3 =:= "x"; D4 =:= "x") ->
                V5 is V4+0;
                V5 is V4+1
        ),
        (
            (A1 =:= "x"; B1 =:= "x"; C1 =:= "x"; D1 =:= "x") ->
                V6 is V5+0;
                V6 is V5+1
        ),
        (
            (A2 =:= "x"; B2 =:= "x"; C2 =:= "x"; D2 =:= "x") ->
                V7 is V6+0;
                V7 is V6+1
        ),
        (
            (A3 =:= "x"; B3 =:= "x"; C3 =:= "x"; D3 =:= "x") ->
                V8 is V7+0;
                V8 is V7+1
        ),
        (
            (A4 =:= "x"; B4 =:= "x"; C4 =:= "x"; D4 =:= "x") ->
                V9 is V8+0;
                V9 is V8+1
        ),
        (
            (A1 =:= "x"; B2 =:= "x"; C3 =:= "x"; D4 =:= "x") ->
                V10 is V9+0;
                V10 is V9+1
        ),
        (
            (A4 =:= "x"; B3 =:= "x"; C2 =:= "x"; D1 =:= "x") ->
                V11 is V10+0;
                V11 is V10+1
        ),
        Valor is V11.

%==================================================================
% valor/2.
% Dado un tablero nos devuelve un valor de juego de este,
% desde el punto de vista del agente jugador.
%==================================================================

valor(Tablero,Valor):- mi_valor(Tablero,MV),
                       valor_oponente(Tablero,VO),
                       Valor is MV-VO.

%==================================================================
% max/9.
% Analiza las jugadas cuando el agente jugador tiene el turno.
% El primer parámetro son las filas ya analizadas de la jugada.
% El segundo parámetro son las celdas de juego ya analizadas.
% El tercer parámetro son las es el resto del tablero sin
% analizar.
% El cuarto parámetro es la profundidad en la que se esta
% ubicada la jugada.
% El quinto y sexto parámetro son las podas a y B de entradas.
% El septimo parámetro es la jugada mejor analizada.
% Y los últimos dos parámetros son las podas a y B de salida.
%==================================================================

max(Filas,Celdas,[[C|RC]|RJ],Prof,AE,BE,Res,AS,BS):- (
        C =:= " " ->
        (
            append(Celdas,["x"|RC],NC),
            append(Filas,[NC|RJ],Res1),
            (
                (
                    gana_x(Res1) ->
                    (
                        Valor1 is 15
                    );
                    (
                        empate(Res1) ->
                        (
                            Valor1 is 0
                        );
                        (
                            profundidad(Prof) ->
                            (
                                valor(Res1,Valor1)
                            );
                            (
                                Prof2 is Prof + 1,
                                min([],[],Res1,Prof2,AE,BE,_,_,Valor1)
                            )
                        )
                    )
                ),
                (
                    (
                        Valor1 > AE ->
                            A is Valor1
                        ;
                            A is AE
                    ),
                    (
                        A > BE ->
                        (
                            AS is A,
                            BS is BE,
                            igual(Res1,Res)
                        )
                        ;
                        (
                            igual(RC,[]) ->
                            (
                                igual(RJ,[]) ->
                                (
                                    AS is AE,
                                    BS is BE
                                );
                                (
                                    append(Celdas,[C],NCeldas),
                                    append(Filas,[NCeldas],NFilas),
                                    max(NFilas,[],RJ,Prof,A,BE,Res2,Valor2,_),
                                    (
                                        Valor2 > A ->
                                        (
                                            AS is Valor2,
                                            BS is BE,
                                            igual(Res2,Res)
                                        );
                                        (
                                            AS is A,
                                            BS is BE,
                                            igual(Res1,Res)
                                        )
                                    )
                                )
                            );
                            (
                                append(Celdas,[C],NCeldas),
                                max(Filas,NCeldas,[RC|RJ],Prof,A,BE,Res3,Valor3,_),
                                (
                                    Valor3 > A ->
                                    (
                                        AS is Valor3,
                                        BS is BE,
                                        igual(Res3,Res)
                                    );
                                    (
                                        AS is A,
                                        BS is BE,
                                        igual(Res1,Res)
                                    )
                                )
                            )
                        )
                    )
                )
            )
        );
        (
            igual(RC,[]) ->
            (
                igual(RJ,[]) ->
                (
                    AS is AE,
                    BS is BE
                );
                (
                    append(Celdas,[C],NCeldas),
                    append(Filas,[NCeldas],NFilas),
                    max(NFilas,[],RJ,Prof,AE,BE,Res,AS,BS)
                )
            );
            (
                append(Celdas,[C],NCeldas),
                max(Filas,NCeldas,[RC|RJ],Prof,AE,BE,Res,AS,BS)
            )
        )
    ),!.


%==================================================================
% min/9.
% Analiza las jugadas cuando el humano tiene el turno.
% El primer parámetro son las filas ya analizadas de la jugada.
% El segundo parámetro son las celdas de juego ya analizadas.
% El tercer parámetro son las es el resto del tablero sin
% analizar.
% El cuarto parámetro es la profundidad en la que se esta
% ubicada la jugada.
% El quinto y sexto parámetro son las podas a y B de entradas.
% El septimo parámetro es la jugada mejor analizada.
% Y los últimos dos parámetros son las podas a y B de salida.
%==================================================================

min(Filas,Celdas,[[C|RC]|RJ],Prof,AE,BE,Res,AS,BS):- (
        C =:= " " ->
        (
            append(Celdas,["o"|RC],NC),
            append(Filas,[NC|RJ],Res1),
            (
                (
                    gana_o(Res1) ->
                    (
                        Valor1 is -15
                    );
                    (
                        empate(Res1) ->
                        (
                            Valor1 is 0
                        );
                        (
                            profundidad(Prof) ->
                            (
                                valor(Res1,Valor1)
                            );
                            (
                                Prof2 is Prof + 1,
                                max([],[],Res1,Prof2,AE,BE,_,Valor1,_)
                            )
                        )
                    )
                ),
                (
                    Valor1 < BE ->
                        B is Valor1
                    ;
                        B is BE
                ),
                (
                    B < AE ->
                    (
                        BS is B,
                        AS is AE,
                        igual(Res1,Res)
                    )
                    ;
                    (
                        igual(RC,[]) ->
                        (
                            igual(RJ,[]) ->
                            (
                                AS is AE,
                                BS is BE
                            );
                            (
                                append(Celdas,[C],NCeldas),
                                append(Filas,[NCeldas],NFilas),
                                min(NFilas,[],RJ,Prof,AE,B,Res2,_,Valor2),
                                (
                                    Valor2 < B ->
                                    (
                                        BS is Valor2,
                                        AS is AE,
                                        igual(Res2,Res)
                                    );
                                    (
                                        BS is B,
                                        AS is AE,
                                        igual(Res1,Res)
                                    )
                                )
                            )
                        );
                        (
                            append(Celdas,[C],NCeldas),
                            min(Filas,NCeldas,[RC|RJ],Prof,AE,B,Res3,_,Valor3),
                            (
                                Valor3 < B ->
                                (
                                    BS is Valor3,
                                    AS is AE,
                                    igual(Res3,Res)
                                );
                                (
                                    BS is B,
                                    AS is AE,
                                    igual(Res1,Res)
                                )
                            )
                        )
                    )
                )
            )
        );
        (
            igual(RC,[]) ->
            (
                igual(RJ,[]) ->
                (
                    AS is AE,
                    BS is BE
                );
                (
                    append(Celdas,[C],NCeldas),
                    append(Filas,[NCeldas],NFilas),
                    min(NFilas,[],RJ,Prof,AE,BE,Res,AS,BS)
                )
            );
            (
                append(Celdas,[C],NCeldas),
                min(Filas,NCeldas,[RC|RJ],Prof,AE,BE,Res,AS,BS)
            )
        )
    ),!.

%==================================================================
% jugar/2. Version "o".
% Inicia la jugada del jugador "o" a partir del tablero ingresado.
%==================================================================

jugar("o",Tablero):- write("Turno de o\n"),
                     write("Escribe el número de la casilla\n"),
                     read(Numero),
                     write("Escribe la letra de la casilla\n"),
                     read(Letra),
                     (
                        jugada(Numero,Letra,Tablero,NTablero) ->
                        (
                            imprimir_tablero(NTablero),
                            (
                                (
                                 gana_x(NTablero);
                                 gana_o(NTablero);
                                 empate(NTablero)
                                ) ->
                                        write("Fin del juego\n");
                                        jugar("x",NTablero)
                            )
                        );
                        (
                            write("Jugada incorrecta\n"),
                            jugar("o",Tablero)
                        )
                     ).

%==================================================================
% jugar/2. Version "x".
% Inicia la jugada nuestro agente jugador "x" a partir del tablero
% ingresado.
%==================================================================

jugar("x",Tablero):- write("Turno de x\n"),
                     max([],[],Tablero,1,-100,100,NTablero,_,_),
                     imprimir_tablero(NTablero),
                     (
                        (
                         gana_x(NTablero);
                         gana_o(NTablero);
                         empate(NTablero)
                        ) ->
                            write("Fin del juego\n");
                            jugar("o",NTablero)
                     ).

%==================================================================
% iniciar_juego/0.
% Inicia el juego de gato.
%==================================================================

iniciar_juego():- imprimir_tablero(
                    [[" "," "," "," "],
                    [" "," "," "," "],
                    [" "," "," "," "],
                    [" "," "," "," "]]
                  ),
                  jugar(
                    "o",
                    [[" "," "," "," "],
                    [" "," "," "," "],
                    [" "," "," "," "],
                    [" "," "," "," "]]
                  ).

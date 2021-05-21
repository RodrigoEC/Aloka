clear :- writeln('\e[H\e[2J').

le_arquivo(Path, Linhas) :-
    open(Path, read, File),
    read_file(File, Linhas),
    close(File).

escreve_lista([]).
escreve_lista([Cabeca|Corpo]) :-
    writeln(Cabeca),
    escreve_lista(Corpo).

read_file(Stream,[]) :- at_end_of_stream(Stream).
read_file(Stream,[X | L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    read_file(Stream, L).

cria_animacao([]).
cria_animacao([NomeArquivo|Resto]) :-
    clear,
    concat_atom(['./arquivos/', NomeArquivo, '.txt'], Path),
    le_arquivo(Path, Linhas),
    escreve_lista(Linhas),
    sleep(0.3),
    cria_animacao(Resto).
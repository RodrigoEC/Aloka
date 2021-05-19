
% Le o arquivo .csv e retorna uma lista de listas, cada lista é uma entidae
% ex: [[Cpf1, Nome1, Telefone1, Endereco1], [Cpf2, Nome2, Telefone2, Endereco2]].
lerCsvRowList(Arquivo,Lists):-
    atom_concat('../arquivos/', Arquivo, Path),
    csv_read_file(Path, Rows, []),
    rows_to_lists(Rows, Lists).

rows_to_lists(Rows, Lists):- maplist(row_to_list, Rows, Lists).

row_to_list(Row, List):-
    Row =.. [row|List].

% Método utilitário que retorna um elemento por seu indice
elementByIndex(0, [H|_], H):- !.
elementByIndex(I, [_|T], E):- X is I - 1, elementByIndex(X, T, E).

% Verifica se a entidade está na lista, a partir do identificador unico
verificaNaLista(_,[], false).
verificaNaLista(SearchedId, [H|T]) :-
     (member(SearchedId, H) -> true
     ;verificaNaLista(SearchedId, T)).

% Pega a lista que representa a entidade na lista de entidades a partir o identificador unico
pegaEntidade(_, [Entidade|_], Entidade):- !.
pegaEntidade(SearchedId, [H|T], Entidade) :-
    (member(SearchedId, H) -> H;
    pegaEntidade(SearchedId, T, Entidade)).
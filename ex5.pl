:- module('ex5',
        [author/2,
         genre/2,
         book/4
        ]).

/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).
:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).



author(1, "Isaac Asimov").
author(2, "Frank Herbert").
author(3, "William Morris").
author(4, "J.R.R Tolkein").


genre(1, "Science").
genre(2, "Literature").
genre(3, "Science Fiction").
genre(4, "Fantasy").

book("Inside The Atom", 1, 1, 500).
book("Asimov's Guide To Shakespeare", 1, 2, 400).
book("I, Robot", 1, 3, 450).
book("Dune", 2, 3, 550).
book("The Well at the World's End", 3, 4, 400).
book("The Hobbit", 4, 4, 250).
book("The Lord of the Rings", 4, 4, 1250).

% You can add more facts.
% Fill in the Purpose, Signature as requested in the instructions here

% Signature: authorOfGenre(GenreName, AuthorName)/2
% Purpose: true if an author by the name {AuthorName} has written a book belonging to the genre named {GenreName}
authorOfGenre(GenreName, AuthorName) :-
    	genre(GenreId, GenreName),                              %1
    	author(AuthorId, AuthorName),                           %2
    	book(_X, AuthorId, GenreId, _Y).                        %3

% Signature: longestBook(AuthorId, BookName)/2
% Purpose:  true if the longest book that an author with the ID {AuthorId} has written in titled {BookName}
longestBook(AuthorId, BookName) :-
        book(BookName, AuthorId, _X, BookLength),               %1
        not(authorLongerBook(AuthorId, BookLength)).            %2

% Signature: versatileAuthor(AuthorName)/1
% Purpose: true if an author by the name {AuthorName} has written books in at least three different genres
versatileAuthor(AuthorName) :-
        author(AuthorId, AuthorName),                           %1
        book(_NameOne, AuthorId, Genre_1, _SizeOne),            %2
        book(_NameTwo, AuthorId, Genre_2, _SizeTwo),            %3
        book(_NameThree, AuthorId, Genre_3, _SizeThree),        %4
        checkIfGenreDiff(Genre_1, Genre_2, Genre_3).            %5


% Signature: authorLongerBook(AuthorId, PrevBookSize)/2
% Purpose: true if an author by the id {AuthorId} has a longer book
authorLongerBook(AuthorId, PrevBookSize) :-
        book(_X, AuthorId, _Y, CurrBookSize),                   %1
        (CurrBookSize > PrevBookSize).                          %2


% Signature: checkIfGenreDiff(Genre_1, Genre_2, Genre_3)/3
% Purpose: true if all genre ids {Genre_1}, {Genre_2} & {Genre_3} are different
checkIfGenreDiff(Genre_1, Genre_2, Genre_3) :-
        (Genre_1 =\= Genre_2),                                  %1                     
        (Genre_2 =\= Genre_3),                                  %2
        (Genre_3 =\= Genre_1).                                  %3



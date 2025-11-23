% ---------------------------------------------
% Medical Diagnosis Expert System (Working Version)
% ---------------------------------------------

:- dynamic symptom/1.

% Disease rules
has_disease(flu) :-
    symptom(fever),
    symptom(headache),
    symptom(body_ache),
    symptom(cough).

has_disease(cold) :-
    symptom(sneezing),
    symptom(runny_nose),
    symptom(sore_throat).

has_disease(covid19) :-
    symptom(fever),
    symptom(cough),
    symptom(loss_of_taste),
    symptom(shortness_of_breath).

has_disease(migraine) :-
    symptom(headache),
    symptom(nausea),
    symptom(light_sensitivity).

% Diagnose after all symptoms are collected
diagnose(Disease) :-
    has_disease(Disease),
    !.

% Ask user about symptoms (no failure)
ask_symptom(S) :-
    write('Do you have '), write(S), write('? (yes/no): '),
    read(Reply),
    (Reply == yes -> assert(symptom(S)) ; true).

% Ask all symptoms
ask_all([]).
ask_all([H|T]) :-
    ask_symptom(H),
    ask_all(T).

% Entry point
start :-
    retractall(symptom(_)),             % clear old symptoms
    nl, write('--- Medical Diagnosis System ---'), nl,

    Symptoms = [fever, headache, body_ache, cough,
                sneezing, runny_nose, sore_throat,
                loss_of_taste, shortness_of_breath,
                nausea, light_sensitivity],

    ask_all(Symptoms),

    (   diagnose(D)
    ->  nl, write('Possible diagnosis: '), write(D), nl
    ;   nl, write('No matching condition found.'), nl
    ).

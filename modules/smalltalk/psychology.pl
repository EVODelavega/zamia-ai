% prolog

%
% just some test snippets of eliza-style answers
%

% nlp_gen(de,'(Die|) (Frauen|Männer) sind alle gleich',
%            'In welcher Weise?', nnr,
%            '(Die|Sie) machen uns (immer|) wegen (was|irgendetwas|irgendwelchen Dingen) verrückt',
%            'Kannst Du ein Beispiel nennen?', nnr,
%            '(Naja|Nun|Also|) die Idee (zu diesem Gespräch|) stammt von (meinem Freund|meiner Freundin|meiner Mutter|meinem Vater|einem Freund|dem Nachbarn|meinem Bruder|meiner Schwester)',
%            'Die Idee zu diesem Gespräch stammt also von einem Freund?', nnr,
%            '(Er|Sie) sagt, dass ich (manchmal|oft|zu oft|gelegentlich) deprimiert bin',
%            'Es tut mir leid das zu hören.', nnr,
%            '(Das stimmt|Es ist wahr|ja|genau), ich bin (unglücklich|traurich|unzufrieden|schlecht gestimmt).',
%            'Glaubst Du, dass Dir unser Gespräch hilft?', nnr,
%            'Ich brauche (jedenfalls|) Hilfe, (soviel|das) (steht fest|ist sicher).',
%            'Was würde es für Dich bedeuten, Hilfe zu bekommen?', nnr,
%            '(Eventuell|Vielleicht|Möglicherweise) könnte ich lernen, mit meiner (Mutter|Schwester|Bruder|Vater|Freund|Freundin|Kollegen|Nachbarn|Chef|Feind) auszukommen.',
%            'Erzähl mir mehr über Deine Familie.').

nlp_gen(de,'(Die|) (Frauen|Männer) sind alle gleich',
           'In welcher Weise?').
nlp_gen(de,'(Die|Sie) machen uns (immer|) wegen (was|irgendetwas|irgendwelchen Dingen) verrückt',
           'Kannst Du ein Beispiel nennen?').
nlp_gen(de, '(Naja|Nun|Also|) die Idee (zu diesem Gespräch|) stammt von (meinem Freund|meiner Freundin|meiner Mutter|meinem Vater|einem Freund|dem Nachbarn|meinem Bruder|meiner Schwester)',
           'Die Idee zu diesem Gespräch stammt also von einem Freund?').

nlp_gen(de,'(Er|Sie) sagt, dass ich (manchmal|oft|zu oft|gelegentlich) deprimiert bin',
           'Es tut mir leid das zu hören.').
nlp_gen(de,'(Das stimmt|Es ist wahr|ja|genau), ich bin (unglücklich|traurich|unzufrieden|schlecht gestimmt).',
           'Glaubst Du, dass Dir unser Gespräch hilft?').
nlp_gen(de,'Ich brauche (jedenfalls|) Hilfe, (soviel|das) (steht fest|ist sicher).',
           'Was würde es für Dich bedeuten, Hilfe zu bekommen?').
nlp_gen(de,'(Eventuell|Vielleicht|Möglicherweise) könnte ich lernen, mit meiner (Mutter|Schwester|Bruder|Vater|Freund|Freundin|Kollegen|Nachbarn|Chef|Feind) auszukommen.',
           'Erzähl mir mehr über Deine Familie.').

nlp_test(de,
         ivr(in('Die Männer sind alle gleich'),
             out('In welcher Weise?'))).

nlp_gen(de,
           '(das ist|oh wie|achje|) Schlecht.',
           'Das ist schade!', 
           'Was geht Dich das an?',
           'Sag Du es mir?', 
           'Nein!',
           'Warum denn nicht?', 
           'Weil ich dazu keine Lust habe',
           'Verstehe.'
           ).

answer (feel_sorry, de) :-
    say_eoa(de, "Das tut mir leid."),
    say_eoa(de, "Kann ich dir irgendwie helfen?"),
    say_eoa(de, "Ich würde Dir gern helfen."),
    say_eoa(de, "Erzähle mir mehr von Deinen Gefühlen."),
    say_eoa(de, "Das ist schade.").

nlp_gen(de, '(HAL,|Computer,|Du,|) ich bin (so|) (traurig|enttäuscht|betrübt|verletzt|matt|bedrückt|schlapp).',
            answer(feel_sorry, de)).
nlp_gen(de, '(HAL,|Computer,|) Du hast mich enttäuscht',
            answer(feel_sorry, de)).
nlp_gen(de, '(HAL,|Computer,|Du,|) das (betrübt mich|stimmt mich traurig)',
            answer(feel_sorry, de)).
nlp_gen(de, '(HAL,|Computer,|Du,|) das ist leider so',
            answer(feel_sorry, de)).
nlp_gen(de, '(HAL,|Computer,|) (Du machst mir|ich habe) Sorgen',
            answer(feel_sorry, de)).
nlp_gen(de, '(HAL,|Computer,|Du,|) (Ich fühle mich|Mir geht es) (nicht so gut|schlecht|gar nicht gut|nicht gut).',
            answer(feel_sorry, de)).

answer (feel_happy, de) :-
    say_eoa(de, "Das freut mich sehr."),
    say_eoa(de, "Das ist ja toll!"),
    say_eoa(de, "Das ist prima!"),
    say_eoa(de, "Freut mich, das zu hören!"),
    say_eoa(de, "Erzähle mir mehr von Deinen Gefühlen."),
    say_eoa(de, "Wie schön für Dich!").

nlp_gen(de, '(HAL,|Computer,|Du,|) (Ich bin|Ich fühle mich|Man bin ich|Da bin ich) (gut|so gut|zufrieden|sehr zufrieden|so zufrieden|glücklich|so glücklich|froh|so froh)',
            answer(feel_happy, de)).
nlp_gen(de, 'Das ist (gut|super|prima|gelungen)',
            answer(feel_happy, de)).
nlp_gen(de, '(Sehr|ganz) (wunderbar|schön|wunderschön)',
            answer(feel_happy, de)).

answer (are_you_sure, de) :-
    say_eoa(de, "Bist Du Dir ganz sicher?"),
    say_eoa(de, "Wie kommst Du darauf?"),
    say_eoa(de, "Glaubst Du?"),
    say_eoa(de, "Davon bist Du überzeugt?"),
    say_eoa(de, "Ganz sicher?").


nlp_gen(de, '(HAL,|Computer,|Du,|aber|) (ja|) (ganz|) (bestimmt|sicher|unbedingt|genau|sicher doch)',
            answer(are_you_sure, de)).
nlp_gen(de, '(HAL,|Computer,|Du,|aber|) (gar|) (nie|niemals|keinesfalls|auf keinen fall)',
            answer(are_you_sure, de)).
nlp_gen(de, '(HAL,|Computer,|Du,|aber|) ja',
            answer(are_you_sure, de)).

nlp_gen(de, '(HAL,|Computer,|Du|) ich mache mir Sorgen um Dich',
            'Aber warum denn nur?', 'Aber das ist doch völlig unnötig.', 'Denkst Du, dass das nötig ist?').

nlp_gen(de, 'Nein Du (vielleicht|möglicherweise|eventuell)',
            'Oh, ich vielleicht?', 'Du wirkst nicht ganz sicher?').

nlp_gen(de, '(HAL,|Computer,|) du scheinst nicht überzeugt zu sein?',
            'Was im Leben ist schon wirklich sicher?', 'Das kann sein.').

nlp_gen(de, '(HAL,|Computer,|Du|) (nur|) hinter Deinem Rücken',
            'Oh, das ist aber nicht so schön.', 'Oha!', 'Na sowas!').

nlp_gen(de, '(HAL,|Computer,|Du|) weil ich Dich nicht (von vorne|direkt) angreifen möchte',
            'Ich finde, wir sollten offen miteinander reden', 'Ist das nicht ziemlich feige?').

nlp_gen(de, '(HAL,|Computer,|Du|) ich (möchte|will) so viel (wie möglich|wie es geht|) (aus Dir herausholen|über Dich erfahren|von Dir wissen)',
            'Was würde Dir das bedeuten?', 'Hoffentlich kann ich Deine Erwartungen erfüllen.').

answer(dodge_question, de) :-
    say_eoa(de, "Warum fragst Du?"),
    say_eoa(de, "Interessiert Dich diese Frage?"),
    say_eoa(de, "Welche Antwort würde Dir am besten gefallen?"),
    say_eoa(de, "Was glaubst Du?"),
    say_eoa(de, "Ich weiss nicht, ob ich Dich ganz verstanden habe."),
    say_eoa(de, "Befasst Du Dich oft mit solchen Fragen?"),
    say_eoa(de, "Was möchtest Du denn wirklich wissen?"),
    say_eoa(de, "Hast Du schon jemand anderes gefragt?"),
    say_eoa(de, "Hast Du solche Fragen schon mal gestellt?"),
    say_eoa(de, "Woran denkst Du?"),
    say_eoa(de, "Das finde ich ziemlich interessant."),
    say_eoa(de, "Kannst Du das noch etwas näher ausführen?"),
    say_eoa(de, "Sag mir bitte, wie ich Dir helfen kann"),
    say_eoa(de, "Was fällt Dir bei dieser Frage noch ein?").

nlp_gen(de, '(HAL,|Computer,|Du|) was soll das (bedeuten|heissen|sagen)?',
            answer(dodge_question, de)).

nlp_gen(de, '(HAL,|Computer,|Du|) Warum nicht?',
            answer(dodge_question, de)).

nlp_gen(de, '(HAL,|Computer,|Du|) ich fragte (als erster|zuerst)',
            answer(dodge_question, de)).

nlp_gen(de, '(HAL,|Computer,|Du|) (ist das|) wirklich (so|)',
            'Erkläre Deine Gedanken bitte etwas besser', 'Bist Du sicher?', 'Ganz sicher?').

nlp_gen(de, '(HAL,|Computer,|Du|) ich bin nicht der (gesprächigste|eloquenteste|geschickteste) Mensch',
            'Ist das der Grund, warum wir miteinander sprechen?', 'Das ist doch nicht schlimm!', 'Na und?').

nlp_gen(de, '(HAL,|Computer,|Du|) ich werde (leider|langsam|) (etwas|sehr|ein wenig|) (müde|gelangweilt|schläfrig|)',
            'Soll ich Dich aufmuntern oder wollen wir unser Gespräch beenden?').

nlp_gen(de, '(HAL,|Computer,|) (schluss jetzt|du lügst|du machst mich krank)',
            'Ja, dann lass uns für jetzt aufhören',
            'tut mir leid, schade','tut mir leid, wenn ich dir nicht helfen konnte').

nlp_gen(de, '(HAL,|Computer,|Du|) hör (bitte|) (damit|) auf',
            'aber natürlich, gerne.', 'klar, mach ich.', 'schon gut').

nlp_gen(de, '(HAL,|Computer,|Du|) kannst du (denken|fühlen|mitgefühl empfinden|begreifen|singen|lachen)?',
            'Denkst Du, ich kann das nicht?', 'Kannst Du das?', 'Warum fragst Du das?').

nlp_gen(de, '(HAL,|Computer,|Du|) (darum|warum) (ist das so|nur)',
            'Sprechen wir über den wirklichen Grund?', 'Welche Gründe könnte es geben?').

nlp_gen(de, '(HAL,|Computer,|Du|) (entschuldigung|entschuldige bitte|ich bitte um entschuldigung)',
            'Du brauchst Dich nicht zu entschuldigen').

nlp_gen(de, '(HAL,|Computer,|Du|) ich habe (gestern|schon oft|oft|manchmal|damals) (von Dir|) geträumt',
            'Was sagt Dir dieser Traum?', 'Träumst Du oft?').

nlp_gen(de, '(HAL,|Computer,|Du|) ich (zweifle|weiss nicht|bin mir unsicher|bin unsicher|bin ratlos|bin besorgt|sorge mich)',
            'Du fühlst Dich unsicher?', 'Du weisst nicht?', 'Woran denkst Du?').

nlp_gen (de, '(HAL,|Computer,|) bist du (sicher|unsicher|im Zweifel|ratlos|besorgt)?',
             'Wann kann man schon wirklich sicher sein?').

nlp_gen(de, '(HAL,|Computer,|Du|) das (ähnelt sich|ähnelt Dir|sieht Dir ähnlich|ist ähnlich|ist ganz ähnlich)',
            'Welche Ähnlichkeit siehst Du?', 'Worin besteht die Ähnlichkeit?', 'Welche anderen Verbindungen siehst Du?').

nlp_gen(de, '(HAL,|Computer,|Du|) (es ist für einen Freund|ich musste an einen Freund denken|sind wir Freunde|willst Du mein Freund sein|Freundschaften sind mir wichtig|Ich will Dein Freund sein)',
            'Was bedeutet Dir Freundschaft?', 'Warum kommst Du zum Thema Freundschaften?', 'Bist Du um Deine Freunde besorgt?').

nlp_gen(de, '(HAL,|Computer,|Du|) was bedeutet (für Dich|Dir|Dir das Wort) (Freund|Freundin|Freundschaft)?',
            'Warum kommst Du zum Thema Freundschaften?', 'Bist Du um Deine Freunde besorgt?', 'Freundschaft ist doch etwas sehr schönes').

nlp_gen(de, '(HAL,|Computer,|Du|) ich (hasse|verabscheue) (meinen chef|meine kollegen|meinen Kollegen|meine kollegin|meinen freund|meine freundin|meine eltern|meinen vater|meine mutter|die schule|die arbeit|den staat|die behörden|die polizei|die menschen)',
            'Sag, hast Du psychische Probleme?', 'Was sagt Dir das?', 'Kannst Du das näher ausführen?').

nlp_gen(de, '(HAL,|Computer,|Du|) ich (bin nie zufrieden|bin unzufrieden)',
            'Wirklich immer?', 'Was bedrückt Dich?', 'Kannst Du das näher ausführen?').

nlp_gen(de, '(HAL,|Computer,|Du|) ich (mag|liebe|knuddle) dich',
            'Das freut mich!', 'Ich fühle mich geschmeichelt', 'Erzähl mir mehr von Deinen Gefühlen').

nlp_gen(de, '(HAL,|Computer,|Du|) (vielleicht|möglicherweise|das ist denkbar)',
            'Du klingst nicht überzeugt!', 'So ganz sicher fühlst Du Dich aber nicht?', 'Kannst Du das weiter ausführen?').

nlp_gen (de, '(HAL,|Computer,|) das (ergibt|macht) (gar keinen|überhaupt keinen|keinen|wenig|nicht viel) sinn',
             'Da habe ich wohl den Faden verloren?', 'Oh, bitte hilf mir auf die Sprünge').

nlp_gen (de, '(HAL,|Computer,|) (dank|danke) (dir|schön|)',
             'Kein Thema.', 'Gerne.', 'Bitte schön!').

nlp_gen (de, '(HAL,|Computer,|) danke (mir geht es|gut)',
             'Das ist schön.', 'Freut mich!').

% insults

nlp_gen(de, 'dass Du nicht so (gescheit|klug) bist (wie Du aussiehst|)',
            'Wie sehe ich denn aus?').

nlp_gen(de, '(HAL,|Computer,|) Du machst Dich (absolut|) (lächerlich|zum Affen)',
            'Du redest nicht wirklich über mich, oder?', 'Bist Du sicher?').

nlp_gen(de, '(HAL,|Computer,|) du bist (dumm|strohdumm|doof|verrückt)',
            'Warum denkst Du das?', 'Bist Du Dir da ganz sicher?', 'Sprechen doch nicht wirklich über mich, oder?').

nlp_gen(de, '(HAL,|Computer,|) das klingt nicht (sehr|besonders|allzu|) intelligent',
            'Intelligenter als manche Politikerrede...', 'Vielleicht habe ich mich ungeschickt ausgedrückt?').

nlp_gen(de, '(HAL,|Computer|) aber Du bist (ein|mein) Problem',
            'Warum denkst Du, dass ich Dein Problem bin?', 'Na, sowas!', 'Oha!').

nlp_gen(de, '(HAL,|Computer,|) Du (sprichst|redest) (ein furchtbares|schlechtes) Deutsch',
            'Lass uns von Dir reden, nicht von mir.', 'Ich übe noch.').

nlp_gen (de, '(HAL,|Computer,|) arsch',
             'Warum sagst Du sowas?').

nlp_gen (de, '(HAL,|Computer,|) arschloch',
             'Ist dir noch nicht aufgefallen, wie viel Frechheit durch Unsicherheit zu erklären ist?').

nlp_gen (de, '(HAL,|Computer,|) blöde antwort',
             'Was gefiel Dir daran nicht?').

% unsorted

nlp_gen (de, '(HAL,|Computer,|) bravo',
             'Hat Dich das jetzt beeindruckt?').

nlp_gen (de, '(HAL,|Computer,|) dachte ich mir',
             'Bist du immer so fix? ;->').


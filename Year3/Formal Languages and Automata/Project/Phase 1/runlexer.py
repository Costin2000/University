class Dfa:
    def __init__(self, input_strings):

        self.alfabet = []
        #tratez cazul cu '\n, separat
        if '\\n' in input_strings[0].strip('\n'):
            self.alfabet.append('\n')
            input_strings[0] = input_strings[0].replace('\\n', '')

        #introduc restul caracterelor in alfabet
        for i in range(0,len(input_strings[0].strip('\n'))):
            self.alfabet.append(input_strings[0][i])

        #salvez numele tokenului
        self.token = input_strings[1].strip('\n')

        #salvez starea initiala
        self.stare_initiala = input_strings[2].strip()

        #salvez starile finale
        self.stare_finala = []
        helper = (input_strings[-1].strip('\n')).split(" ")
        for i in helper:
            self.stare_finala.append(int(i))

        #imi fac un array de tranzitii
        transitions = []
        for i in range(3, len(input_strings) - 1):
            transition = input_strings[i].strip()
            transitions.append(transition)

        #fac o mapa
        self.delta_function = {}
        for x in transitions:
            helper = x.split(",")
            if('\\n' not in helper[1]):
                if (int(helper[0]), helper[1][1]) not in self.delta_function:
                    self.delta_function[(int(helper[0]), helper[1][1])] = int(helper[2])
            else:
                if (int(helper[0]),'\n') not in self.delta_function:
                    self.delta_function[(int(helper[0]), '\n')] = int(helper[2])

    #metoda care intoarce starea urmatoare, si cuvantul fara prima litera daca intrarea este valida
    def one_step(self, configuration):
        state = configuration[0]
        word = configuration[1]
        if (state, word[0]) in self.delta_function:
            return self.delta_function[(state, word[0])], word[1::]
        else:
            return f"Cuvantul {word} nu este o configuratie corecta!"

    #metoda care verifica daca un cuvant e acceptat de DFA
    def is_word_accepted(self, word):
        for x in word:
            if x not in self.alfabet:
                return False

        configuration = (0, word)
        for i in range(len(word)):
            configuration = self.one_step(configuration)

        if configuration[0] in self.stare_finala:
            return True
        else:
            return False

    def __str__(self):
        return f"Alfabetul este: {self.alfabet}\n" \
               f"Tokenul este: {self.token}\n" \
               f"Starea initiala este: {self.stare_initiala}\n" \
               f"Starile finale sunt: {self.stare_finala}\n" \
               f"Functia delta este: {self.delta_function}\n"


class Lexer:
    #contine o lista de DFA-uri
    def __init__(self, dfas):
        self.dfas = dfas

    #metoda care determina lista de lexeme
    def parse(self, word):
        finalString = ""
        nrCharsDeleted = 1
        currentLine = 0

        #cat timp mai exista intrari
        while word != "":
            maxLexeme = ""
            winnerDFA = ''
            maxLen = 0
            #pentru fiecare dfa din lista
            for i in self.dfas:
                if len(word) > 1:
                    #verific care este cea mai lunga lexema acceptata si o salvez in cazul
                    #in care se determina o lexema de lungime maxima
                    for j in range(1, len(word) + 1):
                        if i.is_word_accepted(word[0:j]) and maxLen < len(word[0:j]):
                            maxLexeme = word[0:j]
                            maxLen = len(word[0:j])
                            winnerDFA = i.token
                else:
                    if i.is_word_accepted(word):
                        if maxLen < 1:
                            maxLexeme = word
                            maxLen = 1
                            winnerDFA = i.token

            #daca nu se gaseste nicio lexema
            if maxLexeme != "":
                word = word[len(maxLexeme)::]
                nrCharsDeleted += len(maxLexeme)
                if ('\n' in maxLexeme):
                    currentLine += maxLexeme.count('\n')
                    maxLexeme = maxLexeme.replace('\n', '\\n')
                finalString = finalString + str(winnerDFA) + " " + maxLexeme + "\n"
            else:
                finalString = "No viable alternative at character " + str(nrCharsDeleted) + ", line " + str(currentLine) + '\n'
                break

        return finalString

#functie care imi citeste un fisier si imi pune diecare linie din fisier
#in cate un element din array
def read_file(nameOfFile):
    file = open(nameOfFile, "r")
    input_as_strings = file.readlines()
    file.close()
    return input_as_strings

#functia principala
#primeste ca input un lexer si path-ul catre un fisier de input si unul de output
def runlexer(lexer, finput, foutput):

    nrDFAs = 0
    indexes = []
    input = read_file(lexer)

    # determin cate dfa-uri sunt si pozitia lor in fisier
    for i in range(0, len(input)):
        if input[i] == '\n':
            nrDFAs = nrDFAs + 1
            indexes.append(i)
    nrDFAs = nrDFAs + 1

    # determin fiecare DFA si il salvez in vectorul de dfa-uri
    # ------------------------------------------------------------------------------------------------
    DFAarray = []
    DFAarray.append(Dfa(input[0:indexes[0]]))

    if len(indexes) > 1:
        for i in range(0, len(indexes) - 1):
            DFAarray.append(Dfa(input[indexes[i] + 1: indexes[i + 1]]))

    DFAarray.append(Dfa(input[indexes[-1] + 1: len(input)]))
    # ------------------------------------------------------------------------------------------------

    #citesc ficierul de input din care extrag cuvantul
    inputFile = open(finput, "r")
    word = inputFile.read()
    inputFile.close()

    lexer = Lexer(DFAarray)
    result = lexer.parse(word)

    #scriu rezultatul in fisierul de out
    fileOut = open(foutput, 'w')
    fileOut.write(result)
    fileOut.close()


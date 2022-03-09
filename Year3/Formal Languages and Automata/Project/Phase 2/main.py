class Variable:
    def __init__(self, exp):
        self.var = exp

    def __str__(self):
        return f"{self.var}"


class Concat:
    def __init__(self, expr1, expr2):
        self.expr1 = expr1
        self.expr2 = expr2

    def __str__(self):
        return f"Concat({self.expr1}, {self.expr2})"


class Union:
    def __init__(self, expr1, expr2):
        self.expr1 = expr1
        self.expr2 = expr2

    def __str__(self):
        return f"Union({self.expr1}, {self.expr2})"


class Star:
    def __init__(self, expr):
        self.expr = expr

    def __str__(self):
        return f"Star({self.expr})"


class Plus:
    def __init__(self, expr):
        self.expr = expr

    def __str__(self):
        return f"Plus({self.expr})"

#--------------------------------------------------------------------------------

def verifInitialized(exp):
    if isinstance(exp, Concat):
        if exp.expr1 != "?" and exp.expr2 != "?":
            return True
    if isinstance(exp, Union):
        if exp.expr1 != "?" and exp.expr2 != "?":
            return True
    if isinstance(exp, Plus):
        if exp.expr != "?":
            return True
    if isinstance(exp, Star):
        if exp.expr != "?":
            return True
    return False

#puts all the paranteses to the regex and creates the necessary classes
def parse(string):
    stack = []

    while string:

        if string.startswith('CONCAT '):
            string = string[len('CONCAT '):]
            stack.append(Concat("?", "?"))

        elif string.startswith('STAR '):
            string = string[len('STAR '):]
            stack.append(Star("?"))

        elif string.startswith('UNION '):
            string = string[len('UNION '):]
            stack.append(Union("?", "?"))

        elif string.startswith('PLUS '):
            string = string[len('PLUS '):]
            stack.append(Plus("?"))

        elif not stack:
            stack.append(Variable(string))
            break

        else:
            elems = string[0]
            string = string[len(elems[0]) + 1:]

            if isinstance(stack[-1], Union):
                if stack[-1].expr1 == "?":
                    stack[-1].expr1 = Variable(elems[0])
                elif stack[-1].expr2 == "?":
                    stack[-1].expr2 = Variable(elems[0])

            if isinstance(stack[-1], Concat):
                if stack[-1].expr1 == "?":
                    stack[-1].expr1 = Variable(elems[0])
                elif stack[-1].expr2 == "?":
                    stack[-1].expr2 = Variable(elems[0])

            if isinstance(stack[-1], Star):
                if stack[-1].expr == "?":
                    stack[-1].expr = Variable(elems[0])

            if isinstance(stack[-1], Plus):
                if stack[-1].expr == "?":
                    stack[-1].expr = Variable(elems[0])

            while verifInitialized(stack[-1]) and (len(stack) != 1):

                if isinstance(stack[-2], Union):
                    if stack[-2].expr1 == "?":
                        stack[-2].expr1 = stack[-1]
                    elif stack[-2].expr2 == "?":
                        stack[-2].expr2 = stack[-1]

                if isinstance(stack[-2], Concat):
                    if stack[-2].expr1 == "?":
                        stack[-2].expr1 = stack[-1]
                    elif stack[-2].expr2 == "?":
                        stack[-2].expr2 = stack[-1]

                if isinstance(stack[-2], Star):
                    if stack[-2].expr == "?":
                        stack[-2].expr = stack[-1]

                if isinstance(stack[-2], Plus):
                    if stack[-2].expr == "?":
                        stack[-2].expr = stack[-1]

                stack.pop()

    stackFinal = stack[0]
    stack.pop()
    return stackFinal

#------------------------------------------------------------------------------------------
class NFA:
    def __init__(self, alphabet, initialState, finalState, deltaFunction):
        self.alphabet = alphabet
        self.initialState = initialState
        self.finalState = finalState
        self.deltaFunction = deltaFunction

    def __str__(self):
        return  (f"alphabet: {self.alphabet} \n"
                f"initial state: {self.initialState} \n"
                f"final state: {self.finalState} \n"
                f"delta function: {self.deltaFunction}")

def printList(l):
    out = ''
    for x in l:
        out += str(x) + " "

    out = out[:-1]
    return out

def printDic(dict):
    out = ''

    for key in dict:
        out += str(key[0]) + ",'" + str(key[1]) + "'," + str(dict[key]) + "\n"

    out = out[:-1]

    return out



class DFA:
    def __init__(self, alphabet, nrStates, initialState, finalState, deltaFunction):
        self.nrStates = nrStates
        self.alphabet  = alphabet
        self.initialState = initialState
        self.finalState = finalState
        self.deltaFunction = deltaFunction

    def __str__(self):
        return (f"{listToNumber(self.alphabet)}\n"
                f"{self.nrStates}\n"
                f"{self.initialState}\n"
                f"{printList(self.finalState)}\n"
                f"{printDic(self.deltaFunction)}")

#------------------------------------------------------------------------------------------
#recursive function to determine the NFA for the given expression
def regexToNfa(ourNFA, expression):

    if isinstance(expression, Variable):
        if ourNFA.initialState == -1 and ourNFA.finalState == -1:
            ourNFA.alphabet = [expression.var]
            ourNFA.initialState = 0
            ourNFA.finalState = 1
            ourNFA.deltaFunction[(ourNFA.initialState, expression.var)] = ourNFA.finalState

    if isinstance(expression, Star):
        ourNFA = regexToNfa(ourNFA, expression.expr)

        newDict = {}
        for x in ourNFA.deltaFunction:
            newDict[(x[0] + 1, x[1])] = ourNFA.deltaFunction[x] + 1
        ourNFA.deltaFunction = newDict

        ourNFA.initialState += 1
        ourNFA.finalState += 1

        ourNFA.deltaFunction[(ourNFA.initialState - 1, "epsilon1")] = ourNFA.initialState
        ourNFA.deltaFunction[(ourNFA.finalState, "epsilon1")] = ourNFA.finalState + 1
        ourNFA.deltaFunction[(ourNFA.initialState-1, "epsilon2")] = ourNFA.finalState + 1
        ourNFA.deltaFunction[(ourNFA.finalState,  "epsilon2")] = ourNFA.initialState

        ourNFA.initialState -=1
        ourNFA.finalState += 1

    if isinstance(expression, Concat):
        NFAaux1 = regexToNfa(NFA([], -1, -1, {}), expression.expr1)
        NFAaux2 = regexToNfa(NFA([], -1, -1, {}), expression.expr2)
        ourNFA.alphabet = NFAaux2.alphabet + NFAaux1.alphabet

        newDict = {}
        for x in NFAaux2.deltaFunction:
            newDict[(x[0] + NFAaux1.finalState + 1, x[1])] = NFAaux2.deltaFunction[x] + NFAaux1.finalState + 1
        NFAaux2.initialState += NFAaux1.finalState + 1
        NFAaux2.finalState += NFAaux1.finalState + 1

        NFAaux2.deltaFunction = newDict
        ourNFA.deltaFunction.update(NFAaux1.deltaFunction)
        ourNFA.deltaFunction.update(NFAaux2.deltaFunction)
        ourNFA.deltaFunction[(NFAaux1.finalState, "epsilon")] = NFAaux2.initialState
        ourNFA.initialState = NFAaux1.initialState
        ourNFA.finalState = NFAaux2.finalState

    if isinstance(expression, Plus):
        ourNFA = regexToNfa(ourNFA, expression.expr)

        copie = regexToNfa(NFA([], -1, -1, {}), expression.expr)

        newDict = {}
        for x in copie.deltaFunction:
            newDict[(x[0] + 1, x[1])] = copie.deltaFunction[x] + 1
        copie.deltaFunction = newDict

        copie.initialState += 1
        copie.finalState += 1

        copie.deltaFunction[(copie.initialState - 1, "epsilon1")] = copie.initialState
        copie.deltaFunction[(copie.finalState, "epsilon1")] = copie.finalState + 1
        copie.deltaFunction[(copie.initialState - 1, "epsilon2")] = copie.finalState + 1
        copie.deltaFunction[(copie.finalState, "epsilon2")] = copie.initialState

        copie.initialState -= 1
        copie.finalState += 1
        # --------------------------------------------------------------------------
        newDict = {}
        for x in copie.deltaFunction:
            newDict[(x[0] + ourNFA.finalState + 1, x[1])] = copie.deltaFunction[x] + ourNFA.finalState + 1
        copie.deltaFunction = newDict
        copie.initialState += ourNFA.finalState + 1
        copie.finalState += ourNFA.finalState + 1
        #---------------------------------------------------------------------------
        #concatenate the two dict
        ourNFA.deltaFunction.update(copie.deltaFunction)

        ourNFA.deltaFunction[(ourNFA.finalState, "epsilon")] = copie.initialState
        ourNFA.finalState = copie.finalState

    if isinstance(expression, Union):
        NFAaux1 = regexToNfa(NFA([],-1, -1, {}), expression.expr1)
        NFAaux2 = regexToNfa(NFA([],-1, -1, {}), expression.expr2)
        ourNFA.alphabet = NFAaux2.alphabet + NFAaux1.alphabet


        newDict = {}
        for x in NFAaux2.deltaFunction:
            newDict[(x[0] + NFAaux1.finalState + 1, x[1])] = NFAaux2.deltaFunction[x] + NFAaux1.finalState + 1
        NFAaux2.deltaFunction =newDict
        NFAaux2.initialState += NFAaux1.finalState + 1
        NFAaux2.finalState += NFAaux1.finalState + 1


        newDict = {}
        for x in NFAaux1.deltaFunction:
            newDict[(x[0] + 1, x[1])] = NFAaux1.deltaFunction[x] + 1
        NFAaux1.deltaFunction = newDict

        NFAaux1.initialState += 1
        NFAaux1.finalState += 1

        newDict = {}
        for x in NFAaux2.deltaFunction:
            newDict[(x[0] + 1, x[1])] = NFAaux2.deltaFunction[x] + 1
        NFAaux2.deltaFunction = newDict

        NFAaux2.initialState += 1
        NFAaux2.finalState += 1

        ourNFA.deltaFunction.update(NFAaux1.deltaFunction)
        ourNFA.deltaFunction.update(NFAaux2.deltaFunction)
        ourNFA.initialState = 0
        ourNFA.finalState = NFAaux2.finalState + 1
        ourNFA.deltaFunction[(ourNFA.initialState,"epsilon1")] = NFAaux1.initialState
        ourNFA.deltaFunction[(ourNFA.initialState, "epsilon2")] = NFAaux2.initialState
        ourNFA.deltaFunction[(NFAaux1.finalState, "epsilon1")] = ourNFA.finalState
        ourNFA.deltaFunction[(NFAaux2.finalState, "epsilon2")] = ourNFA.finalState

    return ourNFA
#-----------------------------------------------------------------------------------------
class costGraphElement:
    def __init__(self, currentState, cost, possibleNextStates):
        self.currentState = currentState
        self.cost = cost
        self.possibleNextStates =possibleNextStates

    def __str__(self):
        return f"{self.currentState} -> cost: {self.cost} -> {self.possibleNextStates}"

#verify if element exists in graph
def finndInGraph(graph, state, cost):
    if len(graph) != 0:
        for i in range(len(graph)):
            if graph[i].currentState == state and graph[i].cost == cost:
                return i
    return -1

#convert NFA deltafunction into a cost graph
def NFAtoCostGraph(ourNFA):
    graph = []

    for x in ourNFA.deltaFunction:

        if x[1].startswith("epsilon"):
            idx = finndInGraph(graph, x[0], "epsilon")
        else:
            idx = finndInGraph(graph, x[0], x[1])

        if idx == -1:
            if x[1].startswith("epsilon"):
                graph.append(costGraphElement(x[0], "epsilon", [ourNFA.deltaFunction[(x[0], x[1])]]))
            else:
                graph.append(costGraphElement(x[0], x[1], [ourNFA.deltaFunction[(x[0],x[1])]]))
        else:
            graph[idx].possibleNextStates.append(ourNFA.deltaFunction[(x[0], x[1])])

    return graph
#-----------------------------------------------------------------------------------------

#function to determine the epsilon closure for a state
def epsClosure(graf, state):
    visited = []  # Set to keep track of visited nodes.
    visited = dfa(visited, graf, state)

    visited = list(dict.fromkeys(visited))
    visited.sort()
    return visited

def epsClosureOnInput (graf, state, imp):
    idx = finndInGraph(graf, state, imp)
    visited = []
    if idx != -1:
        for x in graf[idx].possibleNextStates:
            visited += epsClosure(graf, x)

    visited = list(dict.fromkeys(visited))
    visited.sort()
    return visited


def dfa(visited, graf, state):

    if state not in visited:
        visited.append(state)
        idx = finndInGraph(graf, state, "epsilon")
        if idx != -1:
            for neighbour in graf[idx].possibleNextStates:
                dfa(visited,graf, neighbour)

    return visited


def listToNumber(list):
    num = ''
    list.sort()
    for x in list:
        num += str(x)
    return num


#function to determine the DFA when the NFA is known
def NFAtoDFA(graph, alphabet, finalState):
    nrStates = 0
    ourDFA = DFA(alphabet, 0, -1, [], {})

    statesDiscovered = []
    remainedToStudy = []

    for x in alphabet:
        ourDFA.deltaFunction[(nrStates, x)] = nrStates

    statesDiscovered.append(nrStates)

    firstState = epsClosure(graph, 0)
    #copie = listToNumber(firstState)
    nrStates += 1
    ourDFA.initialState = nrStates


    if finalState in firstState:
        ourDFA.finalState.append(nrStates)

    remainedToStudy.append(firstState)
    statesDiscovered.append(firstState)

    #while there are still states remained not studied
    while remainedToStudy:

        toStudy = remainedToStudy[-1]
        currState = statesDiscovered.index(remainedToStudy[-1])
        nextToDelete = len(remainedToStudy) -1

        #for each possible input
        for x in alphabet:
            newState = []
            #generate the eps transition for current dfa state
            for y in toStudy:
                idx = finndInGraph(graph, y, x)
                if idx != -1:
                    newState += epsClosureOnInput(graph, y, x)

            if newState:
                #if a state was generated
                newState = list(dict.fromkeys(newState))
                newState.sort()

                #if state has already been discovered
                if newState in statesDiscovered:
                    idx = statesDiscovered.index(newState)
                    ourDFA.deltaFunction[(currState, x)] = idx
                else:
                    nrStates += 1
                    remainedToStudy.append(newState)
                    statesDiscovered.append(newState)
                    ourDFA.deltaFunction[(currState, x)] = nrStates
                    if finalState in newState:
                        ourDFA.finalState.append(nrStates)
            else:
                #current state will go into a sink with that input
                ourDFA.deltaFunction[(currState, x)] = 0
        remainedToStudy.pop(nextToDelete)

        ourDFA.nrStates = len(statesDiscovered)
    return ourDFA
#-----------------------------------------------------------------------------------------
import sys

def main():
    args = sys.argv[1:]

    f = open(args[0], "r")

    #read input from file
    input = f.read()

    #parse the input
    expression = parse(input)

    #determine the NFA
    ourNFA = regexToNfa(NFA([], -1, -1, {}), expression)


    alphabet = list(dict.fromkeys(ourNFA.alphabet))
    #transform the NFA into a graph
    graf = NFAtoCostGraph(ourNFA)

    #determine the DFA
    ourDFA = NFAtoDFA(graf, alphabet, ourNFA.finalState)


    foutput = args[1]
    f = open(foutput, "w")
    f.write(str(ourDFA))
    f.close()

if __name__ == "__main__":
    main()

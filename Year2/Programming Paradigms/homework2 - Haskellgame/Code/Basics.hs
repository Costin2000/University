{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE EmptyDataDecls, MultiParamTypeClasses,
             TypeSynonymInstances, FlexibleInstances,
             InstanceSigs #-}

module Basics where
{-
    Expune funcțiile necesare reprezentării jocului.
-}

import ProblemState
import Data.List
import Data.Maybe
import Data.Char



{-
    Sinonim tip de date pentru reprezetarea unei perechi (Int, Int)
    care va reține coordonatele celulelor de pe tabla de joc.
    Colțul stânga-sus este (0, 0).
-}
type Position = (Int, Int)

{-
    Tip de date pentru reprezentarea Target-urilor.
    Acestea conțin informații atât despre poziția curentă a
    Target-ului cât și despre comportamentul acestuia.
    Tipul Behavior este definit mai jos.
-}
data Target = Target {
    position :: Position,
    behavior :: Behavior
}

instance Eq Target where
    Target p1 _ == Target p2 _ = p1 == p2

instance Ord Target where
    Target p1 _ <= Target p2 _ = p1 <= p2

{-
    Tip de date pentru reprezentarea comportamentului unui Target.
    Tipul Behavior este utilizat pentru a modela tranziția Target-urilor
    din starea curentă în starea următoare. Primul parametru este poziția
    actuală a target-ului, iar al doilea, starea curentă a jocului.
    Tipul Game este definit mai jos.
    
    Observați că, din moment ce un Behavior produce un Target nou,
    acesta din urmă ar putea fi caracterizat de un alt Behavior
    decât cel anterior.
-}
type Behavior = Position -> Game -> Target

{-
    Direcțiile de deplasare pe tablă
-}
data Direction = North | South | West | East
    deriving (Eq, Show)

data Cell = Cell {
    character :: Char,
    positionOfcell :: Position,
    gateways :: (Position, Position)
} deriving (Eq, Ord)

{-
    *** TODO ***
    
    Tip de date pentru reprezentarea stării jocului, la un anumit
    moment. Completați-l cu orice informație aveți nevoie pentru
    stocarea stării jocului (hunter, target, obstacole, gateways).
-}

--data GameBoard = Board [Cell] deriving (Eq, Ord)
--data Game = GameBoard deriving (Eq, Ord)

data Game = Game {
    backupBoard :: [Cell],
    gameBoard :: [Cell],
    row :: Int,
    column :: Int,
    targetList :: [Target]
} deriving (Eq, Ord)


{-
    *** Optional *** 
  
    Dacă aveți nevoie de o funcționalitate particulară,
    instantiați explicit clasele Eq și Ord pentru Game.
    În cazul acesta, eliminați deriving (Eq, Ord) din Game.
-}

{-
    *** TODO ***

    Reprezentați starea jocului ca șir de caractere, pentru afișarea
    la consolă.
    
    Atenție! Fiecare linie, mai puțin ultima, este urmată de \n.
    Celule goale vor fi reprezentate ca ' '.
    Hunter-ul va fi reprezentat ca '!'.
    Target-urile vor fi reprezentate ca '*'
    Gateways-urile vor fi reprezentate ca '#'.
    Obstacolele vor fi reprezentate de '@'.

    Hint: S-ar putea să vă fie utile list comprehensions,
    precum și funcțiile elem, any și intercalate din Data.List.
-}

gameAsString :: Game -> String
gameAsString (Game backup cells rows columns targets) = foldl f [] cells where
    f acc (Cell chara (x, y) gates)
        | (y == columns - 1) && (x /= (rows - 1)) = acc ++ [chara] ++ "\n"
        | otherwise = acc ++ [chara]

instance Show Game where
    show = gameAsString

{-
    *** TODO ***
    
    Primește numărul de linii și numărul de coloane ale tablei de joc.
    Intoarce un obiect de tip Game în care tabla conține spații goale în interior, fiind
    împrejmuită de obstacole pe toate laturile. Implicit, colțul din stânga sus este (0,0),
    iar Hunterul se găsește pe poziția (1, 1).
-}
emptyCellsHelper :: [(Int, Int)] -> Int -> Int -> [Cell]
emptyCellsHelper positions i j = foldl f [] positions where 
    f acc (x, y)
        | (y == 0) || (y == (j - 1)) = acc ++ [Cell '@' (x, y) ((-1, -1), (-1, -1))]
        | (x == 0) || (x == (i - 1)) = acc ++ [Cell '@' (x, y) ((-1, -1), (-1, -1))]
        | (x == 1) && (y == 1) = acc ++ [Cell '!' (x, y) ((-1, -1), (-1, -1))]
        | otherwise = acc ++ [Cell ' ' (x, y) ((-1, -1), (-1, -1))]

emptyGame :: Int -> Int -> Game
emptyGame rows columns =
    let emptyCells = [(x, y) | x <- [0..(rows - 1)], y <- [0..(columns - 1)]]
    in Game (emptyCellsHelper emptyCells rows columns) (emptyCellsHelper emptyCells rows columns) rows columns []
    

{-
    *** TODO ***

    Primește o poziție și un joc și întoarce un nou joc, cu Hunter-ul pus
    pe poziția specificată.
    Parametrul Position reprezintă poziția de pe hartă la care va fi adaugat Hunter-ul
    Daca poziția este invalidă (ocupată sau în afara tablei de joc) se va întoarce
    același joc.
-}

getHunterPosition :: [Cell] -> Position
getHunterPosition cells
    | (character (head cells)) == '!' = (positionOfcell (head cells))
    | otherwise = getHunterPosition (tail cells)

getHunterChar :: Cell -> Char
getHunterChar backup
    | (character backup) == '#' = '#'
    | otherwise = ' '

resetHunterHelper :: Position -> [Cell] -> [Cell] -> [Cell] -> [Cell]
resetHunterHelper (x, y) cells backup acc
    | null cells = acc
    | (x == (fst (positionOfcell (head cells)))) && (y == (snd (positionOfcell (head cells)))) = 
        (resetHunterHelper (x, y) (tail cells) (tail backup) (acc ++ [Cell '!' (positionOfcell (head cells)) (gateways (head cells))]))
    | ((character (head cells)) == '!') = 
        (resetHunterHelper (x, y) (tail cells) (tail backup) (acc ++ [Cell (getHunterChar (head backup)) (positionOfcell (head cells)) (gateways (head cells))]))
    | otherwise = (resetHunterHelper (x, y) (tail cells) (tail backup) (acc ++ [Cell (character (head cells)) (positionOfcell (head cells)) (gateways (head cells))]))

resetHunter :: Int -> Int -> Position -> [Cell] -> [Cell] -> [Cell]
resetHunter rows columns (x, y) cells backup
    | (y <= 0) || (y >= (columns - 1)) = cells
    | (x <= 0) || (x >= (rows - 1)) = cells
    | otherwise = (resetHunterHelper (x, y) cells backup [])


addHunter :: Position -> Game -> Game
addHunter poz (Game backup cells rows columns targets) = 
    Game backup (resetHunter rows columns poz cells backup) rows columns targets

{-
    *** TODO ***

    Primește un comportament, o poziție și un joc și întoarce un nou joc, în care a fost
    adăugat Target-ul descris de comportament și poziție.
    Parametrul Behavior reprezintă comportamentul Hunter-ului care va fi adăugat.
    Parametrul Position reprezintă poziția de pe hartă la care va fi adăugat Target-ul.
-}

addTargetsHelper :: [Cell] -> Position -> [Cell]
addTargetsHelper cells (x, y) = foldl f [] cells where 
        f acc (Cell chara (m, n) gates)
                | (m == x) && (n == y) = acc ++ [Cell '*' (m, n) gates]
                | otherwise = acc ++ [Cell chara (m, n) gates]

addTarget :: Behavior -> Position -> Game -> Game
addTarget behav poz (Game backup cells rows columns targets) = 
    Game backup (addTargetsHelper cells poz) rows columns (targets ++ [Target poz behav])

{-
    *** TODO ***

    Primește o pereche de poziții și un joc și întoarce un nou joc, în care au fost adăugate
    cele două gateway-uri interconectate.
    Parametrul (Position, Position) reprezintă pozițiile de pe hartă la care vor fi adăugate 
    cele două gateway-uri interconectate printr-un canal bidirecțional.
-}

addGatewaysHelper :: [Cell] -> Position -> Position -> [Cell]
addGatewaysHelper cells (m, n) (p, q) = foldl f [] cells where 
        f acc (Cell chara (a, b) ((c, d), (e, f)))
                | (a == m) && (b == n) = acc ++ [Cell '#' (a, b) ((m, n), (p, q))]
                | (a == p) && (b == q) = acc ++ [Cell '#' (a, b) ((m, n), (p, q))]
                | otherwise = acc ++ [Cell chara (a, b) ((c, d), (e, f))]

addGateway :: (Position, Position) -> Game -> Game
addGateway (poz1, poz2) (Game backup cells rows columns targets) = 
    Game (addGatewaysHelper cells poz1 poz2) (addGatewaysHelper cells poz1 poz2) rows columns targets

{-
    *** TODO ***

    Primește o poziție și un joc și întoarce un nou joc, în care a fost adăugat un obstacol
    la poziția specificată.
    Parametrul Position reprezintă poziția de pe hartă la care va fi adăugat obstacolul.
-}

addObstaclesHelper :: Position -> [Cell] -> [Cell]
addObstaclesHelper (x, y) cells = foldl f [] cells where 
        f acc (Cell chara (m, n) gates)
                | (m == x) && (n == y) = acc ++ [Cell '@' (m, n) gates]
                | otherwise = acc ++ [Cell chara (m, n) gates]

addObstacle :: Position -> Game -> Game
addObstacle poz (Game backup cells rows columns targets) = 
    Game (addObstaclesHelper poz cells) (addObstaclesHelper poz cells) rows columns targets

{-
    *** TODO ***
    
    Primește o poziție destinație înspre care vrea să se deplaseze o entitate (Hunter sau Target)
    și verifică daca deplasarea este posibilă, întorcând noua poziție, luând în considerare
    și Gateway-urile.
    Avem următoarele cazuri:
    - dacă poziția corespunde unui spațiu gol, se întoarce acea poziție;
    - dacă poziția corespunde unui gateway, se întoarce poziția gateway-ului pereche;
    - dacă poziția corespunde unui obstacol, se întoarce Nothing.
    Parametrul Position reprezintă poziția destinație.
-}

checkGates :: Position -> Cell -> Position
checkGates (x, y) cell
    | ((x == (fst (fst (gateways cell)))) && (y == (snd (fst (gateways cell))))) = (snd (gateways cell))
    | otherwise = (fst (gateways cell))

attemptHelper :: Position -> [Cell] -> Maybe Position
attemptHelper (x, y) cells
    | null cells = Nothing
    | (((fst (positionOfcell (head cells))) == x) && ((snd (positionOfcell (head cells))) == y) 
    && (character (head cells)) == ' ') = Just (positionOfcell (head cells))
    |(((fst (positionOfcell (head cells))) == x) && ((snd (positionOfcell (head cells))) == y) 
    && (character (head cells)) == '@') = Nothing
    |(((fst (positionOfcell (head cells))) == x) && ((snd (positionOfcell (head cells))) == y) 
    && ((character (head cells)) == '#')) = Just (checkGates (x, y) (head cells))  
    | otherwise = attemptHelper (x, y) (tail cells)
           
attemptMove :: Position -> Game -> Maybe Position
attemptMove poz (Game backup cells rows columns targets) = (attemptHelper poz cells)

{-
    *** TODO ***

    Comportamentul unui Target de a se deplasa cu o casuță înspre est. 
    Miscarea se poate face doar daca poziția este validă (se află pe tabla de
    joc) și nu este ocupată de un obstacol. In caz contrar, Target-ul va rămâne 
    pe loc.
    
    Conform definiției, tipul Behavior corespunde tipului funcție
    Position -> Game -> Target.
    
    Având în vedere că cele patru funcții definite în continuare (goEast, goWest,
    goNorth, goSouth) sunt foarte similare, încercați să implementați o funcție
    mai generală, pe baza căreia să le definiți apoi pe acestea patru.
-}

checkBrokenGate :: [Cell] -> Position -> Cell
checkBrokenGate backup (a, b)
    | null backup = (Cell '?' (a, b) ((a, b), (b, b)))
    | (a == (fst (positionOfcell (head backup)))) && (b == (snd (positionOfcell (head backup)))) && ((character (head backup)) == '#') =
        (head backup)
    | otherwise = checkBrokenGate (tail backup) (a, b)

verifyPosition :: Position -> Position -> Game -> Position
verifyPosition (x, y) (a, b) (Game backup cells rows columns targets)
    | (x > (rows - 1)) || (x < 0) = (a, b)
    | (y > (columns - 1)) || (y < 0) = (a, b)
    | attemptMove (x, y) (Game backup cells rows columns targets) /= Nothing = fromJust (attemptMove (x, y) (Game backup cells rows columns targets))
    | attemptMove (x, y) (Game backup cells rows columns targets) == Nothing && ((character (checkBrokenGate backup (a, b))) == '#') = 
        (checkGates (a, b) (checkBrokenGate backup (a, b)))  
    | otherwise = (a, b)

getTarget :: [Target] -> Position -> Target
getTarget targets (x, y)
    | (((fst (position (head targets))) == x) && ((snd (position (head targets))) == y)) = head targets
    | otherwise = getTarget (tail targets) (x, y)

goEast :: Behavior
goEast (x, y) (Game backup cells rows columns targets) = 
    (Target (verifyPosition (x, y + 1) (x, y) (Game backup cells rows columns targets)) (behavior (getTarget targets (x, y))))

{-
    *** TODO ***

    Comportamentul unui Target de a se deplasa cu o casuță înspre vest. 
    Miscarea se poate face doar daca poziția este validă (se află pe tabla de
    joc) și nu este ocupată de un obstacol. In caz contrar, Target-ul va rămâne 
    pe loc.
-}
goWest :: Behavior
goWest (x, y) (Game backup cells rows columns targets) = 
    (Target (verifyPosition (x, y - 1) (x, y) (Game backup cells rows columns targets)) (behavior (getTarget targets (x, y))))

{-
    *** TODO ***

    Comportamentul unui Target de a se deplasa cu o casuță înspre nord. 
    Miscarea se poate face doar daca poziția este validă (se află pe tabla de
    joc) și nu este ocupată de un obstacol. In caz contrar, Target-ul va rămâne 
    pe loc.
-}
goNorth :: Behavior
goNorth (x, y) (Game backup cells rows columns targets) = 
    (Target (verifyPosition (x - 1, y) (x, y) (Game backup cells rows columns targets)) (behavior (getTarget targets (x, y))))

{-
    *** TODO ***

    Comportamentul unui Target de a se deplasa cu o casuță înspre sud. 
    Miscarea se poate face doar daca poziția este validă (se află pe tabla de
    joc) și nu este ocupată de un obstacol. In caz contrar, Target-ul va rămâne 
    pe loc.
-}
goSouth :: Behavior
goSouth (x, y) (Game backup cells rows columns targets) = 
    (Target (verifyPosition (x + 1, y) (x, y) (Game backup cells rows columns targets)) (behavior (getTarget targets (x, y))))

{-
    *** TODO ***

    Comportamentul unui Target de a-și oscila mișcarea, când înspre nord, când înspre sud. 
    Mișcarea se poate face doar dacă poziția este validă (se află pe tablă de
    joc) și nu este ocupată de un obstacol. In caz contrar, Target-ul iși va schimba
    direcția de mers astfel:
    - daca mergea inspre nord, își va modifica direcția miscării înspre sud;
    - daca mergea inspre sud, își va continua mișcarea înspre nord.
    Daca Target-ul întâlneste un Gateway pe traseul său, va trece prin acesta,
    către Gateway-ul pereche conectat și își va continua mișcarea în același sens la ieșire
    din acesta.
    Puteți folosit parametrul Int pentru a surprinde deplasamentul Target-ului (de exemplu,
    1 pentru sud, -1 pentru nord).
-}

checkBehaviorSouth :: Position -> Game -> Target
checkBehaviorSouth (x, y) (Game backup cells rows columns targets)
    | attemptMove (x + 1, y) (Game backup cells rows columns targets) /= Nothing = 
        (Target (verifyPosition (x + 1, y) (x, y) (Game backup cells rows columns targets)) (behavior (getTarget targets (x, y))))
    | otherwise = (Target (x - 1, y) (bounce (-1)))

checkBehaviorNorth :: Position -> Game -> Target
checkBehaviorNorth (x, y) (Game backup cells rows columns targets)
    | attemptMove (x - 1, y) (Game backup cells rows columns targets) /= Nothing = 
        (Target (verifyPosition (x - 1, y) (x, y) (Game backup cells rows columns targets)) (behavior (getTarget targets (x, y))))
    | otherwise = (Target (x + 1, y) (bounce 1))

bounce :: Int -> Behavior
bounce whichDirection (x, y) (Game backup cells rows columns targets)
    | whichDirection == 1 = (checkBehaviorSouth (x, y) (Game backup cells rows columns targets))
    | otherwise = (checkBehaviorNorth (x, y) (Game backup cells rows columns targets))

{-
    *** TODO ***
    Funcție care mută toate Target-urile din Game-ul dat o poziție, în functie
    de behavior-ul fiecăreia și întoarce noul Game în care pozițiile Target-urilor
    sunt actualizate.
    
-}

removeTargetHelper :: [Cell] -> [Cell] -> [Cell] -> [Cell]
removeTargetHelper backup cells finalCells
    | null cells = finalCells
    | ((character (head backup)) == ' ') && ((character (head cells)) == '*') =
        (removeTargetHelper (tail backup) (tail cells) (finalCells ++ [Cell ' ' (positionOfcell (head cells)) (gateways (head cells))]))
    | ((character (head backup)) == '#') && ((character (head cells)) == '*') = 
        (removeTargetHelper (tail backup) (tail cells) (finalCells ++ [Cell '#' (positionOfcell (head cells)) (gateways (head cells))]))
    | ((character (head backup)) == '*') && ((character (head cells)) == '*') =
        (removeTargetHelper (tail backup) (tail cells) (finalCells ++ [Cell ' ' (positionOfcell (head cells)) (gateways (head cells))])) 
    | otherwise = (removeTargetHelper (tail backup) (tail cells) (finalCells ++ [Cell (character (head cells)) (positionOfcell (head cells)) (gateways (head cells))]))

updateTargets :: [Target] -> [Target] -> Game -> [Target]
updateTargets oldTargets newTargets (Game backup cells rows columns targets)
    | null oldTargets = newTargets
    | otherwise = (updateTargets (tail oldTargets) 
    (newTargets ++ [(behavior (head oldTargets)) (position (head oldTargets)) (Game backup cells rows columns targets)]) 
    (Game backup cells rows columns targets))

addNewTargets :: Game -> [Target] -> Game
addNewTargets game newTargets
    | null newTargets = game
    | otherwise = (addNewTargets (addTarget (behavior (head newTargets)) (position (head newTargets)) game) (tail newTargets))


moveTargets :: Game -> Game
moveTargets (Game backup cells rows columns targets) =
    (addNewTargets (Game backup (removeTargetHelper backup cells []) rows columns []) 
    (updateTargets targets [] (Game backup cells rows columns targets)))





{-
    *** TODO ***

    Verifică dacă Targetul va fi eliminat de Hunter.
    Un Target este eliminat de Hunter daca se află pe o poziție adiacentă
    cu acesta.
    Parametrul Position reprezintă poziția Hunterului pe tabla
    de joc.
    Parametrul Target reprezintă Targetul pentru care se face verificarea.
-}

isTargetKilledHelper :: Position -> Position -> Bool
isTargetKilledHelper (a, b) (c, d)
    | ((a == c) && (d == b - 1)) || ((a == c) && (d == b + 1)) = True
    | ((b == d) && (c == a + 1)) || ((b == d) && (c == a - 1)) = True
    | otherwise = False

isTargetKilled :: Position -> Target -> Bool
isTargetKilled poz (Target targetPosition behav) = isTargetKilledHelper poz targetPosition


{-
    *** TODO ***

    Avansează starea jocului curent, rezultând starea următoare a jocului.
    Parametrul Direction reprezintă direcția în care se va deplasa Hunter-ul.
    Parametrul Bool specifică dacă, după mutarea Hunter-ului, vor fi
    mutate și Target-urile sau nu, și dacă vor fi eliminate din joc sau nu.
    Este folosit pentru a distinge între desfășurarea reală a jocului (True)
    și planificarea „imaginată” de hunter (False) în partea a doua a temei.

    Avansarea stării jocului respectă următoarea ordine:
    1. Se deplasează Hunter-ul.
    2. În funcție de parametrul Bool, se elimină Target-urile omorâte de către Hunter.
    3. In funcție de parametrul Bool, se deplasează Target-urile rămase pe tablă.
    4. Se elimină Targeturile omorâte de către Hunter și după deplasarea acestora.
    
    Dubla verificare a anihilării Target-urilor, în pașii 2 și 4, îi oferă Hunter-ului
    un avantaj în prinderea lor.
-}

killFirstWave :: Position -> [Target] -> [Target] -> [Target]
killFirstWave (x, y) targets acc
    | null targets = acc
    | (isTargetKilled (x, y) (head targets)) == False = killFirstWave (x, y) (tail targets) (acc ++ [head targets])
    | otherwise = killFirstWave (x, y) (tail targets) acc

killSecondWave :: Game -> Game
killSecondWave (Game backup cells rows columns targets) = (addNewTargets (Game backup (removeTargetHelper backup cells []) rows columns []) 
    (killFirstWave (getHunterPosition cells) targets []))

nextStep :: Game -> Game
nextStep (Game backup cells rows columns targets) = (killSecondWave (moveTargets (Game backup cells rows columns targets)))


tryToKill :: Game -> Game
tryToKill (Game backup cells rows columns targets) = (nextStep (addNewTargets (Game backup (removeTargetHelper backup cells []) rows columns []) 
    (killFirstWave (getHunterPosition cells) targets [])))

checkForKill :: Game -> Bool -> Game
checkForKill (Game backup cells rows columns targets) bool
    | bool == False = (Game backup cells rows columns targets)
    | otherwise = tryToKill (Game backup cells rows columns targets)

advanceGameState :: Direction -> Bool -> Game -> Game
advanceGameState direction bool (Game backup cells rows columns targets)
    | direction == North = 
        checkForKill (addHunter (verifyPosition ((fst (getHunterPosition cells)) - 1, (snd (getHunterPosition cells))) (getHunterPosition cells) (Game backup cells rows columns targets)) 
        (Game backup cells rows columns targets)) bool
    | direction == South =
        checkForKill (addHunter (verifyPosition ((fst (getHunterPosition cells)) + 1, (snd (getHunterPosition cells))) (getHunterPosition cells) (Game backup cells rows columns targets)) 
        (Game backup cells rows columns targets)) bool
    | direction == East =
        checkForKill (addHunter (verifyPosition ((fst (getHunterPosition cells)), (snd (getHunterPosition cells)) + 1) (getHunterPosition cells) (Game backup cells rows columns targets)) 
        (Game backup cells rows columns targets)) bool
    | otherwise = checkForKill (addHunter (verifyPosition ((fst (getHunterPosition cells)), (snd (getHunterPosition cells)) - 1) (getHunterPosition cells) (Game backup cells rows columns targets)) 
    (Game backup cells rows columns targets)) bool

{-
    ***  TODO ***

    Verifică dacă mai există Target-uri pe table de joc.
-}
areTargetsLeftHelper :: [Target] -> Bool
areTargetsLeftHelper myTargets
    | (null myTargets) = True
    | otherwise = False

areTargetsLeft :: Game -> Bool
areTargetsLeft (Game backup cells rows columns targets) = areTargetsLeftHelper targets


{- Varianta A 2020 -}
type Text = String
type Pair = (String, Int)
type Index = [(String, [Int])]


lowerSentence :: Text -> Text -> Text
lowerSentence text acc
    | (null text) = acc
    | (head text) == '!' || (head text) == '?' || (head text) == '.' || (head text) == ',' = lowerSentence (tail text) acc
    | otherwise = lowerSentence (tail text) (acc ++ [(toLower (head text))])

lowerText :: [Text] -> Int -> [(Int, Text)] -> [(Int, Text)]
lowerText bigText idx acc
    | (null bigText) = acc
    | otherwise = lowerText (tail bigText) (idx + 1) (acc ++ [(idx, (lowerSentence (head bigText) []))])

breakText :: Text -> [Text]
breakText text = lines text

textToLines :: Text -> [(Int, Text)]
textToLines text = (lowerText (breakText (lowerSentence text [])) 1 [])

removeFromIndex :: String -> Index -> Index -> Index
removeFromIndex string index acc
    | (null index) = acc
    | string == (fst (head index)) = (removeFromIndex string (tail index) acc)
    | otherwise = (removeFromIndex string (tail index) (acc ++ [(head index)]))

sameNumber :: Pair -> Index -> Index -> Index
sameNumber pair index acc
    | ((elem (snd pair) (snd (head index))) == True) = acc
    | otherwise = ([((fst (head index)), [(snd pair)] ++ (snd (head index)))] ++ (removeFromIndex (fst pair) acc []))


sameName :: Pair -> Index -> Index -> Index
sameName pair index indexCopy
    | (null index) = ([((fst pair), [(snd pair)])] ++ indexCopy)
    | ((fst pair) == (fst (head index))) = indexCopy
    | otherwise = (sameName pair (tail index) indexCopy)

insertHelper :: Pair -> Index -> Index -> Index -> Index
insertHelper pair index indexCopy acc
    | (null indexCopy) = acc ++ [((fst pair), [(snd pair)])]
    | (null index) = acc
    | ((fst pair) == (fst (head index))) = (insertHelper pair (tail index) indexCopy (sameNumber pair index acc))
    | otherwise = (insertHelper pair (tail index) indexCopy (sameName pair index index))

insPair :: Pair -> Index -> Index
insPair pair index = (insertHelper pair index index [])

splitPair :: Int -> [String] -> [Pair] -> [Pair]
splitPair index myWords acc
    | (null myWords) = acc
    | otherwise = splitPair index (tail myWords) (acc ++ [((head myWords), index)])

makePairs :: [(Int, Text)] -> [Pair] -> [Pair]
makePairs lines acc
    | (null lines) = acc
    | otherwise = makePairs (tail lines) (acc ++ (splitPair (fst (head lines)) (words (snd (head lines))) []))

allPairs :: Text -> [Pair]
allPairs text = (makePairs (textToLines text) [])

{-finalMerge :: Index -> Index -> Index
finalMerge index1 index2
    | -}

mergePairs :: [Pair] -> Index -> Index
mergePairs pairs acc
    | (null pairs) = acc
    | otherwise = mergePairs (tail pairs) (acc ++ (insPair (head pairs) []))

textToIndex :: Text -> Index
textToIndex text = (mergePairs (allPairs text) [])


{-instance (Num a, Show a, Enum a, Show b) => Show (a -> b) where
    show f = show $ map (\x -> (x, f x)) [0..5]-}

{-f x y = head x y-}

--f x y = f (f x y) (f y x)
--g x = [x]

{-f x y = fst x : map (snd x) y-}

data Rectangle = CreateRectangle {
    height :: Integer,
    width :: Integer
}

instance Show Rectangle where
    show rectangle
        | (height rectangle < 0) || (width rectangle < 0) = "Impossible"
        | otherwise = "Height is " ++ show (height rectangle) ++ " and width is " ++ show (width rectangle) ++ "."

instance Eq Rectangle where
    rec1 == rec2 = height rec1 == height rec2 && width rec1 == width rec2

instance Num Rectangle where
    rec1 + rec2 = CreateRectangle (height rec1 + height rec2) (width rec1 + width rec2)
    rec1 - rec2 = CreateRectangle (height rec1 - height rec2) (width rec1 - width rec2)
    
       
dummy x = filter $ x . x . x

evenFilter :: Integer -> Integer -> Integer
evenFilter x y
    | (x + y) `mod` 2 == 0 = (x + y)
    | otherwise = 1

{-instance (Num a, Enum a, Ord b) => Ord (a -> b) where
    f <= g = and $ zipWith (<=) (map f [0..100]) (map g [0..100])-}
{-instance (Num a, Enum a, Show a, Show b) => Show (a -> b) where
    show f = show $ map (\x -> (x, f x)) [0..5]-}


data Move = Rock | Paper | Scissors deriving (Eq, Show)
data GameRPS = GameRPS [(Move, Move)]

instance Ord Move where
	Rock <= other = other /= Scissors
	Paper <= other = other /= Rock
	Scissors <= other = other /= Paper


extractPlayersMoves :: [(Move, Move)] -> Int -> [Move] -> [Move]
extractPlayersMoves game player moves
    | (null game) = moves
    | (player == 1) = extractPlayersMoves (tail game) player (moves ++ [(fst (head game))])
    | otherwise = extractPlayersMoves (tail game) player (moves ++ [(snd (head game))])


mostUsed :: GameRPS -> Int -> Move
mostUsed (GameRPS game) player = head $ extractPlayersMoves game player []



data Team = Team String [(String, Int, Int)] deriving Show

instance Eq Team where
	Team _ m1 == Team _ m2 = score m1 == score m2 where
		score m = [if goluri_marcate > goluri_primite then 3 else if goluri_marcate == goluri_primite then 1 else 0 | (_ , goluri_marcate, goluri_primite) <- m]



f3 a (x, y) 
    | a == 0    = []
    | otherwise = (a, y) : f3 (a - 1) (y, x)

instance Ord a => Ord [a] where
    xs > ys = or $ zipWith (\x y -> x > y) xs ys

{-type Lei = Integer
type Bani = Integer

data MoneyUnit = MoneyUnit {
    lei :: Lei,
    bani :: Bani
}


data Amount = Amount (Lei, Bani)

getMoneyHelper :: [MoneyUnit] -> Lei -> Bani -> Amount
getMoneyHelper moneyList leiacc baniacc
    | null moneyList = (leiacc, baniacc)
    | otherwise = getMoneyHelper (tail moneyList) (leiacc + (lei (head moneyList))) (baniacc + (bani (head moneyList)))

getTotalSum :: [MoneyUnit] -> Amount
getTotalSum moneyList = getMoneyHelper moneyList 0 0


getBestHelper :: [MoneyUnit] -> MoneyUnit -> Maybe MoneyUnit
getBestHelper moneyList bestValue
    | null moneyList = bestValue
    | (lei (head moneyList)) > (lei bestValue) = getBestHelper (tail moneyList) (head moneyList)
    | otherwise = getBestHelper (tail moneyList) bestValue

getBestUnit :: [MoneyUnit] -> Maybe MoneyUnit
getBestUnit moneyList
    | null moneyList = Nothing
    | otherwise getBestHelper moneyList (MoneyUnit 0 0)-}

  

--instance (Num a, Ord a, Show a) => Ord [a] where
    --1 > l2 = (length (filter (\x -> x == (head l1)) l1)) > (length (filter (\x -> x == (head l2)) l2))



{- Varianta C -}

{-data Prop
    = Simple Char
    | Neg Prop
    | And Prop Prop
    | Or Prop Prop

prop :: Prop
prop = Neg $ Simple 'p' `And` (Neg (Simple 'q') `Or` Simple 'r')

instance Show Prop where
    show (Simple c) = [c]
    show (Neg p) = "~" ++ show p
    show (And p1 p2) = "(" ++ show p1 ++ " ^ " ++ show p2 ++ ")"
    show (Or p1 p2) = "(" ++ show p1 ++ " v " ++ show p2 ++ ")"-}


{-
    *** BONUS TODO ***

    Comportamentul unui Target de a se deplasa în cerc, în jurul unui Position, având
    o rază fixată.
    Primul parametru, Position, reprezintă centrul cercului.
    Parametrul Int reprezintă raza cercului.
    Puteți testa utilizând terenul circle.txt din directorul terrains, în conjuncție
    cu funcția interactive.
-}
circle :: Position -> Int -> Behavior
circle = undefined


instance ProblemState Game Direction where
    {-
        *** TODO ***
        
        Generează succesorii stării curente a jocului.
        Utilizați advanceGameState, cu parametrul Bool ales corespunzător.
    -}
    successors = undefined

    {-
        *** TODO ***
        
        Verifică dacă starea curentă este un în care Hunter-ul poate anihila
        un Target. Puteți alege Target-ul cum doriți, în prezența mai multora.
    -}
    isGoal  = undefined

    {-
        *** TODO ***
        
        Euristica euclidiană (vezi hEuclidian mai jos) până la Target-ul ales
        de isGoal.
    -}
    h = undefined

{-
     ** NU MODIFICATI **
-}
hEuclidean :: Position -> Position -> Float
hEuclidean (x1, y1) (x2, y2) = fromIntegral $ ((x1 - x2) ^ pow) + ((y1 - y2) ^ pow)
  where
    pow = 2 :: Int

{-
    *** BONUS ***

    Acesta reprezintă un artificiu necesar pentru testarea bonusului,
    deoarece nu pot exista două instanțe diferite ale aceleiași clase
    pentru același tip.

    OBSERVAȚIE: Testarea bonusului pentru Seach este făcută separat.
-}

newtype BonusGame = BonusGame Game
    deriving (Eq, Ord, Show)

{-
    *** BONUS TODO ***

    Folosind wrapper-ul peste tipul Game de mai sus instanțiați
    ProblemState astfel încât să fie folosită noua euristică. 
-}
instance ProblemState BonusGame Direction where
    {-
        *** BONUS TODO ***

        Pentru a ne asigura că toțî succesorii unei stări sunt de tipul
        BonusGame și folosesc noua euristică trebuie să aplicăm wrapper-ul
        definit mai sus peste toți succesorii unei stări.

        Hint: Puteți să folosiți funcția fmap pe perechi pentru acest lucru.
        https://wiki.haskell.org/Functor
    -}
    successors = undefined

    {-
        *** BONUS TODO ***

        Definiți funcția isGoal pentru BonusGame.

        Hint: Folosiți funcția isGoal deja implementată pentru tipul Game.
    -}
    isGoal = undefined

    {-
        *** BONUS TODO ***

        Definiți o funcție euristică care este capabilă să găsească un drum mai scurt
        comparativ cu cel găsit de euristica implementată pentru Game.

        ATENȚIE: Noua euristică NU trebuie să fie una trivială.

        OBSERVAȚIE: Pentru testare se va folosi fișierul terrains/game-6.txt.
    -}
    h = undefined

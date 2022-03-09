CC=g++
CODE1=algo1.cpp
CODE2=algo2.cpp
CODE3=algo3.cpp
EXE1=algo1.o
EXE2=algo2.o
EXE3=algo3.o

all: build

build1: algo1.cpp
	$(CC) $(CODE1) -o $(EXE1)

build2: algo2.cpp
	$(CC) $(CODE2) -o $(EXE2)

build3: algo3.cpp
	$(CC) $(CODE3) -o $(EXE3)

run1: $(EXE1)
	./$(EXE1)

run2: $(EXE2)
	./$(EXE2)

run3: $(EXE3)
	./$(EXE3)

clean:
	rm -f $(EXE)

.PHONY: clean run


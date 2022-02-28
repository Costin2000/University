#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef char* Key;
typedef int Value;
typedef long(*HashFunction)(Key, long);

typedef struct Element {
  Key key;
  Value value;
  struct Element *next;
} Element;

typedef struct HashTable {
  Element** elements;
  long size;
  HashFunction hashFunction;
} HashTable;

void initHashTable(HashTable **h, long size, HashFunction f) 
{
  // Cerinta 1
	*h = (HashTable*) malloc(sizeof(HashTable));
	(*h)->size = size;
	(*h)->elements = (Element**) calloc(size, sizeof(Element*));
	(*h)->hashFunction = f;
}

int exists(HashTable *hashTable, Key key) 
{
  // Cerinta 1
	Element* search = hashTable->elements[hashTable->hashFunction(key, hashTable->size)];
	while(search != NULL)
	{
		if(strcmp(search->key, key) == 0)
		{
			return 1;
		}
		search = search->next;
	}

  return 0;
}

Value get(HashTable *hashTable, Key key) 
{
  // Cerinta 1
	Element* search = hashTable->elements[hashTable->hashFunction(key, hashTable->size)];
	while(search != NULL)
	{
		if(strcmp(search->key, key) == 0)
		{
			return search->value;
		}
		search = search->next;
	}
	return 0;
}

void put(HashTable *hashTable, Key key, Value value) 
{
  // Cerinta 1
	Element* search = hashTable->elements[hashTable->hashFunction(key, hashTable->size)];
	if(search == NULL)
	{
		Element* new_element = (Element*) malloc(sizeof(Element));
		new_element->key = (char*) malloc(strlen(key) * sizeof(char));
		strcpy(new_element->key, key);
		new_element->value = value;
		hashTable->elements[hashTable->hashFunction(key, hashTable->size)] = new_element;
		new_element->next = NULL;
		return;
	}
	while(search != NULL)
	{
		if(strcmp(search->key, key) == 0)
		{
			search->value = value;
			return;
		}
		if(search->next == NULL)
		{
			Element* new_element = (Element*) malloc(sizeof(Element));
			new_element->key = (char*) malloc(strlen(key) * sizeof(char));
			strcpy(new_element->key, key);
			new_element->value = value;
			search->next = new_element;
			new_element->next = NULL;
			return;
		}
		search = search->next;
	}
}

void deleteKey(HashTable *hashTable, Key key) 
{
  // Cerinta 1
	Element* search = hashTable->elements[hashTable->hashFunction(key, hashTable->size)];
	Element* search_prev = NULL;
	while(search != NULL)
	{
		if(strcmp(search->key, key) == 0)
		{
			if(search_prev == NULL)
			{
				hashTable->elements[hashTable->hashFunction(key, hashTable->size)] = search->next;
				free(search->key);
				free(search);
				return;
			}
			else
			{
				search_prev->next = search->next;
				free(search->key);
				free(search);
				return;
			}
		}
		search_prev = search;
		search = search->next;
	}
}

void print(HashTable *hashTable) {
  // Cerinta 1
	Element* elem, *elem1, *aux;
	int i, level=1;
	
	int* address=(int*)10;
	
	for(i = 0; i<hashTable->size; i++)
	{
		elem = hashTable->elements[i];

		/*
		int needSwap=0, amSwap;
		
		do
		{
			elem = hashTable->elements[i];
			amSwap=0;
			
			while (elem->next!=NULL)
			{	
				elem1=elem->next;
				needSwap=0;

				if(elem->value>elem1->value)
				{
					needSwap=1;
				}
				
				if(needSwap==1)
				{
					if (elem==hashTable->elements[i])
					{
						elem->next=elem1->next;;
						elem1->next=elem;
						amSwap=1;
						hashTable->elements[i]=elem1;
					}
					else
					{
						elem->next=elem1->next;;
						elem1->next=elem;
						amSwap=1;
					}	
				}
				else
				{
					elem=elem1;
				}
				
			}
		}while(amSwap==1);
		*/
		
		if(&elem->value > address)
			printf("%d: \n", i);
		
		while(elem != NULL)
		{
			printf("      ");
			printf("%s : %d\n", elem->key, elem->value);
			elem = elem->next;
		}
	}
	printf("----END----\n");
}

void freeHashTable(HashTable *hashTable) 
{
  // Cerinta 1
	int i;
	Element* delete, *delete_prev;
	for(i = 0; i < hashTable->size; i++)
	{
		delete = hashTable->elements[i];
		while(delete != NULL)
		{
			delete_prev = delete;
			delete = delete->next;
			free(delete_prev->key);
			free(delete_prev);
		}

	}
	free(hashTable->elements);
	free(hashTable);
}


long hash1(Key word, long size) {
  // Cerinta 2
  	long h = 0;
  
  for(long i = 0; i<strlen(word); i++)
  	 h=h*17 + word[i];
  
  return h%size;
}

int main(int argc, char* argv[]) {
  HashTable *hashTable;
  FILE *f1, *f2;
  char word[256];
  long hashSize, common=0;

  hashSize = atoi(argv[1]);
  f1 = fopen(argv[2], "r");
  f2 = fopen(argv[3], "r");

  initHashTable(&hashTable, hashSize, &hash1);
  
  while(fscanf(f1, "%s", word) != EOF)
  {

  	Value valoare;
  	if(exists(hashTable, word) == 0)
	{
  		valoare = 1;
  	}
  	else
	{
  		valoare = get(hashTable, word);
  		valoare++;
  	}
  	put(hashTable, word, valoare);

  }

  print(hashTable);

  HashTable *hashTable2;
  initHashTable(&hashTable2, hashSize, &hash1);

  Value valoare;
  while(fscanf(f2, "%s", word) != EOF)
  {

  	if(exists(hashTable2, word) == 0)
	{
  		valoare = 1;
  	}
  	else
	{
  		valoare = get(hashTable, word);
  		valoare++;
  	}
  	put(hashTable2, word, valoare);

  }

  Element* search;
  int i, min;
  for(i = 0; i < hashTable->size; i++)
  {
  	search = hashTable->elements[i];
  	while(search != NULL)
	{
  		min = -1;
  		if(exists(hashTable2, search->key))
		{
  			min = get(hashTable, search->key);
  			if(get(hashTable2, search->key) < min)
			{
  				min = get(hashTable2, search->key);
  			}

  			common += min;
  		}
  		search = search->next;
  	}
  }


  printf("Common words: %ld\n", common);

  fclose(f1);
  fclose(f2);
  return 0;
}

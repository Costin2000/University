#ifndef __HUFFMAN_H__
#define __HUFFMAN_H__

#include <string.h>

typedef struct {
    unsigned char value;
    int left, right;
} HuffmanNode;

#define Item int

// Including below so `Item` is defined.
#include "heap.h"

void computeFreqs(char *text, int size, int freqs[256]) {
for (int i = 0; i < 256; ++i)
{
	freqs[i]=0;
}
for (int i = 0; i <size ; ++i)
{
	freqs[(int)text[i]]++;
}

}

HuffmanNode *makeTree(int freqs[256], int *size) 
{
	PriQueue *heap = makeQueue(256);
	HuffmanNode *huf = (HuffmanNode*) malloc(512*sizeof(HuffmanNode));
  	for(int i = 0; i < 256; ++i)
    	{        
		if( freqs[i] != 0)
		{
		    	ItemType aux;
		    	aux.prior = freqs[i];
		    	aux.content = *size;
		    	insert(heap,aux);
			huf[*size].value = i;
		    	huf[*size].left = huf[*size].right = -1;
		    	(*size)++;
        	}
    	}
        if( heap->size == 1)
	{
        ItemType aux = getMin(heap);
        huf[*size].left = aux.content;
        huf[*size].right = -1;
        (*size)++; 
    	}
   	else
	{
        	while(heap->size > 1)
		{
		    	ItemType x,y,aux;
		    	x = getMin(heap);   
		    	removeMin(heap);
		    	y = getMin(heap);
		    	removeMin(heap);
		    	huf[*size].left = x.content;
		    	huf[*size].right = y.content;
		    	aux.content = *size;
		    	aux.prior = x.prior + y.prior;
		    	insert(heap,aux);
		    	(*size)++;
        	}
    	}
    	return huf;
}


void makeCodes(int index, HuffmanNode *nodes, char **codes, char *code) 
{
   	if( nodes[index].value != '\0')
	{
        	codes[index] = (char*) calloc(strlen(code) + 1,sizeof(char));
        	strcpy(codes[index],code);
    	}
    	else
	{
		strcat(code,"0");
		makeCodes(nodes[index].left,nodes,codes,code);
		code[strlen(code) - 1] = '\0';
		strcat(code,"1");
		makeCodes(nodes[index].right,nodes,codes,code);
		code[strlen(code) - 1] = '\0';
    	}
}

char *compress(char *text, int textSize, HuffmanNode *nodes, int numNodes) {
    	int letter[256],nr = 0;

    	if( textSize == 0)
	{
		char *nul =(char*) calloc(2,sizeof(char));
		nul[0] = ' ';
		return nul;
    	}

    	for(int i = 0; i < numNodes ;i++)
	{
        	letter[(int)nodes[i].value] = nr;
        	nr++;
    	}
    
    	char **codes = (char**) malloc(nr*sizeof(char*));

	char *code = (char*) malloc(256*sizeof(char));
	code[0] = '\0';
	makeCodes(numNodes - 1,nodes,codes,code);
    
    	char *comp = (char*) malloc(256*sizeof(char));
    	comp[0] = '\0';
    	for(int i = 0; i < textSize; i++)
	{
        	int index = letter[(int)text[i]];
        	strcat(comp,codes[index]);
	}


    	return comp;
}

char *decompress(char *text, int textSize, HuffmanNode *nodes, int numNodes) 
{
    	char* mesaj =  malloc(256*sizeof(char));


    	if( textSize == 0 )
	{
        	return mesaj;
    	}

    	int k = numNodes - 1,marime = 0;
    	for(int i = 0; i < textSize; i++)
	{
        	if( text[i] == '0' )
		{
            		k = nodes[k].left;
        	}
		else if (text[i] == '1')
		{
		    	k = nodes[k].right;
		}


		if( nodes[k].value != '\0' )
		{
		    mesaj[marime] = nodes[k].value;
		    marime++;
		    k = numNodes - 1;
		}
    	}
    	return mesaj;
}

#endif


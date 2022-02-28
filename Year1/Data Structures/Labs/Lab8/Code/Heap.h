#ifndef __HEAP_H__
#define __HEAP_H__

#include <stdlib.h>
#include <math.h>

/* We assume there is a defined primitive type Item. */
typedef struct {
	int prior; // Item priority
	Item data; // Item d
}ItemType;

typedef struct heap{
	long maxHeapSize; // capacity
	long size; // number of elements
	ItemType *elem; // array of elements
} PriQueue, *APriQueue;


PriQueue* makeQueue(int maxHeapSize){
	PriQueue* h;
	h =(PriQueue*)malloc(sizeof(PriQueue));
	h -> maxHeapSize = maxHeapSize;
	h -> size = 0;
	h -> elem = (ItemType*)malloc(maxHeapSize*sizeof(ItemType));
	return h;
}

int getLeftChild(int i){
	return (2*i)+1;
}

int getRightChild(int i) {
	return 2*i+2;
}

int getParent(int i) {
	return (i-1)/2;
}

ItemType getMax(APriQueue h) {
	if(h != NULL && h->elem != NULL)
		return h->elem[0];
}

void siftUp(APriQueue h, int idx) {
	int parinte;
	parinte = getParent(idx);

	while (parinte >= 0 && h->elem[parinte].prior < h->elem[idx].prior)
	{
		ItemType aux = h->elem[parinte];
		h->elem[parinte] = h->elem[idx];
		h->elem[idx] = aux;
		idx = parinte;
		parinte = getParent(idx);
	}	

}


void insert(PriQueue *h, ItemType x) {
	
	if (h == NULL) return;


	if (h->size == h->maxHeapSize)
	{
		h->maxHeapSize *= 2;
		h->elem = realloc(h->elem, h->maxHeapSize * sizeof(ItemType));
	}

	h->elem[h->size] = x;
	siftUp(h, h->size);
	h->size++;
}


void siftDown(APriQueue h, int idx){
	int copilLeft;
	
	while((2*idx)+1<h->size)
	{
		copilLeft=getLeftChild(idx);
		

		if(copilLeft<h->size && h->elem[copilLeft].prior<h->elem[copilLeft+1].prior)
			copilLeft=copilLeft+1;
		
		if(h->elem[idx].prior > h->elem[copilLeft].prior)
			break;
		

		ItemType aux;
		aux = h->elem[idx];
		h->elem[idx]=h->elem[copilLeft];
		h->elem[copilLeft]=aux;
		idx=copilLeft;
	}
	
}

void removeMax(APriQueue h) {
	h->elem[0] = h->elem[h->size-1];
	h->size = h->size - 1;
	siftDown(h, 0);
}

void freeQueue(APriQueue h){
	free(h->elem);
	free(h);
}

#endif


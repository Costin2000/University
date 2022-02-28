#ifndef TREE_H_D
#define TREE_H_

#include <stdio.h>
#include <stdlib.h>

typedef int Item;

int size=0,adancime=0;

typedef struct Link
  {
    Item  elem;
    struct Link *l;
    struct Link *r;
  } TreeNode;



void Init(TreeNode **t, Item x)
{
   	(*t)->elem=x;
}

void Insert(TreeNode **t, Item x)
{
	TreeNode *newNode=NULL;

	if(!(*t))
	{
		newNode=(TreeNode*)malloc(sizeof(TreeNode));	  
		newNode->elem=x;
		newNode->l=NULL;
		newNode->r=NULL;
		*t=newNode;
		return;
	}
	
	if((*t)->elem>x)
		Insert(&(*t)->l,x);
	else if((*t)->elem<x)
		Insert(&(*t)->r,x);
}

void printeaza(TreeNode *node)
{
	printf("%d ", node->elem);
}

void PrintPostorder(TreeNode *t)
{
	if(t==NULL)
		return;
	PrintPostorder(t->l);
	PrintPostorder(t->r);
	printeaza(t);
}

void PrintPreorder(TreeNode *t)
{
	if(t==NULL)
		return;
	printeaza(t);
	PrintPreorder(t->l);
	PrintPreorder(t->r);

}

void PrintInorder(TreeNode *t)
{
	
	if(t==NULL)
		return;
	PrintInorder(t->l);
	printeaza(t);
	PrintInorder(t->r);

}

void Free(TreeNode **t)
{
	if (*t == NULL) return; 
    	Free(&(*t)->l); 
    	Free(&(*t)->r); 
    	free(*t); 

}

int Size(TreeNode* t)
{
	if(t==NULL)
		return 0;
	size++;
	Size(t->l);
	Size(t->r);
	return size;

}

int maxDepth(TreeNode *t)
{
	if(t==NULL)
		return 0;
	else 
	{
		int lDepth = maxDepth(t->l); 
	        int rDepth = maxDepth(t->r); 
       	        if (lDepth > rDepth) 
			return(lDepth+1); 
	        else 
			return(rDepth+1); 
	   } 
		
}



#endif // LINKEDSTACK_H_INCLUDED

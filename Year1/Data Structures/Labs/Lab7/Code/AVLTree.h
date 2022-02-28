
#ifndef AVLTREE_H_
#define AVLTREE_H_

#include<stdlib.h>

// An AVL tree node
typedef struct AVLNode{
	Item elem;
	int height;
	struct AVLNode *l;
	struct AVLNode *r;
	struct AVLNode *p;

}AVLNode;

typedef struct AVLTree{
	long size;
	AVLNode* root;
	AVLNode* nil;
	int (*comp)(Item a, Item b);
}AVLTree;

AVLTree* avlCreateTree(int (*comp) (Item1,Item1))
{
	AVLTree* newTree = (AVLTree*) malloc(sizeof(AVLTree));
	newTree->comp = comp;
	newTree->nil = (AVLNode*) malloc(sizeof(AVLNode));
	newTree->nil->p = newTree->nil->l = newTree->nil->r = newTree->nil;
	newTree->nil->height = 0;
	newTree->root = (AVLNode*) malloc(sizeof(AVLNode));
	newTree->root->p = newTree->root->l = newTree->root->r = newTree->nil;
	newTree->root->height = 0;
	newTree->size = 0;

	return newTree;
}

int avlIsEmpty(AVLTree* tree){
	return (tree->root->l == tree->nil);
}

AVLNode* avlNewNode(AVLTree* tree){
	AVLNode* newNode = (AVLNode*) malloc(sizeof(AVLNode));
	// Initialize the new node to be used in the tree
	newNode->p = newNode->r = newNode->l = tree->nil;
	newNode->height = 1;

	return newNode;
}

int height(AVLNode *t)
{
	if(t==NULL)
		return 0;
	else 
	{
		int lDepth = height(t->l); 
	        int rDepth = height(t->r); 
       	        if (lDepth > rDepth) 
			return(lDepth+1); 
	        else 
			return(rDepth+1); 
	   } 
		
}


// A utility function to get maximum of two integers
int max(int a, int b){
	return (a > b)? a : b;
}

// A utility function to right rotate subtree rooted with y
void avlRightRotate(AVLTree *tree,  AVLNode *x){
	AVLNode *y;
	
	y=x->l;//salvez subarbore stang
	
	x->l=y->r;//mut beta
	
	if(y->r !=tree->nil) y->l->p=x;//update parinte beta
	
	y->p=x->p;//update parinte y

	if(y!=tree->root)
	{
		if(y->elem < x->p->elem)//update la legatura dintre parintele lui x si noul copil
			x->p->l=y;
		else 
			x->p->r=y;
		y->l=x;
	}
	else tree->root->l=y;

	x->p=y;//update parinte x
	
	x->height=max(x->l->height,x->r->height)+1;
	y->height=max(y->l->height,y->r->height)+1;
	
	
}


void avlLeftRotate(AVLTree *tree, AVLNode *x){
	
	AVLNode *y;
	
	y=x->r;//salvez subarbore drept
	
	x->r=y->l;//mut beta
	
	if (y->l!=tree->nil) y->l->p=x;//update parinte beta
	
	y->p=x->p;//update parinte y(pt ca devine radacina)
	
	if(y!=tree->root)
	{ 
		if(y->elem < x->p->elem)//update la legatura dintre parintele lui x si noul copil
			x->p->l=y;
		else 
			x->p->r=y;
		y->l=x;
	}
	else tree->root->l=y;	
	
	x->p=y;
		
	x->height=max(x->l->height,x->r->height)+1;
	y->height=max(y->r->height,y->l->height)+1;
}

// Get Balance factor of node x
int avlGetBalance(AVLNode *x){
	if (x == NULL)
		return 0;
	return x->l->height - x->r->height;
}

AVLNode * avlMinimum(AVLTree* tree, AVLNode* x){
	while (x->l != tree->nil)
		x = x->l;
	return x;
}

AVLNode* avlMaximum(AVLTree* tree, AVLNode* x){
	while(x->r != tree->nil){
		x = x->r;
	}
	return x;
}



void avlInsert(struct AVLTree* tree, Item elem){
	AVLNode* node=(AVLNode*)malloc(sizeof(AVLNode));
	node->p=tree->nil;
	node->l=tree->nil;
	node->r=tree->nil;
	node->height = 1;
	node->elem = elem;
	if(tree->root->l != tree->nil)
	{
		AVLNode *aux = tree->root->l;
		while(aux != tree->nil)
		{
			if(elem == aux->elem) 
				return;

			if(tree->comp(elem, aux->elem) == -1) 
			{
				if (aux->l == tree->nil) 
				{
					aux->l = node;
					node->p = aux;
					break;
				}
				aux = aux->l;
			}
			else if (tree->comp(elem, aux->elem) == 1) 
			{
				if (aux->r == tree->nil) 
				{
					aux->r=node;
					node->p = aux;
					break;
				}
				aux = aux->r;
			}
		}
		tree->size++;
	}
 	else 
	{
	tree->root->l=node;
	node->p=tree->root;
	tree->size++;
	}

	AVLNode* y=node->p;
	while(y!=tree->root)
	{
		y->height=max(y->l->height,y->r->height)+1;
		if(y->l!=tree->nil && y->r!=tree->nil)
		{
			if(avlGetBalance(y)==-2 && tree->comp(y->r->elem , elem)==-1)
			{
				avlLeftRotate(tree,y);
			}
			if(avlGetBalance(y)==2 && tree->comp(y->l->elem, elem)==-1)
			{
				avlLeftRotate(tree,y->l);
				avlRightRotate(tree,y);
			}
			if(avlGetBalance(y)==-2  && tree->comp(y->r->elem,elem)==1)
			{
				avlRightRotate(tree,y->r);
				avlLeftRotate(tree,y);
			}
			if(avlGetBalance(y)==2 && tree->comp(y->l->elem, elem)==1)
			{
				avlRightRotate(tree,y);
			}
		}
		y=y->p;
	}
	
}




void avlDeleteNode(AVLTree *tree, AVLNode* node){
	destroyElem(node->elem);
	free(node);
}


void avlDestroyTreeHelper(AVLTree* tree, AVLNode* x) {
	if (x != tree->nil) {
		avlDestroyTreeHelper(tree,x->l);
		avlDestroyTreeHelper(tree,x->r);
		avlDeleteNode(tree,x);
	}
}

void avlDestroyTree(AVLTree* tree){
	avlDestroyTreeHelper(tree, tree->root->l);
	free(tree->root);
	free(tree->nil);
	free(tree);
}

#endif /* AVLTREE_H_ */

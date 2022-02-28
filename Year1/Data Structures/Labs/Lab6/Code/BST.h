#ifndef BST_H_
#define BST_H_

#include <stdlib.h>
/*
  IMPORTANT!

  As we stick to pure C, we cannot use templates. We will just assume
  some type T was previously defined.
 */

// -----------------------------------------------------------------------------

/*
 * !!!!ATENTION!!!!
 * 1. This implementation uses two sentinels (dummy nodes) root and nil.
 * 2. The convetion is that we always root the tree at root->l (the left of the root sentinel)
 */

typedef struct BSTNode{
	Item elem;
	struct BSTNode *p; // parent - not really needed, but simplifies implementation.
	struct BSTNode *l; // left child.
	struct BSTNode *r; // right child.
}BSTNode;

typedef struct BSTree{
	long size; // This inintially is 0, and is updated by insert/delete
	BSTNode *root; // The sentinel root (a sentinel not the actual root). The actual root node is root->l !
	BSTNode *nil; // The nil sentinel to avoid checks for NULL
}BSTree;

// TODO: Cerinta 1 si 2

/*
 * IMPLEMENTATION ORDER:
 * 1.  createTree
 * 2.  isEmpty
 * 3.  insert
 * 4.  search
 * 5.  minimum
 * 6.  maximum
 * 7.  successor 
 * 8.  predecessor
 * 9.  destroyTree
 */

BSTree* createTree()
{
	BSTree* t=(BSTree*)malloc(sizeof(BSTree));
	if(t == NULL) 
		return NULL;

	t->root=(BSTNode*)malloc(sizeof(BSTNode));
	t->nil=(BSTNode*)malloc(sizeof(BSTNode));

	t->size=0;

	t->root->l=t->nil;
	t->root->r=t->nil;
	t->root->p=t->nil;
	t->nil->l=t->nil;
	t->nil->r=t->nil;
	t->nil->p=t->nil;
	
	return t;
}

int isEmpty(BSTree *t)
{
	if(t->root->l == t->nil || t == NULL)
		return 1;
	return 0;
}

void insert(BSTree *t, Item elem)
{
	BSTNode* node=(BSTNode*)malloc(sizeof(BSTNode));
	node->elem=elem;
	node->l=t->nil;
	node->r=t->nil;
	
	if(t == NULL)
		t=createTree();

	if(isEmpty(t) == 1)
	{
		t->root->l=node;
		node->p=t->root;
		t->size++;
		return;
	}

	BSTNode *tmp=t->root->l;

	while(tmp != t->nil)
	{
		if(elem == tmp->elem)
		{
			free(node);			
			return;

		}
		if(elem < tmp->elem)
		{
			if(tmp->l == t->nil)
			{
				tmp->l=node;
				node->p=tmp;
				t->size++;
				return;
			}
			else
				tmp=tmp->l;
		}
		else if(elem > tmp->elem)
		{
			if(tmp->r == t->nil)
			{
				tmp->r=node;
				node->p=tmp;
				t->size++;
				return;
			}
			else
				tmp=tmp->r;
		}
	}
}

BSTNode* search(BSTree *t, Item elem)
{
	if(t == NULL)
		return NULL;

	BSTNode *tmp=t->root->l;	

	while(tmp != t->nil)
	{
		if(tmp->elem == elem)
			return tmp;

		if(elem < tmp->elem)
			tmp=tmp->l;
		else if(elem > tmp->elem)
			tmp=tmp->r;
	}

	if(tmp == t->nil)
		return NULL;
}

BSTNode* minimum(BSTree *t, BSTNode *n)
{
	if(isEmpty(t) == 1)
		return NULL;

	BSTNode *tmp=n;
	while(tmp->l != t->nil)
		tmp=tmp->l;

	return tmp;
}

BSTNode* maximum(BSTree *t, BSTNode *n)
{
	if(isEmpty(t) == 1)
		return NULL;

	BSTNode *tmp=n;
	while(tmp->r != t->nil)
		tmp=tmp->r;

	return tmp;
}

BSTNode* successor(BSTree *t, BSTNode *n)
{
	if(maximum(t,t->root->l) == n)
		return NULL	;	
	if(n->r != t->nil)
		return minimum(t, n->r);
	BSTNode *p=n->p;
	while(p!=t->root && n==p->r){
		n=p;
		p=p->p;
	}
	return p;
}

BSTNode* predecessor(BSTree *t, BSTNode *n)
{
	if(minimum(t,t->root->l) == n)
		return NULL	;	
	if(n->l != t->nil)
		return maximum(t, n->l);
	BSTNode *p=n->p;
	while(p!=t->root && n==p->l){
		n=p;
		p=p->p;
	}
	return p;
}


void destroyNode(BSTNode *t )
{	
	
	if(t->l == t)
		return;

	destroyNode(t->l);
	destroyNode(t->r);

	free(t);
}		

void destroyTree(BSTree *t)
{
   	destroyNode(t->root->l);
    	free(t->nil);
    	free(t->root);
	free(t);
	
}
void delete(BSTree* tree, Item elem){
	BSTNode* z; // node to be deleted
	BSTNode* y; // Node that is spliced out
	BSTNode* x; // The child of the sliced out node

	// Needed to maintain a similar interface as in the previous labs
	if( (z = search(tree,elem)) == tree->nil)
		return;

	/*
	 * Note:
	 * Case 1: The node has no children
	 * Case 2: The node has one child
	 * Case 3: The node has two children
	 */

	// Are we in cases 1,2 or in case 3
	y = ( (z->l == tree->nil) || (z->r == tree->nil) ) ? z : successor(tree, z);

	// Set x to the child of y
	x = (y->l == tree->nil) ? y->r : y->l;

	/*
	 * Note:
	 * There is no need to check if x is a valid pointer, we have the sentinels!
	 */
	if (tree->root == (x->p = y->p)) // assignment of y->p to x->p is intentional
		tree->root->l = x;
	else if (y == y->p->l)
		y->p->l = x;
	else
		y->p->r = x;

	if (y != z){

		/*
		 * Note:
		 * The data type T might be a very big structure, thus copying the key
		 * from one node to another might be very inefficient. It is better to
		 * modify the actual links.
		 */

		// y is the node to splice out and x is its child
		y->l = z->l;
		y->r = z->r;
		y->p = z->p;
		z->l->p = z->r->p = y;
		if (z == z->p->l) z->p->l = y;
		else z->p->r = y;
		free(z);
	} else {
		free(y);
	}

	tree->size--;
}

#endif /* BST_H_ */

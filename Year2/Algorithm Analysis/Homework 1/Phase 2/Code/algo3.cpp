//problema range minimum query folosind segment tree

#include <bits/stdc++.h> 
using namespace std; 
  
//structura interval
struct Query {
    int L, R;
};

//functie care intoarce valoarea minima dintre cei doi parametrii
int valMin(int x, int y) { 
    return (x < y)? x: y; 
}  
  
  
// returneaza indexul minim din interval  
int getMid(int l, int r) { 
    return l + (r -l)/2; 
}  
  

/*
Functia gaseste minimul in arbore
segTree-pointer catre arbore
index-indexul nodului curent
l,r- capetele intervalului studiat
ss,se-indicii nodului curent
*/
int RMQUtil(int *segTree, int ss, int se, int l, int r, int index)  
{  
    //daca segmentul face parte din intervalul dat se intoarce minimul 
    if (l <= ss && r >= se)  
        return segTree[index];  
  
    // daca nu face parte segmentul 
    if (se < l || ss > r)  
        return INT_MAX;  
  
    // daca o parte din segment coincide cu o parte din interval  
    int mid = getMid(ss, se);  
    return valMin(RMQUtil(segTree, ss, mid, l, r, 2*index+1),  
                RMQUtil(segTree, mid+1, se, l, r, 2*index+2));  
}  
  
//returneaza minimul intervalului dat  
int RMQ(int *segTree, int n, int l, int r)  
{   
    if (l < 0 || r > n-1 || l > r)  
    {  
        cout<<"Invalid Input";  
        return -1;  
    }  
  
    return RMQUtil(segTree, 0, n-1, l, r, 0);  
}  
  
// functie care construieste arborele pt un segment dat
int constructSTUtil(int arr[], int ss, int se, 
                                int *segTree, int si)  
{  
  
    if (ss == se)  
    {  
        segTree[si] = arr[ss];  
        return arr[ss];  
    }  
  
    int mid = getMid(ss, se);  
    segTree[si] = valMin(constructSTUtil(arr, ss, mid, segTree, si*2+1),  
                    constructSTUtil(arr, mid+1, se, segTree, si*2+2));  
    return segTree[si];  
}  
  
//construieste arborele de segmente pt vectorul dat
int *constructST(int arr[], int n)  
{  
    
  
    //inaltimea arborelui
    int x = (int)(ceil(log2(n)));  
  
    // marimea maxima a arborelui 
    int max_size = 2*(int)pow(2, x) - 1;  
  
    int *segTree = new int[max_size];  
    
    constructSTUtil(arr, 0, n-1, segTree, 0);  
  
    //returneaza arborele
    return segTree;  
}  
  

int main()  
{  

    for (int j = 0; j <= 8; j++) {
        
        string numeFisierIntrare;
        string numeFisierIesire;

        switch (j) {
            case 0:
                numeFisierIntrare = "in/test0.in";
                numeFisierIesire = "out/test0algo3.out";
                break;
            case 1:
                numeFisierIntrare = "in/test1.in";
                numeFisierIesire = "out/test1algo3.out";
                break;
            case 2:
                numeFisierIntrare = "in/test2.in";
                numeFisierIesire = "out/test2algo3.out";   
                break;
            case 3:
                numeFisierIntrare = "in/test3.in";
                numeFisierIesire = "out/test3algo3.out"; 
                break;
            case 4:
                numeFisierIntrare = "in/test4.in";
                numeFisierIesire = "out/test4algo3.out";  
                break;
            case 5:
                numeFisierIntrare = "in/test5.in";
                numeFisierIesire = "out/test5algo3.out"; 
                break;
            case 6:
                numeFisierIntrare = "in/test6.in";
                numeFisierIesire = "out/test6algo3.out"; 
                break;
            case 7:
                numeFisierIntrare = "in/test7.in";
                numeFisierIesire = "out/test7algo3.out";
                break;
            case 8:
                numeFisierIntrare = "in/test8.in";
                numeFisierIesire = "out/test8algo3.out";  
                break;
        }         

       	ifstream infile; 
        infile.open(numeFisierIntrare); 
        ofstream cout;
        cout.open(numeFisierIesire);

        //se citeste din fisier lungimea vectorului
        int lenVector;
        infile >> lenVector;

        //se citeste lungimea vectorului de intervale
        int lenQueryes;
        infile >> lenQueryes;


        //se citesc toate elementele
        int vectorulMeu[lenVector];
        for(int i = 0; i < lenVector; i++)
            infile >> vectorulMeu[i];
        int *segTree = constructST(vectorulMeu, lenVector);     
        

        //se citeste fiecare element in parte
        Query q[lenQueryes];
        for(int i = 0; i < lenQueryes; i++) {
            infile >> q[i].L;
            infile >> q[i].R;
            cout<<"Minimum of values in range [" << q[i].L << ", " <<
             		q[i].R << "] " << "is = " 
             		<< RMQ(segTree, lenVector, q[i].L, q[i].R) << endl;
        }
  		
  		infile.close();
  		cout.close();
  	}
    return 0;  
}  

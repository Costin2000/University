//problema range minimum query folosind sqrt decomposition

#include "iostream" 
#include "math.h" 
#include <fstream>
using namespace std; 
  
#define MAXN 10000 
#define SQRSIZE  100 
  
int copie[MAXN];//aici se salveaza vectorul original
int block[SQRSIZE];//aici se gaseste descompunerea vectorului
int blk_sz;//marimea unui block(radical din numarul de el al vectorului initial)
  
//structura interval
struct Query {
    int L, R;
};


// In cazul in care dorim modificarea vectorului pe parcurs
void update(int index, int val) 
{ 
    int blockNumber = index / blk_sz; 
    block[blockNumber] += val - copie[index]; 
    copie[index] = val; 
} 
  
// Time Complexity : O(sqrt(n)) 
int query(int l, int r) 
{ 
    //am initializat min cu cel mai mare integer posibil
    int min = 2147483647; 
    while (l < r and l % blk_sz != 0 and l != 0) 
    { 
        // traversam primul bloc
        if (min > copie[l])
            min = copie[l];
        l++;     
    } 
    while (l + blk_sz <= r) 
    { 
        // traversam blocurile intregi din interval
        if (block[l/blk_sz] < min)
            min = block[l/blk_sz]; 
        l = l + blk_sz;
    } 
    while (l<=r) 
    { 
        //traversam ultimul bloc
        if (min > copie[l])
            min = copie[l];
        l++;      
    } 
    return min; 
} 
  
//aici se face preprocesarea 
void preprocess(int vector[], int n) 
{ 
    //initializez indexul vectorului de blocuri 
    int blk_idx = 0; 
  
    // calculez marimea unui bloc 
    blk_sz = sqrt(n); 
  
    //am initializat min cu cel mai mare integer posibil
    int min=2147483647;
    
    // construiesc bvectorul de blocuri 
    for (int i = 0; i < n; i++) 
    { 
        //se gaseste minimul pentru fiecare bloc
        copie[i] = vector[i]; 
        if (min > copie[i])
        {
            min = copie[i];
            block[blk_idx]=min;
        }
        if ((i+1) % blk_sz == 0) 
        { 
            // se intra in urmatorul bloc 
            min=2147483647; 
            blk_idx++; 
        }  
    } 
} 
  
// Driver code 
int main() 
{ 
    for (int j = 0; j <= 8; j++) {
        
        string numeFisierIntrare;
        string numeFisierIesire;

        switch (j) {
            case 0:
                numeFisierIntrare = "in/test0.in";
                numeFisierIesire = "out/test0algo2.out";
                break;
            case 1:
                numeFisierIntrare = "in/test1.in";
                numeFisierIesire = "out/test1algo2.out";
                break;
            case 2:
                numeFisierIntrare = "in/test2.in";
                numeFisierIesire = "out/test2algo2.out";   
                break;
            case 3:
                numeFisierIntrare = "in/test3.in";
                numeFisierIesire = "out/test3algo2.out"; 
                break;
            case 4:
                numeFisierIntrare = "in/test4.in";
                numeFisierIesire = "out/test4algo2.out";  
                break;
            case 5:
                numeFisierIntrare = "in/test5.in";
                numeFisierIesire = "out/test5algo2.out"; 
                break;
            case 6:
                numeFisierIntrare = "in/test6.in";
                numeFisierIesire = "out/test6algo2.out"; 
                break;
            case 7:
                numeFisierIntrare = "in/test7.in";
                numeFisierIesire = "out/test7algo2.out";
                break;
            case 8:
                numeFisierIntrare = "in/test8.in";
                numeFisierIesire = "out/test8algo2.out";  
                break;
        }            

        ifstream infile; 
        infile.open(numeFisierIntrare); 

        ofstream cout;
        cout.open(numeFisierIesire);
        
        //se citeste din fisier lungimea vectorului
        int N;
        infile >> N;
        
        //se citeste lungimea vectorului de intervale
        int M;
        infile >> M;
        
        //se citesc toate elementele
        int vectorulMeu[N];
        for(int i = 0; i < N; i++)
            infile >> vectorulMeu[i];
        
        //int *st = constructST(vectorulMeu, lenVector);     
        
        preprocess(vectorulMeu, N);
        

        //se citeste fiecare element in parte
        Query q[M];
        for(int i = 0; i < M; i++) {
            infile >> q[i].L;
            infile >> q[i].R;
            //daca se doreste modificarea vectorului initial 
            //se poate decomenta urmatoarea indtructiune,
            //valorile date in ea fiind doar drept exemplu
            //update(8, 3);
            cout<<"Minimum of values in range [" << q[i].L << ", " <<
                    q[i].R << "] " << "is = " 
                    << query(q[i].L, q[i].R) << endl;
        }
        
        cout.close();
        infile.close();
        
    }

    return 0; 
} 
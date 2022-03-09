//implementarea find range minimum query cu algoritmul sparse table

#include <bits/stdc++.h>
using namespace std;
#define MAX 10000
 

//sparseTable[i][j] contine indexul elementului minim
//din intervalul [i,j]
int sparseTable[MAX][MAX];
 
// structura pentru query
struct Query {
    int L, R;
};
 

//in preprocesare se creeaza matricea sparseTable
void preprocesare(int arr[], int n)
{
    for (int i = 0; i < n; i++)
        sparseTable[i][0] = i;
 
    for (int j = 1; (1 << j) <= n; j++) 
    {

        for (int i = 0; (i + (1 << j) - 1) < n; i++) 
        {
            if (arr[sparseTable[i][j - 1]]
                < arr[sparseTable[i + (1 << (j - 1))][j - 1]])
                sparseTable[i][j] = sparseTable[i][j - 1];
            else
                sparseTable[i][j]
                    = sparseTable[i + (1 << (j - 1))][j - 1];
        }
    }
}
 
// returneaza minimul din intervalul [L,R]
//folosindu-ne de matricea sparseTable
//creeata la preprocesare
int findMin(int arr[], int L, int R)
{

    int j = (int)log2(R - L + 1);
    if (arr[sparseTable[L][j]]
        <= arr[sparseTable[R - (1 << j) + 1][j]])
        return arr[sparseTable[L][j]];
 
    else
        return arr[sparseTable[R - (1 << j) + 1][j]];
}
 
//primeste un vector de integers si un vector de intervale
//si gaseste pentru fiecare interval in parte elementul minim
//si il printeaza la dresa data ca parametru
void RMQ(int arr[], int n, Query q[], int m, string numeFisierIesire)
{
    //se creeaza sparseTable
    preprocesare(arr, n);
    
    //se deschide fisierul de iesire
    ofstream cout;
    cout.open(numeFisierIesire);

    //se ia fiecare query in parte
    for (int i = 0; i < m; i++) 
    {
        int L = q[i].L, R = q[i].R;
 
        //printeaza in fisier
        cout << "Minimum of [" << L << ", "
             << R << "] is "
             << findMin(arr, L, R) << endl;
    }
    cout.close();
}
 

int main()
{
    
    for (int j = 0; j <= 8; j++) {
        
        string numeFisierIntrare;
        string numeFisierIesire;

        switch (j) {
            case 0:
                numeFisierIntrare = "in/test0.in";
                numeFisierIesire = "out/test0algo1.out";
                break;
            case 1:
                numeFisierIntrare = "in/test1.in";
                numeFisierIesire = "out/test1algo1.out";
                break;
            case 2:
                numeFisierIntrare = "in/test2.in";
                numeFisierIesire = "out/test2algo1.out";   
                break;
            case 3:
                numeFisierIntrare = "in/test3.in";
                numeFisierIesire = "out/test3algo1.out"; 
                break;
            case 4:
                numeFisierIntrare = "in/test4.in";
                numeFisierIesire = "out/test4algo1.out";  
                break;
            case 5:
                numeFisierIntrare = "in/test5.in";
                numeFisierIesire = "out/test5algo1.out"; 
                break;
            case 6:
                numeFisierIntrare = "in/test6.in";
                numeFisierIesire = "out/test6algo1.out"; 
                break;
            case 7:
                numeFisierIntrare = "in/test7.in";
                numeFisierIesire = "out/test7algo1.out";
                break;
            case 8:
                numeFisierIntrare = "in/test8.in";
                numeFisierIesire = "out/test8algo1.out";  
                break;
        }                 

        
        ifstream infile; 
        infile.open(numeFisierIntrare); 
        
        //se citeste din fisier lungimea vectorului
        int N=0;
        infile >> N;
        

        //se citeste lungimea vectorului de intervale
        int M=0;
        infile >> M;

        //se citesc toate elementele
        int vectorulMeu[N];
        for(int i = 0; i < N; i++)
            infile >> vectorulMeu[i]; 
        
        
        //se citeste fiecare element in parte
        Query q[M];
        for(int i = 0; i < M; i++) {
            infile >> q[i].L;
            infile >> q[i].R;
        }

        //se apeleaza functia cu datele citite din fisier
        RMQ(vectorulMeu, N, q, M, numeFisierIesire);
        infile.close();
    }
    
    return 0;
}

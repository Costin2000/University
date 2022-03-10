#include <stdio.h>
#include <stdlib.h>


int max(int a, int b) {
    if(a<b)
        return b;
    return a;
}


int numarSume(int arr[], int l, int m){
    int sum=0,ans=0;

    for(int i=0;i<l;i++) {
        sum+=arr[i];
    }

    int DP[l+2][sum+2];
    for(int i=0;i<l+2;i++){
        for(int j=0;j<sum+2;j++){
            DP[i][j]=0;
        }
    }

    for(int j=1;j<sum+2;j++){
        DP[0][j]=j-1;
    }

    DP[1][0]=0;
    for(int j=2;j<l+2;j++){
        DP[j][0]=arr[j-2];
    }

    for(int i=1;i<l+2;i++){
        DP[i][1]=1;
    }

    for(int i=2;i<l+2;i++){
        for(int j=1;j<sum+2;j++){
            if(DP[i-1][j]!=0){
                DP[i][j+arr[i-2]]=DP[i-1][j+arr[i-2]]+DP[i-1][j];
            }
        }
        for(int j=1;j<sum+2;j++){
            DP[i][j]=max(DP[i-1][j],DP[i][j]);
        }
    }

    for(int j=1;j<sum+2;j++){
        if((j-1)%m==0)
            ans+=DP[l+1][j];
    }

    printf("Number of subsets is: %d", ans-1);
    return 0;
}

//D[i] = D[i-1] + D[i-k]
int kGard (int k , int n) {
    int vec[n];
    vec[0] = 1;
    vec[1] = 1;

    for(int i = 2; i <= n; i++) {
        if((i - k) < 0)
            vec[i] = vec[i-1] + 0;
        else
            vec[i] = vec[i-1] + vec[i-k];
    }

    return vec[n];

}


int main()
{
    //Pb2
    //-------------------------------------
    printf("Numarul de posibilitati este %d \n", kGard(2,6));
    //-------------------------------------

    //Pb3
    //-------------------------------------
    int arr[]={3,1,2,4};
    int l=4;
    int m=3;
    numarSume(arr, l, m);
    //-------------------------------------
}

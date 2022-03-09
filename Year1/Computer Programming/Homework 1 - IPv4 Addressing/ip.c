//Nume student: Barus Catalin-Stefan
//Grupa: 311CD

#include <stdio.h>

void afiseaza(int n, int j) //afiseaza un numar in baza 2
{
    int i, b;
    for(i=sizeof(int)*2-1; i>=0; i--)
    {
        b=(n&(1<<i))?1:0;
        printf("%d", b);
    }
    if(j<4)
        printf(".");
    else
        printf("\n");
}

void ip(int ip1, int ip2, int ip3, int ip4) //preia cate un octet din ip si il afiseaza in baza 2
{
    afiseaza(ip1, 1);
    afiseaza(ip2, 2);
    afiseaza(ip3, 3);
    afiseaza(ip4, 4);
}

unsigned int cm(int n, int i) //cm(create mask) creaza un octet ales din masca
{
    unsigned int mask=0;
    int k=0, ip_count=31;
    while(k<n)
    {
        mask=mask|(1<<ip_count);
        ip_count--;
        k++;
    }
    if(i==1)
        return (mask>>24);
    else if(i==2)
        return ((mask<<8)>>24);
    else if(i==3)
        return ((mask<<16)>>24);
    else
        return ((mask<<24)>>24);
}

int broad(int ip, int m) //determina adresa de broadcast pentru o pereche de octeti
{
    int broad;
    broad=ip|(255-m);
    return broad;
}

int retea(int ip, int m) //determina adresa de retea pentru o pereche de octeti
{
    int ret;
    ret=ip&m;
    return ret;
}

int rightmask(int m1, int m2, int m3, int m4) //verifica corectitudinea unei masti
{
    unsigned int masca;
    masca=(m1<<24)+(m2<<16)+(m3<<8)+m4;
    if(masca==0)
        return 0;
    if(masca&(~masca>>1))
        return 0;
    else
        return 1;
}

void correctmask(int m1, int m2, int m3, int m4) //corecteaza o masca
{
    int i, k;
    unsigned int masca;
    masca=(m1<<24)+(m2<<16)+(m3<<8)+m4;
    for(i=31; i>=0; i--)
    {
        if((masca&(1<<i))==0)
        {
            k=i;
            break;
        }
    }
    for(i=31; i>=0; i--)
    {
        masca=masca&(~(1<<(k-1)));
        k--;
        if(k==0)
            break;
    }
    printf("%u.%u.", (masca>>24), (masca<<8)>>24);
    printf("%u.%u\n", (masca<<16)>>24, (masca<<24)>>24);
}

int net(int ip, int m, int i) //functie folosita pentru a minimiza complexitatea determnarii adresei de retea
{
    return retea(ip, cm(m, i));
}

int main()
{
    int m1, m2, m3, m4, ip1, ip2, ip3, ip4, msk_2, set; //folosite pentru MSK_1 si IP_1
    int i, nrset; //un contor "i", folosit pentru structurile repetitive si "nrset" folosit pentru lista de adrese
    int ip2_1, ip2_2, ip2_3, ip2_4; //folosite pentru IP_2
    int net1, net2, net3, net4, net5, net6, net7, net8; //folosite pentru determinarea adresei de retea
    int adrese[1000000], indice=0, nrip, nrip_max; //un vector pentru stocarea indicilor adreselor de retea
    int iplis_1, iplis_2, iplis_3, iplis_4, masklis; //folosite pentru adresele ip din lista
    scanf("%d", &set);
    for(nrset=1; nrset<=set; nrset++)
    {
        printf("%d\n", nrset);
        scanf("%d.%d.%d.%d", &m1, &m2, &m3, &m4);
        scanf("%d", &msk_2);
        scanf("%d.%d.%d.%d", &ip1, &ip2, &ip3, &ip4);
        scanf("%d.%d.%d.%d", &ip2_1, &ip2_2, &ip2_3, &ip2_4);
        scanf("%d", &nrip_max);
        for(nrip=0; nrip<nrip_max; nrip++)
        {
            scanf("%d.%d.%d.%d/%d", &iplis_1, &iplis_2, &iplis_3, &iplis_4, &masklis);
            if(net(iplis_1, masklis, 1)==net(ip2_1, masklis, 1))
                if(net(iplis_2, masklis, 2)==net(ip2_2, masklis, 2))
                    if(net(iplis_3, masklis, 3)==net(ip2_3, masklis, 3))
                        if(net(iplis_4, masklis, 4)==net(ip2_4, masklis, 4))
                        {
                            adrese[indice]=nrip;
                            indice++;
                        }
        }
        printf("-0 %d.%d.%d.%d/%d\n", ip1, ip2, ip3, ip4, msk_2);
        printf("-1 ");
        printf("%u.%u.%u.%u\n", cm(msk_2, 1), cm(msk_2, 2), cm(msk_2,3), cm(msk_2, 4));
        printf("-2 %o.%o.%o.%o ", m1, m2, m3, m4);
        printf("%X.%X.%X.%X\n", m1, m2, m3, m4);
        printf("-3 ");
        printf("%d.%d.", retea(ip1, cm(msk_2, 1)), retea(ip2, cm(msk_2, 2)));
        printf("%d.%d\n", retea(ip3, cm(msk_2, 3)), retea(ip4, cm(msk_2, 4)));
        printf("-4 ");
        printf("%d.%d.", broad(ip1, cm(msk_2, 1)), broad(ip2, cm(msk_2, 2)));
        printf("%d.%d\n", broad(ip3, cm(msk_2, 3)), broad(ip4, cm(msk_2, 4)));
        printf("-5 ");
        net1=retea(ip1, cm(msk_2, 1));
        net2=retea(ip2, cm(msk_2, 2));
        net3=retea(ip3, cm(msk_2, 3));
        net4=retea(ip4, cm(msk_2, 4));
        net5=retea(ip2_1, cm(msk_2, 1));
        net6=retea(ip2_2, cm(msk_2, 2));
        net7=retea(ip2_3, cm(msk_2, 3));
        net8=retea(ip2_4, cm(msk_2, 4));
        if(net1==net5 && net2==net6 && net3==net7 && net4==net8)
            printf("DA\n");
        else
            printf("NU\n");
        printf("-6 ");
        if(rightmask(m1, m2, m3, m4)==1)
            printf("DA\n");
        else
            printf("NU\n");
        printf("-7 ");
        if(rightmask(m1, m2, m3, m4)==1)
            printf("%d.%d.%d.%d\n", m1, m2, m3, m4);
        else
            correctmask(m1, m2, m3, m4);
        printf("-8 ");
        ip(ip1, ip2, ip3, ip4);
        printf("-9 ");
        for(i=0; i<indice; i++)
            printf("%d ", adrese[i]);
        for(i=0; i<indice; i++)
            adrese[i]=0;
        indice=0;
        printf("\n");
    }
    return 0;
}


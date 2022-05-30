#include <stdio.h>
#include <math.h>
#include <ctype.h>
#ifdef NAN
#endif
#define n 3 // Matrix Capacity

int main()
{
    int b, y, z, e, i, j, k;
    int c = 0;
    double x;
    char answer;
    double a[n][n + 1];
    double res[n];
    FILE* in;
    FILE* out;
    FILE* equation;
    in = fopen("input.txt", "a+");
    out = fopen("output.txt", "w+");
    equation = fopen("equations.txt", "r");
    
        

    

    if (in == NULL || out == NULL)
    {
        printf("File couldn't be opened\n");
        return -1;
    }

    for (c = 0; c < n; c++)
    {
        fscanf(equation, "%dx%dy%dz=%d\n", &b, &y, &z, &e);
        fprintf(in, "%d %d %d %d\n", b, y, z, e);
        for (j = 0; j < n + 1; j++)
        {
            fscanf(in, "%d", &a[c][j]);
        }
    }


    for (i = 0; i < n; i++) // Initialization of the resulting array with zeros
    {
        res[i] = 0;
    }

    for (k = 0; k < n; k++)
    {
        x = fabs(a[k][k]);
        i = k;
        for (j = k + 1; j < n; j++)
        {
            if (fabs(a[j][k]) > x)
            {
                i = j;
                x = fabs(a[j][k]);
            }
        }


        if (i != k) //Change lines
        {
            for (j = k; j < n + 1; j++)
            {
                x = a[k][j];
                a[k][j] = a[i][j];
                a[i][j] = x;
            }
        }

        for (i = k + 1; i < n; i++) //Let's transform the strings.
        {
            x = a[i][k] / a[k][k];      //Row Factor
            for (j = k; j < n + 1; j++) //Converting the elements of a string.
            {
                a[i][j] -= x * a[k][j];
            }
        }
    }

    for (i = n - 1; i >= 0; i--)
    {
        x = a[i][n];
        for (j = n - 1; j >= i; j--)
        {
            if (j > i)
            {
                x -= res[j] * a[i][j];
            }
            if (j == i)
            {
                x /= a[i][j];
            }
        }
        res[i] = x;
    }

    for (i = 0; i < n; i++)
    {
        fprintf(out, "x%d = %lf\n", i + 1, res[i]);
    }
    
}

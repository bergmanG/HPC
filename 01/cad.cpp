#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
double *linha_por_coluna(double **matriz, double *vetor);
double *coluna_por_coluna(double **matriz, double *vetor);
void vector_fill_random(double *array);
void matrix_fill_random(double **matriz);

int matriz_size;

int main(int argc, char *argv[])
{
    matriz_size = atoi(argv[1]);

    double **matriz = new double *[matriz_size];
    for (int i = 0; i < matriz_size; i++)
        matriz[i] = new double[matriz_size];

    double *vetor = new double[matriz_size];
    matrix_fill_random(matriz);
    vector_fill_random(vetor);

    /*
    printf("Matriz:\n");
    for (int i = 0; i < matriz_size; i++)
    {
        for (int j = 0; j < matriz_size; j++)
        {
            printf("%f ", matriz[i][j]);
        }
    }
    printf("\n");

    printf("Vector:\n");
    for (int i = 0; i < matriz_size; i++)
    {
        printf("%f ", vetor[i]);
    }
    printf("\n");
    */
    clock_t start, end;
    double cpu_time_used;

    start = clock();
    double *result = linha_por_coluna(matriz, vetor);
    end = clock();
    cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
    printf("linha_por_coluna took %f seconds to execute \n", cpu_time_used);

    /*printf("Resultado:\n");
    for (int i = 0; i < matriz_size; i++)
    {
        printf("%f ", result[i]);
    }
    printf("\n");*/

    start = clock();
    double *result2 = coluna_por_coluna(matriz, vetor);
    end = clock();
    cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
    printf("coluna_por_coluna took %f seconds to execute \n", cpu_time_used);

    /*printf("Resultado:\n");
    for (int i = 0; i < matriz_size; i++)
    {
        printf("%f ", result2[i]);
    }
    printf("\n");*/
}

double *linha_por_coluna(double **matriz, double *vetor)
{
    double *b = new double[matriz_size]{0};

    for (int i = 0; i < matriz_size; i++)
    {
        for (int j = 0; j < matriz_size; j++)
        {
            b[i] += matriz[i][j] * vetor[j];
        }
    }
    return b;
}

double *coluna_por_coluna(double **matriz, double *vetor)
{
    double *b = new double[matriz_size]{0};

    for (int i_v = 0; i_v < matriz_size; i_v++)
    {
        for (int i_m = 0; i_m < matriz_size; i_m++)
        {
            b[i_m] += matriz[i_m][i_v] * vetor[i_v];
        }
    }
    return b;
}

void vector_fill_random(double *array)
{
    for (int i = 0; i < matriz_size; i++)
    {
        double rng = 2 * ((double)rand() / (double)RAND_MAX) - 1;
        array[i] = rng;
    }
}

void matrix_fill_random(double **matriz)
{
    for (int i = 0; i < matriz_size; i++)
    {
        for (int j = 0; j < matriz_size; j++)
        {
            double rng = 2 * ((double)rand() / (double)RAND_MAX) - 1;
            matriz[i][j] = rng;
        }
    }
}
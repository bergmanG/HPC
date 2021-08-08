
program hello
    integer::matriz_size
    double precision, dimension(:,:), allocatable :: matriz 
    double precision, dimension(:), allocatable :: vetor
    double precision, dimension(:), allocatable :: result_lpc
    double precision, dimension(:), allocatable :: result_cpc
    real    ::  T1,T2 

    read *, matriz_size
    allocate(matriz(matriz_size,matriz_size))
    allocate(vetor(matriz_size))
    call matrix_fill_random(matriz)
    call vector_fill_random(vetor)

    !do z = 1, matriz_size
    !    do w = 1, matriz_size
    !        write(*,*) matriz(z,w)
    !    end do
    !end do
    !write(*,*) "\n"

    !do z = 1, matriz_size
    !    write(*,*) vetor(z)
    !end do
    !write(*,*) "\n"

    call cpu_time(T1)
    result_lpc = linha_por_coluna(matriz,vetor)
    call cpu_time(T2)
    print *, T2-T1

    !do z = 1, matriz_size
    !    write(*,*) result_lpc(z)
    !end do
    !write(*,*) "\n"

    call cpu_time(T1)
    result_cpc = coluna_por_coluna(matriz,vetor)
    call cpu_time(T2)
    print *, T2-T1

    !do z = 1, matriz_size
    !    write(*,*) result_cpc(z)
    !end do

contains

    subroutine vector_fill_random(array)
        double precision, dimension(:) :: array 
        double precision :: rng
        do n = 1, size(array)
            call random_number(rng)
            array(n) = rng
        end do
    end subroutine

    subroutine matrix_fill_random(matrix)
        double precision, dimension(:,:) :: matrix 
        double precision :: rng
        integer, dimension(2)  :: m_shape
        m_shape = shape(matrix)
        do n = 1, m_shape(1)
            do m = 1, m_shape(1)
                call random_number(rng)
                matrix(n,m) = rng
            end do
        end do
    end subroutine

    FUNCTION linha_por_coluna(matriz, vetor)  RESULT( b )

    double precision, dimension(:,:), intent(in) :: matriz
    double precision, dimension(:), intent(in) :: vetor 
    double precision, DIMENSION( SIZE(vetor) ) :: b
    b = 0.0

    do i = 1, size(vetor)
        do j = 1, size(vetor)
            b(i) = b(i) + matriz(i,j)*vetor(j)
        end do
    end do              
   END
   
   FUNCTION coluna_por_coluna(matriz, vetor)  RESULT( b )

    double precision, dimension(:,:), intent(in) :: matriz
    double precision, dimension(:), intent(in) :: vetor 
    double precision, DIMENSION( SIZE(vetor) ) :: b
    b = 0.0

    do i_v = 1, size(vetor)
        do i_m = 1, size(vetor)
            b(i_m) = b(i_m) + matriz(i_m,i_v)*vetor(i_v)
        end do
    end do              
   END

end program hello
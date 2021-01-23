
! Lapsrate_diffusion.f90
!*************************************************************************

!---------------------------------------------------------------------------

SUBROUTINE Lapsrate_diffusion (nx, ny, orography, Temp, Tsurf)

IMPLICIT NONE
INCLUDE 'ebm.inc'

integer,intent(in):: nx,ny 
real,intent(in):: orography(nx,ny)

real, intent(inout):: Temp(nx,ny)
real, intent(out):: Tsurf(nx,ny)
integer :: i,j


! Lapsrate 
real,parameter:: Laps_rate = 0.007               ! K/m







   
           
! Assign the correct value of the heat capacity of the columns
 
do i = 1, nx
  do j = 1, ny
    !Temp(i,j) = 10.
    Tsurf(i,j) = Temp(i,j) - orography(i,j) * Laps_rate
    write(*,*) i,j,Tsurf(i,j),Temp(i,j),orography(i,j)                         
  end do
end do  



END SUBROUTINE




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


! Lapsrate 
real,parameter:: Laps_rate = 0.007               ! K/m







   
           
! Assign the correct value of the heat capacity of the columns
 do j = 1, ny
   do i = 1, nx
    
                               
   end do
 end do  



END SUBROUTINE



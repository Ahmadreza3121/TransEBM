! Read land masks from the preprocess into the EBM main code

      subroutine orography_input(orography, filename)
      implicit none
      include 'netcdf.inc'

!     This is the name of the data file we will create.
      character*(*) filename
!      parameter (filename = '../input/orography.nc')
      integer ncid
      real error 
      parameter(error = 1.0e-10)

!     We are reading a orography map with spatial resolutions of 2.8125 degrees both longitudinal and latitudinal
!     So we will have a grid of 128 longitude X 65 latitude
      integer NDIMS
      parameter (NDIMS = 2)
      integer NLATS, NLONS
      parameter (NLATS = 65, NLONS = 128)
      character*(*) LAT_NAME, LON_NAME
      parameter (LAT_NAME = 'latitude', LON_NAME = 'longitude')
      integer lon_dimid, lat_dimid

      integer start(NDIMS), count(NDIMS)
      data start /1,1/
      data count /NLONS,NLATS/

      real lats(NLATS), lons(NLONS)
      integer lon_varid, lat_varid

      character*(*) ORO_NAME
      parameter (oro_NAME='Topo')
      integer ORO_varid
      integer dimids(NDIMS)

!     We define each variable a "units" attribute.
      character*(*) UNITS
      parameter (UNITS = 'units')
      character*(*) ORO_UNITS, LAT_UNITS, LON_UNITS
      parameter (ORO_UNITS = 'm')
      parameter (LAT_UNITS = 'degrees_north')
      parameter (LON_UNITS = 'degrees_east')

      integer orography(NLONS, NLATS)

!     Our grid starts from upper right corner at longitude 0 degree and latitude 90 degree (0,90)
      integer START_LAT, START_LON
      parameter (START_LAT = 90.0, START_LON = -180.0)

!     Loop indices.
      integer lat, lon, i

!     Error handling.
      integer retval


!     Create grid in real longitude and latitude.
      do lat = 1, NLATS
         lats(lat) = START_LAT - (lat - 1) * 2.8125
      end do
      do lon = 1, NLONS
         lons(lon) = START_LON + lon * 2.8125
      end do

!     Open the file. 
      retval = nf_open(filename, nf_nowrite, ncid)

!     Get the varids of the latitude and longitude coordinate variables.
      retval = nf_inq_varid(ncid, LAT_NAME, lat_varid)
      retval = nf_inq_varid(ncid, LON_NAME, lon_varid)
  
!     Read the latitude and longitude data.
      retval = nf_get_var_real(ncid, lat_varid, lats)
      retval = nf_get_var_real(ncid, lon_varid, lons)

!     Assign units attributes to coordinate variables.
      retval = nf_put_att_text(ncid, lat_varid, UNITS, len(LAT_UNITS), LAT_UNITS)
      retval = nf_put_att_text(ncid, lon_varid, UNITS, len(LON_UNITS), LON_UNITS)
  
!     Check to make sure we got what we expected 
!     The input netcdf should STRICTLY follow predefined lon-lat grid 
      do lat = 1, NLATS
         if (abs(lats(lat)-(START_LAT - (lat - 1) * 2.8125)) .gt. error) STOP 'Error: Wrong latitude'
      end do
      do lon = 1, NLONS
         if (abs(lons(lon)-(START_LON + lon  * 2.8125)) .gt. error) STOP 'Error: Wrong longitude'
      end do

!     Get the varids of the orography netCDF variables.
      retval = nf_inq_varid(ncid, ORO_NAME, ORO_varid)
      
!     Read the surface ALBEDO data from the file
      retval = nf_get_vara_int(ncid, ORO_varid, start, count, orography)
 
!     Close the dat file and make sure your data are really written to disk.
      retval = nf_close(ncid)
      
      print *,'SUCCESSFULLY read orography from [', filename,'] into simulation!'
!      write(2,*)'SUCCESSFULLY read orography from [', filename,'] into simulation!'      
      end


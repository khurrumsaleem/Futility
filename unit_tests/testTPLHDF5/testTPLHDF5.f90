!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!
!                              Copyright (C) 2012                              !
!                   The Regents of the University of Michigan                  !
!              MPACT Development Group and Prof. Thomas J. Downar              !
!                             All rights reserved.                             !
!                                                                              !
! Copyright is reserved to the University of Michigan for purposes of          !
! controlled dissemination, commercialization through formal licensing, or     !
! other disposition. The University of Michigan nor any of their employees,    !
! makes any warranty, express or implied, or assumes any liability or          !
! responsibility for the accuracy, completeness, or usefulness of any          !
! information, apparatus, product, or process disclosed, or represents that    !
! its use would not infringe privately owned rights. Reference herein to any   !
! specific commercial products, process, or service by trade name, trademark,  !
! manufacturer, or otherwise, does not necessarily constitute or imply its     !
! endorsement, recommendation, or favoring by the University of Michigan.      !
!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!
PROGRAM testTPLHDF5
  
#ifdef HAVE_HDF5
  USE HDF5
#endif

  IMPLICIT NONE

  WRITE(*,*) '==================================================='
  WRITE(*,*) 'TESTING HDF5 TPL...'
  WRITE(*,*) '==================================================='

#ifdef HAVE_HDF5
  CALL testHDF5()
#else
  WRITE(*,*) ' HDF5 not enabled!'
#endif
  
  WRITE(*,*) '==================================================='
  WRITE(*,*) 'TESTING HDF5 TPL PASSED!'
  WRITE(*,*) '==================================================='

!
!===============================================================================
  CONTAINS
!
!-------------------------------------------------------------------------------
    SUBROUTINE testHDF5()
#ifdef HAVE_HDF5
#endif
    ENDSUBROUTINE testHDF5

ENDPROGRAM

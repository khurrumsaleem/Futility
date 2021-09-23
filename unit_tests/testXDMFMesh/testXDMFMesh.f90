!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!
!                          Futility Development Group                          !
!                             All rights reserved.                             !
!                                                                              !
! Futility is a jointly-maintained, open-source project between the University !
! of Michigan and Oak Ridge National Laboratory.  The copyright and license    !
! can be found in LICENSE.txt in the head directory of this repository.        !
!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!
PROGRAM testXDMFMesh
#include "UnitTest.h"
USE ISO_FORTRAN_ENV
USE UnitTest
USE IntrType
USE Strings
USE XDMFMesh
USE Geom
IMPLICIT NONE

REAL(SDK) :: two_pins_pin1_vertices(3,109) = RESHAPE( (/ &
    0.0000000000000000_SDK,   0.0000000000000000_SDK,   0.0000000000000000_SDK,&
    2.0000000000000000_SDK,   0.0000000000000000_SDK,   0.0000000000000000_SDK,&
    0.0000000000000000_SDK,   2.0000000000000000_SDK,   0.0000000000000000_SDK,&
    2.0000000000000000_SDK,   2.0000000000000000_SDK,   0.0000000000000000_SDK,&
    1.5000000000000000_SDK,   1.0000000000000000_SDK,   0.0000000000000000_SDK,&
   0.50000000000000000_SDK,   0.0000000000000000_SDK,   0.0000000000000000_SDK,&
    1.0000000000000000_SDK,   0.0000000000000000_SDK,   0.0000000000000000_SDK,&
    1.5000000000000000_SDK,   0.0000000000000000_SDK,   0.0000000000000000_SDK,&
   0.25000000000000000_SDK,   0.0000000000000000_SDK,   0.0000000000000000_SDK,&
   0.75000000000000000_SDK,   0.0000000000000000_SDK,   0.0000000000000000_SDK,&
    1.2500000000000000_SDK,   0.0000000000000000_SDK,   0.0000000000000000_SDK,&
    1.7500000000000000_SDK,   0.0000000000000000_SDK,   0.0000000000000000_SDK,&
    0.0000000000000000_SDK,   1.5000000000000000_SDK,   0.0000000000000000_SDK,&
    0.0000000000000000_SDK,   1.0000000000000000_SDK,   0.0000000000000000_SDK,&
    0.0000000000000000_SDK,  0.50000000000000000_SDK,   0.0000000000000000_SDK,&
    0.0000000000000000_SDK,   1.7500000000000000_SDK,   0.0000000000000000_SDK,&
    0.0000000000000000_SDK,   1.2500000000000000_SDK,   0.0000000000000000_SDK,&
    0.0000000000000000_SDK,  0.75000000000000000_SDK,   0.0000000000000000_SDK,&
    0.0000000000000000_SDK,  0.25000000000000000_SDK,   0.0000000000000000_SDK,&
    2.0000000000000000_SDK,  0.50000000000000000_SDK,   0.0000000000000000_SDK,&
    2.0000000000000000_SDK,   1.0000000000000000_SDK,   0.0000000000000000_SDK,&
    2.0000000000000000_SDK,   1.5000000000000000_SDK,   0.0000000000000000_SDK,&
    2.0000000000000000_SDK,  0.25000000000000000_SDK,   0.0000000000000000_SDK,&
    2.0000000000000000_SDK,  0.75000000000000000_SDK,   0.0000000000000000_SDK,&
    2.0000000000000000_SDK,   1.2500000000000000_SDK,   0.0000000000000000_SDK,&
    2.0000000000000000_SDK,   1.7500000000000000_SDK,   0.0000000000000000_SDK,&
    1.5000000000000000_SDK,   2.0000000000000000_SDK,   0.0000000000000000_SDK,&
    1.0000000000000000_SDK,   2.0000000000000000_SDK,   0.0000000000000000_SDK,&
   0.50000000000000000_SDK,   2.0000000000000000_SDK,   0.0000000000000000_SDK,&
    1.7500000000000000_SDK,   2.0000000000000000_SDK,   0.0000000000000000_SDK,&
    1.2500000000000000_SDK,   2.0000000000000000_SDK,   0.0000000000000000_SDK,&
   0.75000000000000000_SDK,   2.0000000000000000_SDK,   0.0000000000000000_SDK,&
   0.25000000000000000_SDK,   2.0000000000000000_SDK,   0.0000000000000000_SDK,&
    1.3117449009294000_SDK,   1.3909157412340001_SDK,   0.0000000000000000_SDK,&
   0.88873953302183994_SDK,   1.4874639560909000_SDK,   0.0000000000000000_SDK,&
   0.54951556604879004_SDK,   1.2169418695587999_SDK,   0.0000000000000000_SDK,&
   0.54951556604879004_SDK,  0.78305813044121997_SDK,   0.0000000000000000_SDK,&
   0.88873953302183994_SDK,  0.51253604390909002_SDK,   0.0000000000000000_SDK,&
    1.3117449009294000_SDK,  0.60908425876599004_SDK,   0.0000000000000000_SDK,&
    1.4504844339512000_SDK,   1.2169418695587999_SDK,   0.0000000000000000_SDK,&
    1.1112604669782000_SDK,   1.4874639560909000_SDK,   0.0000000000000000_SDK,&
   0.68825509907062998_SDK,   1.3909157412340001_SDK,   0.0000000000000000_SDK,&
   0.50000000000000000_SDK,   1.0000000000000000_SDK,   0.0000000000000000_SDK,&
   0.68825509907062998_SDK,  0.60908425876599004_SDK,   0.0000000000000000_SDK,&
    1.1112604669782000_SDK,  0.51253604390909002_SDK,   0.0000000000000000_SDK,&
    1.4504844339512000_SDK,  0.78305813044121997_SDK,   0.0000000000000000_SDK,&
    1.0000000000000000_SDK,   1.0000000000000000_SDK,   0.0000000000000000_SDK,&
    1.1558724504647000_SDK,   1.1954578706170000_SDK,   0.0000000000000000_SDK,&
    1.2500000000000000_SDK,   1.0000000000000000_SDK,   0.0000000000000000_SDK,&
   0.94436976651091997_SDK,   1.2437319780455001_SDK,   0.0000000000000000_SDK,&
    1.1558724504647000_SDK,  0.80454212938298997_SDK,   0.0000000000000000_SDK,&
   0.77475778302440002_SDK,   1.1084709347794000_SDK,   0.0000000000000000_SDK,&
   0.77475778302440002_SDK,  0.89152906522061004_SDK,   0.0000000000000000_SDK,&
   0.94436976651091997_SDK,  0.75626802195454002_SDK,   0.0000000000000000_SDK,&
   0.39945256244833000_SDK,   1.6005474375516999_SDK,   0.0000000000000000_SDK,&
   0.39945256244833000_SDK,  0.39945256244833000_SDK,   0.0000000000000000_SDK,&
    1.6749575669735000_SDK,  0.67495756697348996_SDK,   0.0000000000000000_SDK,&
    1.6749575669735000_SDK,   1.3250424330265000_SDK,   0.0000000000000000_SDK,&
    1.6076357762794000_SDK,   1.6521790377186001_SDK,   0.0000000000000000_SDK,&
    1.6076357762794000_SDK,  0.34782096228136000_SDK,   0.0000000000000000_SDK,&
    1.2323349413967000_SDK,   1.7035415484495000_SDK,   0.0000000000000000_SDK,&
    1.2323349413967000_SDK,  0.29645845155054001_SDK,   0.0000000000000000_SDK,&
   0.27475778302440002_SDK,  0.89152906522061004_SDK,   0.0000000000000000_SDK,&
   0.27475778302440002_SDK,   1.1084709347794000_SDK,   0.0000000000000000_SDK,&
   0.27475778302440002_SDK,  0.64152906522061004_SDK,   0.0000000000000000_SDK,&
   0.27475778302440002_SDK,   1.3584709347794000_SDK,   0.0000000000000000_SDK,&
   0.94436976651091997_SDK,  0.25626802195454002_SDK,   0.0000000000000000_SDK,&
   0.69436976651091997_SDK,  0.25626802195454002_SDK,   0.0000000000000000_SDK,&
   0.69436976651091997_SDK,   1.7437319780455001_SDK,   0.0000000000000000_SDK,&
   0.94436976651091997_SDK,   1.7437319780455001_SDK,   0.0000000000000000_SDK,&
   0.44972628122415997_SDK,   1.8002737187758000_SDK,   0.0000000000000000_SDK,&
   0.64409604773508999_SDK,   1.5440056968213001_SDK,   0.0000000000000000_SDK,&
   0.64409604773508999_SDK,  0.45599430317870998_SDK,   0.0000000000000000_SDK,&
   0.44972628122415997_SDK,  0.19972628122416000_SDK,   0.0000000000000000_SDK,&
   0.47448406424855999_SDK,   1.4087446535552000_SDK,   0.0000000000000000_SDK,&
   0.19972628122416000_SDK,   1.5502737187758000_SDK,   0.0000000000000000_SDK,&
   0.19972628122416000_SDK,  0.44972628122415997_SDK,   0.0000000000000000_SDK,&
   0.47448406424855999_SDK,  0.59125534644476996_SDK,   0.0000000000000000_SDK,&
    1.8038178881397000_SDK,  0.42391048114067997_SDK,   0.0000000000000000_SDK,&
    1.8038178881397000_SDK,  0.17391048114068000_SDK,   0.0000000000000000_SDK,&
    1.8038178881397000_SDK,   1.8260895188593000_SDK,   0.0000000000000000_SDK,&
    1.8038178881397000_SDK,   1.5760895188593000_SDK,   0.0000000000000000_SDK,&
   0.19972628122416000_SDK,  0.19972628122416000_SDK,   0.0000000000000000_SDK,&
   0.19972628122416000_SDK,   1.8002737187758000_SDK,   0.0000000000000000_SDK,&
    1.5538178881397000_SDK,  0.17391048114068000_SDK,   0.0000000000000000_SDK,&
    1.5538178881397000_SDK,   1.8260895188593000_SDK,   0.0000000000000000_SDK,&
    1.1161674706983999_SDK,  0.14822922577527001_SDK,   0.0000000000000000_SDK,&
    1.0605372372093000_SDK,  0.40449724772981999_SDK,   0.0000000000000000_SDK,&
    1.0605372372093000_SDK,   1.5955027522702001_SDK,   0.0000000000000000_SDK,&
    1.1161674706983999_SDK,   1.8517707742247000_SDK,   0.0000000000000000_SDK,&
    1.5874787834866999_SDK,  0.83747878348673999_SDK,   0.0000000000000000_SDK,&
    1.8374787834866999_SDK,  0.83747878348673999_SDK,   0.0000000000000000_SDK,&
    1.7500000000000000_SDK,   1.0000000000000000_SDK,   0.0000000000000000_SDK,&
    1.8374787834866999_SDK,   1.1625212165133001_SDK,   0.0000000000000000_SDK,&
    1.5874787834866999_SDK,   1.1625212165133001_SDK,   0.0000000000000000_SDK,&
    1.8374787834866999_SDK,   1.4125212165133001_SDK,   0.0000000000000000_SDK,&
    1.8374787834866999_SDK,  0.58747878348673999_SDK,   0.0000000000000000_SDK,&
    1.3661674706983999_SDK,  0.14822922577527001_SDK,   0.0000000000000000_SDK,&
    1.3661674706983999_SDK,   1.8517707742247000_SDK,   0.0000000000000000_SDK,&
    1.4933512339513999_SDK,  0.64202091286973995_SDK,   0.0000000000000000_SDK,&
    1.4933512339513999_SDK,   1.3579790871302999_SDK,   0.0000000000000000_SDK,&
    1.6412966716263999_SDK,  0.51138926462741996_SDK,   0.0000000000000000_SDK,&
    1.6412966716263999_SDK,   1.4886107353725999_SDK,   0.0000000000000000_SDK,&
    1.2720399211630999_SDK,  0.45277135515826000_SDK,   0.0000000000000000_SDK,&
    1.2720399211630999_SDK,   1.5472286448417001_SDK,   0.0000000000000000_SDK,&
    1.4199853588381000_SDK,   1.6778602930840001_SDK,   0.0000000000000000_SDK,&
    1.4199853588381000_SDK,  0.32213970691595001_SDK,   0.0000000000000000_SDK,&
    1.4596903386044000_SDK,   1.5215473894763001_SDK,   0.0000000000000000_SDK,&
    1.4596903386044000_SDK,  0.47845261052367000_SDK,   0.0000000000000000_SDK &
/), (/3, 109/))

INTEGER(SIK) :: two_pins_pin1_cells(7,46) = RESHAPE( (/ &
36,  33,  46,   4,  47,  48,  39,&
36,  34,  46,  33,  49,  47,  40,&
36,   4,  46,  38,  48,  50,  45,&
36,  35,  46,  34,  51,  49,  41,&
36,  36,  46,  35,  52,  51,  42,&
36,  38,  46,  37,  50,  53,  44,&
36,  37,  46,  36,  53,  52,  43,&
36,  13,  36,  35,  62,  42,  63,&
36,  14,  36,  13,  64,  62,  17,&
36,  12,  13,  35,  16,  63,  65,&
36,   5,   6,  37,   9,  66,  67,&
36,  28,  34,  27,  68,  69,  31,&
36,  28,  54,  34,  70,  71,  68,&
36,  37,  55,   5,  72,  73,  67,&
36,  35,  54,  12,  74,  75,  65,&
36,  14,  55,  36,  76,  77,  64,&
36,  19,  59,   1,  78,  79,  22,&
36,   3,  58,  21,  80,  81,  25,&
36,   5,  55,   0,  73,  82,   8,&
36,   0,  55,  14,  82,  76,  18,&
36,  12,  54,   2,  75,  83,  15,&
36,   2,  54,  28,  83,  70,  32,&
36,  34,  54,  35,  71,  74,  41,&
36,  36,  55,  37,  77,  72,  43,&
36,   1,  59,   7,  79,  84,  11,&
36,  26,  58,   3,  85,  80,  29,&
36,   6,  61,  37,  86,  87,  66,&
36,  34,  60,  27,  88,  89,  69,&
36,   4,  56,  20,  90,  91,  92,&
36,  20,  57,   4,  93,  94,  92,&
36,  21,  57,  20,  95,  93,  24,&
36,  20,  56,  19,  91,  96,  23,&
36,   7,  61,   6,  97,  86,  10,&
36,  27,  60,  26,  89,  98,  30,&
36,  38,  56,   4,  99,  90,  45,&
36,   4,  57,  33,  94, 100,  39,&
36,  56,  59,  19, 101,  78,  96,&
36,  21,  58,  57,  81, 102,  95,&
36,  37,  61,  38,  87, 103,  44,&
36,  33,  60,  34, 104,  88,  40,&
36,  26,  60,  58,  98, 105,  85,&
36,  59,  61,   7, 106,  97,  84,&
36,  58,  60,  33, 105, 104, 107,&
36,  38,  61,  59, 103, 106, 108,&
36,  38,  59,  56, 108, 101,  99,&
36,  57,  58,  33, 102, 107, 100 &
/), (/7, 46/))

INTEGER(SIK) :: two_pins_pin1_material_ids(46) = (/ &
0, 0, 0, 0, 0, 0, 0,          &
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, &
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, &
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, &
1, 1, 1, 1, 1, 1, 1, 1, 1     &
/)
!
!REAL(SDK) :: three_level_grid_L3_vertices(3,5) = RESHAPE( (/ &
! 2.0, 1.5, 0.0,&
! 2.0, 1.0, 0.0,&
! 3.0, 1.0, 0.0,&
! 2.0, 2.0, 0.0,&
! 3.0, 2.0, 0.0 &
!/), (/3, 5/))
!
!INTEGER(SIK) :: three_level_grid_L3_cells(3,3) = RESHAPE( (/ &
!0, 2, 4, &
!1, 2, 0, &
!3, 0, 4  &
!/), (/3, 3/))

CREATE_TEST('XDMF TYPE')
REGISTER_SUBTEST('CLEAR', testClear)
REGISTER_SUBTEST('ASSIGNMENT', testAssign)
!REGISTER_SUBTEST('GET CELL AREA', testGetCellArea)
!REGISTER_SUBTEST('POINT INSIDE CELL', testPointInsideCell)
!REGISTER_SUBTEST('IMPORT XDMF MESH', testImportXDMFMesh)
!REGISTER_SUBTEST('EXPORT XDMF MESH', testExportXDMFMesh)
FINALIZE_TEST()
!
!===============================================================================
CONTAINS
!
!-------------------------------------------------------------------------------
SUBROUTINE setup_pin1(mesh)
  TYPE(XDMFMeshType_2D), INTENT(INOUT), TARGET :: mesh
  INTEGER(SIK) :: i
  TYPE(PointType) :: p1, p2, p3
  CALL p1%init(DIM = 2, X=0.0_SRK, Y=0.0_SRK)
  CALL p2%init(DIM = 2, X=2.0_SRK, Y=0.0_SRK)
  CALL p3%init(DIM = 2, X=1.0_SRK, Y=1.0_SRK)

  ! Setup a mesh equivalent to gridmesh_two_pins.xdmf, only containing pin1
  mesh%name = "GRID_L1_1_1"
  ALLOCATE(mesh%points(109))
  DO i = 1, 109
    CALL mesh%points(i)%init(DIM=2, X=two_pins_pin1_vertices(1,i), &
                                    Y=two_pins_pin1_vertices(2,i))
  ENDDO
  ALLOCATE(mesh%cells(46))
  DO i = 1,46
    ALLOCATE(mesh%cells(i)%point_list(7))
    mesh%cells(i)%point_list(1) = two_pins_pin1_cells(1,i)
    mesh%cells(i)%point_list(2:) = two_pins_pin1_cells(2:,i) + 1
  ENDDO
  mesh%material_ids = two_pins_pin1_material_ids + 1
  ALLOCATE(mesh%cell_sets(1))
  ALLOCATE(mesh%cell_sets(1)%cell_list(46))
  mesh%cell_sets(1)%name = "Pin_1"
  DO i = 1,46
    mesh%cell_sets(1)%cell_list(i) = i
  ENDDO
ENDSUBROUTINE setup_pin1
!
!-------------------------------------------------------------------------------
SUBROUTINE testClear()
  TYPE(XDMFMeshType_2D) :: mesh

  CALL setup_pin1(mesh)

  CALL mesh%clear()
  ASSERT(mesh%name == "", "mesh mesh name is incorrect")
  ASSERT(.NOT.ALLOCATED(mesh%points), "Vertices are allocated")
  ASSERT(.NOT.ALLOCATED(mesh%cells), "Cells are allocated")
  ASSERT(.NOT.ALLOCATED(mesh%material_ids), "materials are allocated")
  ASSERT(.NOT.ALLOCATED(mesh%cell_sets), "Cell sets are allocated")
ENDSUBROUTINE testClear
!
!-------------------------------------------------------------------------------
SUBROUTINE testAssign()
  TYPE(XDMFMeshType_2D) :: mesh1, mesh2
  INTEGER(SIK) :: i,j
  TYPE(PointType) :: p1, p2, p3
  CALL p1%init(DIM = 2, X=0.0_SRK, Y=0.0_SRK)
  CALL p2%init(DIM = 2, X=2.0_SRK, Y=0.0_SRK)
  CALL p3%init(DIM = 2, X=1.0_SRK, Y=1.0_SRK)

  CALL setup_pin1(mesh1)
  mesh2 = mesh1
  ASSERT(mesh2%name == "GRID_L1_1_1", "mesh2 mesh name is incorrect")
  ! points
  ASSERT(ALLOCATED(mesh2%points), "points not allocated")
  ASSERT(SIZE(mesh2%points)==109, "Wrong number of points")
  DO i=1,109
    DO j=1,2
      ASSERT( (ABS(mesh2%points(i)%coord(j) - two_pins_pin1_vertices(j,i)) < 1.0E-9), "Unequal points")
    ENDDO
  ENDDO
  ! cells
  ASSERT(ALLOCATED(mesh2%cells), "Cells not allocated")
  ASSERT(SIZE(mesh2%cells)==46, "Wrong number of cells")
  DO i=1,46
    ASSERT(SIZE(mesh2%cells(i)%point_list)==7, "Wrong size for point list")
    ASSERT( mesh2%cells(i)%point_list(1) == two_pins_pin1_cells(1, i), "Wrong cell type")
    DO j=2,7
      ASSERT( mesh2%cells(i)%point_list(j) == two_pins_pin1_cells(j, i) + 1, "Wrong point id")
    ENDDO
  ENDDO
  ! material_ids
  ASSERT(ALLOCATED(mesh2%material_ids), "material_ids not allocated")
  ASSERT(SIZE(mesh2%material_ids)==46, "Wrong number of cells")
  DO i=1,46
    ASSERT( mesh2%material_ids(i) == two_pins_pin1_material_ids(i) + 1, "Unequal material_id")
  ENDDO
  ! cell_sets
  ASSERT(ALLOCATED(mesh2%cell_sets), "cell_sets not allocated")
  ASSERT(SIZE(mesh2%cell_sets)==1, "Wrong number of cell sets")
  ASSERT(SIZE(mesh2%cell_sets(1)%cell_list)==46, "Wrong number of cells")
  ASSERT(mesh2%cell_sets(1)%name=="Pin_1", "Wrong cell_set name")
  DO i=1,46
    ASSERT( mesh2%cell_sets(1)%cell_list(i) == i, "Wrong cells")
  ENDDO

  CALL mesh1%clear()
  CALL mesh2%clear()
ENDSUBROUTINE testAssign
!
!-------------------------------------------------------------------------------
!SUBROUTINE testGetCellArea()
!  TYPE(XDMFMeshType) :: mesh
!  REAL(SRK) :: area
!  INTEGER(SIK) :: i
!
!  ! vertices
!  ALLOCATE(mesh%vertices(3,9))
!  mesh%vertices(:,1) = (/0.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,2) = (/1.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,3) = (/1.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,4) = (/0.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,5) = (/0.5_SDK, -0.20710678118_SDK, 0.0_SDK/)
!  mesh%vertices(:,6) = (/1.20710678118_SDK, 0.5_SDK, 0.0_SDK/)
!  mesh%vertices(:,7) = (/0.5_SDK, 1.20710678118_SDK, 0.0_SDK/)
!  mesh%vertices(:,8) = (/-0.20710678118_SDK, 0.5_SDK, 0.0_SDK/)
!  mesh%vertices(:,9) = (/0.5_SDK, 0.5_SDK, 0.0_SDK/)
!
!  ! Cells
!  ALLOCATE(mesh%cells(4))
!  ! Triangle
!  ALLOCATE(mesh%cells(1)%point_list(4))
!  mesh%cells(1)%point_list = (/4, 1, 2, 3/)
!  ! Quadrilateral
!  ALLOCATE(mesh%cells(2)%point_list(5))
!  mesh%cells(2)%point_list = (/5, 1, 2, 3, 4/)
!  ! Triangle6
!  ALLOCATE(mesh%cells(3)%point_list(7))
!  mesh%cells(3)%point_list = (/36, 1, 2, 3, 5, 6, 9/)
!  ! Quadrilateral8
!  ALLOCATE(mesh%cells(4)%point_list(9))
!  mesh%cells(4)%point_list = (/37, 1, 2, 3, 4, 5, 6, 7, 8/)
!
!  ! Same mesh, with vertices rotated 45 degrees about the origin
!  mesh45 = mesh
!  DO i = 1, 9
!    xy = mesh45%vertices(1:2, i)
!    xy = MATMUL(rotation_mat, xy)
!    mesh45%vertices(1:2, i) = xy
!  ENDDO
!
!  COMPONENT_TEST('Triangle')
!  !          v3 (1,1)
!  !        /  |
!  !      /    |
!  !    /      |
!  !  /        |
!  ! v1-------v2 (1,0)
!  ! (0,0)
!  area = mesh%getCellArea(1_SIK)
!  ASSERT(ABS(area - 0.5_SRK) < 1.0E-6, "Area should be 1*1/2 = 0.5")
!  area = mesh45%getCellArea(1_SIK)
!  ASSERT(ABS(area - 0.5_SRK) < 1.0E-6, "Area should be 1*1/2 = 0.5")
!
!  COMPONENT_TEST('Quadrilateral')
!  ! (0,1) v4-------v3 (1,1)
!  !       |        |
!  !       |        |
!  !       |        |
!  !       |        |
!  !       v1-------v2 (1,0)
!  ! (0,0)
!  area = mesh%getCellArea(2_SIK)
!  ASSERT(ABS(area - 1.0_SRK) < 1.0E-6, "Area should be 1*1 = 1")
!  area = mesh45%getCellArea(2_SIK)
!  ASSERT(ABS(area - 1.0_SRK) < 1.0E-6, "Area should be 1*1 = 1")
!
!  COMPONENT_TEST('Triangle6')
!  !          v3
!  !        /   \
!  !     v9      v6  This should look very close to a half circle, with the flat edge
!  !    /        /   at 45 degrees. Hard to make an ASCII diagram for this.
!  !  /         /   Area approc pi/4
!  ! v1        v2
!  !    --v5--
!  area = mesh%getCellArea(3_SIK)
!  ASSERT(ABS(area - 0.77614233) < 1.0E-6, "Area should be 0.77614233")
!  area = mesh45%getCellArea(3_SIK)
!  ASSERT(ABS(area - 0.77614233) < 1.0E-6, "Area should be 0.77614233")
!
!
!  COMPONENT_TEST('Quad8')
!  !        --v7--
!  !   v4--       --v3
!  !  /               \
!  ! /                 \
!  !v8                 v6    Should look very close to a circle
!  ! \                 /     Area approx pi/2
!  !  \               /
!  !   v1--       --v2
!  !       -- v5--
!  area = mesh%getCellArea(4_SIK)
!  ASSERT(ABS(area - 2*0.77614233) < 1.0E-6, "Area should be 2*0.77614233")
!  area = mesh45%getCellArea(4_SIK)
!  ASSERT(ABS(area - 2*0.77614233) < 1.0E-6, "Area should be 2*0.77614233")
!
!  COMPONENT_TEST('Elemental')
!  areas = mesh%getCellArea((/1_SIK, 2_SIK, 3_SIK, 4_SIK/))
!  ASSERT(ABS(areas(1) - 0.5_SRK) < 1.0E-6, "Area should be 1*1/2 = 0.5")
!  ASSERT(ABS(areas(2) - 1.0_SRK) < 1.0E-6, "Area should be 1*1 = 1")
!  ASSERT(ABS(areas(3) - 0.77614233) < 1.0E-6, "Area should be 0.77614233")
!  ASSERT(ABS(areas(4) - 2*0.77614233) < 1.0E-6, "Area should be 2*0.77614233")
!  CALL mesh%clear()
!ENDSUBROUTINE testGetCellArea
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE testRecomputeBoundingBox()
!  TYPE(XDMFMeshType) :: mesh
!  TYPE(XDMFMeshType),POINTER :: pin1
!
!  CALL setup_pin1(mesh)
!  pin1 => mesh%children(1)
!
!  ! Check original bounding box
!  ASSERT( (ABS(mesh%boundingBox(1) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect x_min")
!  ASSERT( (ABS(mesh%boundingBox(2) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect x_max")
!  ASSERT( (ABS(mesh%boundingBox(3) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect y_min")
!  ASSERT( (ABS(mesh%boundingBox(4) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect y_max")
!  ASSERT( (ABS(pin1%boundingBox(1) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect x_min")
!  ASSERT( (ABS(pin1%boundingBox(2) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect x_max")
!  ASSERT( (ABS(pin1%boundingBox(3) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect y_min")
!  ASSERT( (ABS(pin1%boundingBox(4) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect y_max")
!
!  ! Check that nothing changes when recomputing
!  CALL mesh%recomputeBoundingBox()
!  ASSERT( (ABS(mesh%boundingBox(1) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect x_min")
!  ASSERT( (ABS(mesh%boundingBox(2) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect x_max")
!  ASSERT( (ABS(mesh%boundingBox(3) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect y_min")
!  ASSERT( (ABS(mesh%boundingBox(4) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect y_max")
!  ASSERT( (ABS(pin1%boundingBox(1) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect x_min")
!  ASSERT( (ABS(pin1%boundingBox(2) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect x_max")
!  ASSERT( (ABS(pin1%boundingBox(3) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect y_min")
!  ASSERT( (ABS(pin1%boundingBox(4) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect y_max")
!
!  ! Move a vertex so that it changes the BB.
!  ! The old BB was (0,0,2,2). We are moving the corner vertex at (2,2)
!  ! to (2.1, 2.2)
!  pin1%vertices(1,4) = 2.1_SDK
!  pin1%vertices(2,4) = 2.2_SDK
!  CALL mesh%recomputeBoundingBox()
!  ASSERT( (ABS(mesh%boundingBox(1) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect x_min")
!  ASSERT( (ABS(mesh%boundingBox(2) - 2.1_SDK) < 1.0E-9_SDK), "Incorrect x_max")
!  ASSERT( (ABS(mesh%boundingBox(3) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect y_min")
!  ASSERT( (ABS(mesh%boundingBox(4) - 2.2_SDK) < 1.0E-9_SDK), "Incorrect y_max")
!  ASSERT( (ABS(pin1%boundingBox(1) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect x_min")
!  ASSERT( (ABS(pin1%boundingBox(2) - 2.1_SDK) < 1.0E-9_SDK), "Incorrect x_max")
!  ASSERT( (ABS(pin1%boundingBox(3) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect y_min")
!  ASSERT( (ABS(pin1%boundingBox(4) - 2.2_SDK) < 1.0E-9_SDK), "Incorrect y_max")
!
!  CALL mesh%clear()
!  NULLIFY(pin1)
!ENDSUBROUTINE testRecomputeBoundingBox
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE testSetupRectangularMap()
!  TYPE(XDMFMeshType) :: mesh
!
!  ALLOCATE(mesh%children(2))
!  mesh%children(1)%name = 'GRID_L1_1_1'
!  mesh%children(2)%name = 'GRID_L1_2_1'
!
!  ! Check original map
!  CALL mesh%setupRectangularMap()
!  ASSERT(ALLOCATED(mesh%map), "Map is not allocated")
!  ASSERT(SIZE(mesh%map, DIM=1) == 2, "Map is wrong size")
!  ASSERT(SIZE(mesh%map, DIM=2) == 1, "Map is wrong size")
!  ASSERT(mesh%map(1,1) == 1, "Wrong child!")
!  ASSERT(mesh%map(2,1) == 2, "Wrong child!")
!
!  ! Check that nothing changes when rerun
!  CALL mesh%setupRectangularMap()
!  ASSERT(ALLOCATED(mesh%map), "Map is not allocated")
!  ASSERT(SIZE(mesh%map, DIM=1) == 2, "Map is wrong size")
!  ASSERT(SIZE(mesh%map, DIM=2) == 1, "Map is wrong size")
!  ASSERT(mesh%map(1,1) == 1, "Wrong child!")
!  ASSERT(mesh%map(2,1) == 2, "Wrong child!")
!
!  ! Make a 2 by 3 grid, labeled as such
!  ! -------------
!  ! | 3 | 2 | 6 |
!  ! -------------
!  ! | 1 | 4 | 5 |
!  ! -------------
!  DEALLOCATE(mesh%children)
!  ALLOCATE(mesh%children(6))
!  mesh%children(1)%name = 'GRID_L1_1_1'
!  mesh%children(2)%name = 'GRID_L1_2_2'
!  mesh%children(3)%name = 'GRID_L1_1_2'
!  mesh%children(4)%name = 'GRID_L1_2_1'
!  mesh%children(5)%name = 'GRID_L1_3_1'
!  mesh%children(6)%name = 'GRID_L1_3_2'
!  CALL mesh%setupRectangularMap()
!  ASSERT(ALLOCATED(mesh%map), "Map is not allocated")
!  ASSERT(SIZE(mesh%map, DIM=1) == 3, "Map is wrong size")
!  ASSERT(SIZE(mesh%map, DIM=2) == 2, "Map is wrong size")
!  ASSERT(mesh%map(1,1) == 1, "Wrong child!")
!  ASSERT(mesh%map(2,1) == 4, "Wrong child!")
!  ASSERT(mesh%map(3,1) == 5, "Wrong child!")
!  ASSERT(mesh%map(1,2) == 3, "Wrong child!")
!  ASSERT(mesh%map(2,2) == 2, "Wrong child!")
!  ASSERT(mesh%map(3,2) == 6, "Wrong child!")
!
!  CALL mesh%clear()
!ENDSUBROUTINE testSetupRectangularMap
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE testSetupEdges()
!  TYPE(XDMFMeshType) :: mesh
!  INTEGER(SIK) :: i
!
!  COMPONENT_TEST("Linear Edges")
!  ! A linear mesh with 7 cells (3 tri, 4 quad), 11 vertices, and 17 unique
!  ! edges.
!  !
!  ! (0,2) 8---------9---------10-----------------11 (4,2)
!  !       |         |         |            ------ |
!  !       |    c3   |   c4    |  c7    ----       |
!  !       |         |         |    ----           |
!  ! (0,1) 5---------6---------7----         c6    |    <--- three triangles
!  !       |         |         |    ----           |
!  !       |    c1   |   c2    |  c5    ----       |
!  !       |         |         |            ------ |
!  !       1---------2---------3-------------------4
!  !       (0,0)     (1,0)     (2,0)               (4,0)
!  !
!  ! vertices
!  ALLOCATE(mesh%vertices(3,11))
!  mesh%vertices(:,1) = (/0.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,2) = (/1.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,3) = (/2.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,4) = (/4.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,5) = (/0.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,6) = (/1.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,7) = (/2.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,8) = (/0.0_SDK, 2.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,9) = (/1.0_SDK, 2.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,10) = (/2.0_SDK, 2.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,11) = (/4.0_SDK, 2.0_SDK, 0.0_SDK/)
!
!  ! Cells
!  ALLOCATE(mesh%cells(7))
!  ! Quadrilaterals
!  ALLOCATE(mesh%cells(1)%point_list(5))
!  mesh%cells(1)%point_list = (/5, 1, 2, 6, 5/)
!  ALLOCATE(mesh%cells(2)%point_list(5))
!  mesh%cells(2)%point_list = (/5, 2, 3, 7, 6/)
!  ALLOCATE(mesh%cells(3)%point_list(5))
!  mesh%cells(3)%point_list = (/5, 5, 6, 9, 8/)
!  ALLOCATE(mesh%cells(4)%point_list(5))
!  mesh%cells(4)%point_list = (/5, 6, 7, 10, 9/)
!  ! Triangles
!  ALLOCATE(mesh%cells(5)%point_list(4))
!  mesh%cells(5)%point_list = (/4, 3, 4, 7/)
!  ALLOCATE(mesh%cells(6)%point_list(4))
!  mesh%cells(6)%point_list = (/4, 7, 4, 11/)
!  ALLOCATE(mesh%cells(7)%point_list(4))
!  mesh%cells(7)%point_list = (/4, 7, 11, 10/)
!
!  ! Setup the edges
!  CALL mesh%setupEdges()
!
!  ASSERT(ALLOCATED(mesh%edges), "edges not allocated")
!  ASSERT(SIZE(mesh%edges) == 17, "wrong number of edges")
!  ASSERT(ALL(mesh%edges%isLinear), "Should be linear")
!  ! Spot check on 2 edges, since all 17 would be tedious
!  ! Edge 1 - 2
!  ASSERT(mesh%edges(1)%cells(1) == 1, "Wrong cell")
!  ASSERT(mesh%edges(1)%cells(2) == -1, "Wrong cell")
!  ASSERT(mesh%edges(1)%vertices(1) == -1, "Wrong vert")
!  ASSERT(mesh%edges(1)%vertices(2) == 1, "Wrong vert")
!  ASSERT(mesh%edges(1)%vertices(3) == 2, "Wrong vert")
!  ASSERT(mesh%edges(1)%line%p1%dim == 2, "Line not setup correctly")
!  ASSERT(mesh%edges(1)%line%p2%dim == 2, "Line not setup correctly")
!  ASSERT(mesh%edges(1)%line%p1%coord(1) == 0.0_SRK, "Line not setup correctly")
!  ASSERT(mesh%edges(1)%line%p1%coord(2) == 0.0_SRK, "Line not setup correctly")
!  ASSERT(mesh%edges(1)%line%p2%coord(1) == 1.0_SRK, "Line not setup correctly")
!  ASSERT(mesh%edges(1)%line%p2%coord(2) == 0.0_SRK, "Line not setup correctly")
!
!  ! Edge 7 - 11
!  ASSERT(mesh%edges(16)%cells(1) == 6, "Wrong cell")
!  ASSERT(mesh%edges(16)%cells(2) == 7, "Wrong cell")
!  ASSERT(mesh%edges(16)%vertices(1) == -1, "Wrong vert")
!  ASSERT(mesh%edges(16)%vertices(2) == 7, "Wrong vert")
!  ASSERT(mesh%edges(16)%vertices(3) == 11, "Wrong vert")
!  ASSERT(mesh%edges(16)%line%p1%dim == 2, "Line not setup correctly")
!  ASSERT(mesh%edges(16)%line%p2%dim == 2, "Line not setup correctly")
!  ASSERT(mesh%edges(16)%line%p1%coord(1) == 2.0_SRK, "Line not setup correctly")
!  ASSERT(mesh%edges(16)%line%p1%coord(2) == 1.0_SRK, "Line not setup correctly")
!  ASSERT(mesh%edges(16)%line%p2%coord(1) == 4.0_SRK, "Line not setup correctly")
!  ASSERT(mesh%edges(16)%line%p2%coord(2) == 2.0_SRK, "Line not setup correctly")
!
!  ! Check that cell's edge list is allocated.
!  DO i = 1, 7
!    ASSERT(ALLOCATED(mesh%cells(i)%edge_list), "cell's edge list not allocated!")
!  ENDDO
!
!  ! Spot check to make sure the list is correct
!  ! Cell 6
!  ! Edge: 4 - 7   ID: 14
!  ! Edge: 7 - 11  ID: 16
!  ! Edge: 4 - 11  ID: 15
!  ASSERT(mesh%cells(6)%edge_list(1) == 14, "Wrong edge!")
!  ASSERT(mesh%cells(6)%edge_list(2) == 15, "Wrong edge!")
!  ASSERT(mesh%cells(6)%edge_list(3) == 16, "Wrong edge!")
!
!  CALL mesh%clear()
!
!  COMPONENT_TEST("Quadratic Edges")
!  ! A quadratic triangle mesh with 2 cells, 9 vertices, and 5 unique
!  ! edges.
!  !
!  ! (0,2) 7---------8---------9
!  !       |                ---|
!  !       |    c2       ---   |
!  !       |          ---      |
!  ! (0,1) 4         5         6
!  !       |      ---          |
!  !       |   ---       c1    |
!  !       |---                |
!  !       1---------2---------3
!  !       (0,0)     (1,0)     (2,0)
!  !
!  ! vertices
!  ALLOCATE(mesh%vertices(3,9))
!  mesh%vertices(:,1) = (/0.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,2) = (/1.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,3) = (/2.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,4) = (/0.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,5) = (/1.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,6) = (/2.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,7) = (/0.0_SDK, 2.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,8) = (/1.0_SDK, 2.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,9) = (/2.0_SDK, 2.0_SDK, 0.0_SDK/)
!
!  ! Cells
!  ALLOCATE(mesh%cells(2))
!  ALLOCATE(mesh%cells(1)%point_list(7))
!  mesh%cells(1)%point_list = (/36, 1, 3, 9, 2, 6, 5/)
!  ALLOCATE(mesh%cells(2)%point_list(7))
!  mesh%cells(2)%point_list = (/36, 9, 7, 1, 8, 4, 5/)
!
!  ! Setup the edges
!  CALL mesh%setupEdges()
!
!  ASSERT(ALLOCATED(mesh%edges), "edges not allocated")
!  ASSERT(SIZE(mesh%edges) == 5, "wrong number of edges")
!  ASSERT(.NOT.ANY(mesh%edges%isLinear), "Should not be linear")
!  ! Spot check on 2 edges, since all would be tedious
!  ! Edge 1 - 2 - 3
!  ASSERT(mesh%edges(1)%cells(1) == 1, "Wrong cell")
!  ASSERT(mesh%edges(1)%cells(2) == -1, "Wrong cell")
!  ASSERT(mesh%edges(1)%vertices(1) == 1, "Wrong vert")
!  ASSERT(mesh%edges(1)%vertices(2) == 3, "Wrong vert")
!  ASSERT(mesh%edges(1)%vertices(3) == 2, "Wrong vert")
!  ASSERT(mesh%edges(1)%quad%points(1)%dim == 2, "Quad not setup correctly")
!  ASSERT(mesh%edges(1)%quad%points(2)%dim == 2, "Quad not setup correctly")
!  ASSERT(mesh%edges(1)%quad%points(3)%dim == 2, "Quad not setup correctly")
!  ASSERT(mesh%edges(1)%quad%points(1)%coord(1) == 0.0_SRK, "Quad not setup correctly")
!  ASSERT(mesh%edges(1)%quad%points(1)%coord(2) == 0.0_SRK, "Quad not setup correctly")
!  ASSERT(mesh%edges(1)%quad%points(2)%coord(1) == 2.0_SRK, "Quad not setup correctly")
!  ASSERT(mesh%edges(1)%quad%points(2)%coord(2) == 0.0_SRK, "Quad not setup correctly")
!  ASSERT(mesh%edges(1)%quad%points(3)%coord(1) == 1.0_SRK, "Quad not setup correctly")
!  ASSERT(mesh%edges(1)%quad%points(3)%coord(2) == 0.0_SRK, "Quad not setup correctly")
!
!  ! Edge 1 - 5 - 9
!  ASSERT(mesh%edges(3)%cells(1) == 1, "Wrong cell")
!  ASSERT(mesh%edges(3)%cells(2) == 2, "Wrong cell")
!  ASSERT(mesh%edges(3)%vertices(1) == 1, "Wrong vert")
!  ASSERT(mesh%edges(3)%vertices(2) == 9, "Wrong vert")
!  ASSERT(mesh%edges(3)%vertices(3) == 5, "Wrong vert")
!  ASSERT(mesh%edges(3)%quad%points(1)%dim == 2, "Quad not setup correctly")
!  ASSERT(mesh%edges(3)%quad%points(2)%dim == 2, "Quad not setup correctly")
!  ASSERT(mesh%edges(3)%quad%points(3)%dim == 2, "Quad not setup correctly")
!  ASSERT(mesh%edges(3)%quad%points(1)%coord(1) == 0.0_SRK, "Quad not setup correctly")
!  ASSERT(mesh%edges(3)%quad%points(1)%coord(2) == 0.0_SRK, "Quad not setup correctly")
!  ASSERT(mesh%edges(3)%quad%points(2)%coord(1) == 2.0_SRK, "Quad not setup correctly")
!  ASSERT(mesh%edges(3)%quad%points(2)%coord(2) == 2.0_SRK, "Quad not setup correctly")
!  ASSERT(mesh%edges(3)%quad%points(3)%coord(1) == 1.0_SRK, "Quad not setup correctly")
!  ASSERT(mesh%edges(3)%quad%points(3)%coord(2) == 1.0_SRK, "Quad not setup correctly")
!
!  ! Check that cell's edge list is allocated.
!  DO i = 1, 2
!    ASSERT(ALLOCATED(mesh%cells(i)%edge_list), "cell's edge list not allocated!")
!  ENDDO
!
!  ! Spot check to make sure the list is correct
!  ! Cell 1
!  ! Edge: 1 - 2 - 3  ID: 1
!  ! Edge: 3 - 6 - 9  ID: 2
!  ! Edge: 1 - 5 - 9  ID: 3
!  ASSERT(mesh%cells(1)%edge_list(1) == 1, "Wrong edge!")
!  ASSERT(mesh%cells(1)%edge_list(2) == 2, "Wrong edge!")
!  ASSERT(mesh%cells(1)%edge_list(3) == 3, "Wrong edge!")
!
!  CALL mesh%clear()
!ENDSUBROUTINE testSetupEdges
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE testClearEdges()
!  TYPE(XDMFMeshType) :: mesh
!  INTEGER(SIK) :: i
!
!  ! vertices
!  ALLOCATE(mesh%vertices(3,11))
!  mesh%vertices(:,1) = (/0.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,2) = (/1.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,3) = (/2.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,4) = (/4.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,5) = (/0.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,6) = (/1.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,7) = (/2.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,8) = (/0.0_SDK, 2.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,9) = (/1.0_SDK, 2.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,10) = (/2.0_SDK, 2.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,11) = (/4.0_SDK, 2.0_SDK, 0.0_SDK/)
!
!  ! Cells
!  ALLOCATE(mesh%cells(7))
!  ! Quadrilaterals
!  ALLOCATE(mesh%cells(1)%point_list(5))
!  mesh%cells(1)%point_list = (/5, 1, 2, 6, 5/)
!  ALLOCATE(mesh%cells(2)%point_list(5))
!  mesh%cells(2)%point_list = (/5, 2, 3, 7, 6/)
!  ALLOCATE(mesh%cells(3)%point_list(5))
!  mesh%cells(3)%point_list = (/5, 5, 6, 9, 8/)
!  ALLOCATE(mesh%cells(4)%point_list(5))
!  mesh%cells(4)%point_list = (/5, 6, 7, 10, 9/)
!  ! Triangles
!  ALLOCATE(mesh%cells(5)%point_list(4))
!  mesh%cells(5)%point_list = (/4, 3, 4, 7/)
!  ALLOCATE(mesh%cells(6)%point_list(4))
!  mesh%cells(6)%point_list = (/4, 7, 4, 11/)
!  ALLOCATE(mesh%cells(7)%point_list(4))
!  mesh%cells(7)%point_list = (/4, 7, 11, 10/)
!
!  ! Setup the edges
!  CALL mesh%setupEdges()
!
!  ! clear edges
!  CALL mesh%clearEdges()
!
!  ! Check that edges are gone, but other info is intact
!  ASSERT(ALLOCATED(mesh%vertices), "Modified vertiecs.")
!  ASSERT(ALLOCATED(mesh%cells), "Modified vertiecs.")
!  ASSERT(.NOT.ALLOCATED(mesh%edges), "Edges still allocated.")
!  DO i = 1, 7
!    ASSERT(.NOT.ALLOCATED(mesh%cells(i)%edge_list), "Cell edge list not cleared")
!  ENDDO
!
!  CALL mesh%clear()
!ENDSUBROUTINE testClearEdges
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE testImportXDMFMesh()
!  ! Test the various major branches in import logic:
!  ! - Levels:       1 vs 2 or more
!  ! - Topology:     Mixed vs Single
!  ! - Materials:    Yes vs No
!  ! - Cell sets:    Yes vs No
!  ! -----------------------------------------------------------------------------
!  ! | Component   | Variation            | Tested by                           |
!  ! ----------------------------------------------------------------------------
!  ! | Levels      | 1                    | three_level_grid_IH                 |
!  ! | Levels      | 2 or more            | two_pins, three_level_grid          |
!  ! | Topology    | Mixed                | three_level_grid_IH                 |
!  ! | Topology    | Single               | two_pins, three_level_grid          |
!  ! | Materials   | Yes                  | two_pins                            |
!  ! | Materials   | No                   | both three_level_grids              |
!  ! | Cell sets   | Yes                  | two_pins, three_level_grid_IH       |
!  ! | Cell sets   | No                   | three_level_grid                    |
!  ! ----------------------------------------------------------------------------
!  !
!  ! Test case with two pins
!  ! - Levels:       2
!  ! - Topology:     Single, Triangle_6
!  ! - Materials:    Yes
!  ! - Cell sets:    Yes
!  COMPONENT_TEST('test two pins')
!  CALL test_import_two_pins()
!  !
!  ! Test case with three level grid, explicit hierarchy
!  ! Note: the GRID has 3 levels, therefore the mesh has 4 levels
!  ! - Levels:       4
!  ! - Topology:     Single, Triangle or Quad in each leaf
!  ! - Materials:    No
!  ! - Cell sets:    No
!  COMPONENT_TEST('test three level grid')
!  CALL test_import_three_level_grid()
!  !
!  ! Test case with three level grid but the mesh hierarchy is implied
!  ! through cell sets instead of explicitly through XDMF XML
!  ! - Levels:       1
!  ! - Topology:     Mixed, Triangle and Quad
!  ! - Materials:    No
!  ! - Cell sets:    Yes
!  COMPONENT_TEST('test three level grid w/ implicit hierarchy')
!  CALL test_import_three_level_grid_implicit_hierarchy()
!ENDSUBROUTINE testImportXDMFMesh
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE test_import_two_pins()
!  TYPE(XDMFMeshType) :: mesh, pin1
!  TYPE(StringType) :: fname
!  INTEGER(SIK) :: i,j
!
!  fname='gridmesh_two_pins.xdmf'
!  CALL importXDMFMesh(fname, mesh)
!  ! Check correct number of children
!  ASSERT(mesh%name == "mesh_domain", "Root mesh name is incorrect")
!  ASSERT(ASSOCIATED(mesh%children), "Children not associated")
!  ASSERT(SIZE(mesh%children)==2, "Wrong number of children")
!  ASSERT(ALLOCATED(mesh%map), "Map is not allocated")
!  ASSERT(SIZE(mesh%map, DIM=1) == 2, "Map is wrong size")
!  ASSERT(SIZE(mesh%map, DIM=2) == 1, "Map is wrong size")
!  ASSERT( (ABS(mesh%boundingBox(1) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect x_min")
!  ASSERT( (ABS(mesh%boundingBox(2) - 4.0_SDK) < 1.0E-9_SDK), "Incorrect x_max")
!  ASSERT( (ABS(mesh%boundingBox(3) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect y_min")
!  ASSERT( (ABS(mesh%boundingBox(4) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect y_max")
!  ! Check pin1
!  pin1 = mesh%children(1)
!  ASSERT(pin1%name == "GRID_L1_1_1", "pin1 mesh name is incorrect")
!  ASSERT(.NOT.ASSOCIATED(pin1%children), "Children are associated")
!  ASSERT(ASSOCIATED(pin1%parent), "Parent not associated")
!  ASSERT(pin1%parent%name == "mesh_domain", "pin1 parent name is incorrect")
!  ASSERT(pin1%singleTopology == .TRUE., "pin1 is not single topology")
!  ASSERT(.NOT.ALLOCATED(pin1%map), "Map is allocated")
!  ASSERT( (ABS(pin1%boundingBox(1) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect x_min")
!  ASSERT( (ABS(pin1%boundingBox(2) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect x_max")
!  ASSERT( (ABS(pin1%boundingBox(3) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect y_min")
!  ASSERT( (ABS(pin1%boundingBox(4) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect y_max")
!  !     pin1 vertices
!  ASSERT(ALLOCATED(pin1%vertices), "Vertices not allocated")
!  ASSERT(SIZE(pin1%vertices)==109*3, "Wrong number of vertices")
!  ASSERT(SIZE(pin1%vertices, DIM=2)==109, "Wrong shape of vertices")
!  DO i=1,109
!    DO j=1,3
!      ASSERT( (ABS(pin1%vertices(j, i) - two_pins_pin1_vertices(j,i)) < 1.0E-9), "Unequal vertices")
!    ENDDO
!  ENDDO
!  !     pin1 cells
!  ASSERT(ALLOCATED(pin1%cells), "Cells not allocated")
!  ASSERT(SIZE(pin1%cells)==46, "Wrong number of cells")
!  DO i=1,46
!    ASSERT(SIZE(pin1%cells(i)%point_list)==7, "Wrong size for vertex list")
!    ASSERT( pin1%cells(i)%point_list(1) == two_pins_pin1_cells(1, i), "Wrong cell type")
!    DO j=2,7
!      ASSERT( pin1%cells(i)%point_list(j) == two_pins_pin1_cells(j, i) + 1, "Wrong vertex id")
!    ENDDO
!  ENDDO
!  !     pin1 material_ids
!  ASSERT(ALLOCATED(pin1%material_ids), "material_ids not allocated")
!  ASSERT(SIZE(pin1%material_ids)==46, "Wrong number of cells")
!  DO i=1,46
!    ASSERT( pin1%material_ids(i) == two_pins_pin1_material_ids(i) + 1, "Unequal material_id")
!  ENDDO
!  !     pin1 cell_sets
!  ASSERT(ALLOCATED(pin1%cell_sets), "cell_sets not allocated")
!  ASSERT(SIZE(pin1%cell_sets)==1, "Wrong number of cell sets")
!  ASSERT(SIZE(pin1%cell_sets(1)%cell_list)==46, "Wrong number of cells")
!  ASSERT(pin1%cell_sets(1)%name=="Pin_1", "Wrong cell_set name")
!  DO i=1,46
!    ASSERT( pin1%cell_sets(1)%cell_list(i) == i, "Wrong cells")
!  ENDDO
!
!  CALL mesh%clear()
!  CALL pin1%clear()
!ENDSUBROUTINE test_import_two_pins
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE test_import_three_level_grid()
!  TYPE(XDMFMeshType) :: mesh, L1, L2, L3
!  TYPE(StringType) :: fname
!  INTEGER(SIK) :: i,j
!
!  fname='gridmesh_three_level_grid.xdmf'
!  CALL importXDMFMesh(fname, mesh)
!
!  ASSERT(mesh%name == "three_lvl_grid", "Root mesh name is incorrect")
!  ASSERT(ASSOCIATED(mesh%children), "Children not associated")
!  ASSERT(SIZE(mesh%children)==1, "Wrong number of children")
!  ASSERT(ALLOCATED(mesh%map), "Map is not allocated")
!  ASSERT(SIZE(mesh%map, DIM=1) == 1, "Map is wrong size")
!  ASSERT(SIZE(mesh%map, DIM=2) == 1, "Map is wrong size")
!  i = mesh%distanceToLeaf()
!  ASSERT(i == 3, "Wrong number of levels")
!  ASSERT( (ABS(mesh%boundingBox(1) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect x_min")
!  ASSERT( (ABS(mesh%boundingBox(2) - 4.0_SDK) < 1.0E-9_SDK), "Incorrect x_max")
!  ASSERT( (ABS(mesh%boundingBox(3) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect y_min")
!  ASSERT( (ABS(mesh%boundingBox(4) - 4.0_SDK) < 1.0E-9_SDK), "Incorrect y_max")
!  ! Check L1
!  L1 = mesh%children(1)
!  ASSERT(L1%name == "GRID_L1_1_1", "L1 mesh name is incorrect")
!  ASSERT(ASSOCIATED(L1%children), "Children are not associated")
!  ASSERT(ASSOCIATED(L1%parent), "Parent not associated")
!  ASSERT(L1%parent%name == "three_lvl_grid", "L1 parent name is incorrect")
!  ASSERT(SIZE(L1%children) == 4, "Wrong number of children")
!  ASSERT(ALLOCATED(L1%map), "Map is not allocated")
!  ASSERT(SIZE(L1%map, DIM=1) == 2, "Map is wrong size")
!  ASSERT(SIZE(L1%map, DIM=2) == 2, "Map is wrong size")
!  i = L1%distanceToLeaf()
!  ASSERT(i == 2, "Wrong number of levels")
!  ASSERT( (ABS(L1%boundingBox(1) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect x_min")
!  ASSERT( (ABS(L1%boundingBox(2) - 4.0_SDK) < 1.0E-9_SDK), "Incorrect x_max")
!  ASSERT( (ABS(L1%boundingBox(3) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect y_min")
!  ASSERT( (ABS(L1%boundingBox(4) - 4.0_SDK) < 1.0E-9_SDK), "Incorrect y_max")
!  ! Check L2_2_1
!  L2 = L1%children(2)
!  ASSERT(L2%name == "GRID_L2_2_1", "L2 mesh name is incorrect")
!  ASSERT(ASSOCIATED(L2%children), "Children are not associated")
!  ASSERT(ASSOCIATED(L2%parent), "Parent not associated")
!  ASSERT(L2%parent%name == "GRID_L1_1_1", "L2 parent name is incorrect")
!  ASSERT(SIZE(L2%children) == 4, "Wrong number of children")
!  ASSERT(ALLOCATED(L2%map), "Map is not allocated")
!  ASSERT(SIZE(L2%map, DIM=1) == 2, "Map is wrong size")
!  ASSERT(SIZE(L2%map, DIM=2) == 2, "Map is wrong size")
!  ASSERT( (ABS(L2%boundingBox(1) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect x_min")
!  ASSERT( (ABS(L2%boundingBox(2) - 4.0_SDK) < 1.0E-9_SDK), "Incorrect x_max")
!  ASSERT( (ABS(L2%boundingBox(3) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect y_min")
!  ASSERT( (ABS(L2%boundingBox(4) - 2.0_SDK) < 1.0E-9_SDK), "Incorrect y_max")
!  ! Check L3_3_2
!  L3 = L2%children(3)
!  ASSERT(L3%name == "GRID_L3_3_2", "L3 mesh name is incorrect")
!  ASSERT(.NOT. ASSOCIATED(L3%children), "Children are associated")
!  ASSERT(ASSOCIATED(L3%parent), "Parent not associated")
!  ASSERT(L3%parent%name == "GRID_L2_2_1", "L3 parent name is incorrect")
!  !     L3_3_2 vertices
!  ASSERT(ALLOCATED(L3%vertices), "Vertices not allocated")
!  ASSERT(SIZE(L3%vertices)==5*3, "Wrong number of vertices")
!  ASSERT(SIZE(L3%vertices, DIM=2)==5, "Wrong shape of vertices")
!  DO i=1,5
!    DO j=1,3
!      ASSERT( (ABS(L3%vertices(j, i) - three_level_grid_L3_vertices(j,i)) < 1.0E-9), "Unequal vertices")
!    ENDDO
!  ENDDO
!  !     L3_3_2 cells
!  ASSERT(ALLOCATED(L3%cells), "Cells not allocated")
!  ASSERT(SIZE(L3%cells)==3, "Wrong number of cells")
!  ASSERT(L3%singleTopology == .TRUE., "L3 is not single topology")
!  DO i=1,3
!    ASSERT(SIZE(L3%cells(i)%point_list)==4, "Wrong size for vertex list")
!    ASSERT( L3%cells(i)%point_list(1) == 4, "Wrong cell type, should be triangle=4")
!    DO j=2,4
!      ASSERT( L3%cells(i)%point_list(j) == three_level_grid_L3_cells(j-1, i) + 1, "Wrong vertex id")
!    ENDDO
!  ENDDO
!  ASSERT(.NOT. ALLOCATED(L3%material_ids), "Material IDS are allocated")
!  ASSERT(.NOT. ALLOCATED(L3%cell_sets), "Cell sets are allocated")
!
!  CALL mesh%clear()
!  CALL L1%clear()
!  CALL L2%clear()
!  CALL L3%clear()
!ENDSUBROUTINE test_import_three_level_grid
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE test_import_three_level_grid_implicit_hierarchy()
!  TYPE(XDMFMeshType) :: mesh
!  TYPE(StringType) :: fname
!  INTEGER(SIK) :: i,j
!  INTEGER(SIK),ALLOCATABLE :: cells_ref(:)
!
!  fname='three_level_grid.xdmf'
!  CALL importXDMFMesh(fname, mesh)
!  ! Check correct number of children
!  ASSERT(mesh%name == "three_lvl_grid", "Root mesh name is incorrect")
!  ASSERT(.NOT.ASSOCIATED(mesh%children), "Children are associated")
!  ASSERT(.NOT.ALLOCATED(mesh%map), "Map is allocated")
!  ASSERT( (ABS(mesh%boundingBox(1) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect x_min")
!  ASSERT( (ABS(mesh%boundingBox(2) - 4.0_SDK) < 1.0E-9_SDK), "Incorrect x_max")
!  ASSERT( (ABS(mesh%boundingBox(3) - 0.0_SDK) < 1.0E-9_SDK), "Incorrect y_min")
!  ASSERT( (ABS(mesh%boundingBox(4) - 4.0_SDK) < 1.0E-9_SDK), "Incorrect y_max")
!  ! vertices
!  ASSERT(ALLOCATED(mesh%vertices), "Vertices not allocated")
!  ASSERT(SIZE(mesh%vertices)==42*3, "Wrong number of vertices")
!  ASSERT(SIZE(mesh%vertices, DIM=2)==42, "Wrong shape of vertices")
!  ! cells
!  ASSERT(ALLOCATED(mesh%cells), "Cells not allocated")
!  ASSERT(SIZE(mesh%cells)==46, "Wrong number of cells")
!  ASSERT(mesh%singleTopology == .FALSE., "Mesh is single topology")
!  ! Spot check cells
!  ! Cell 1, quad
!  j=1
!  ALLOCATE(cells_ref(5))
!  cells_ref = (/5, 26, 2, 27, 38/)
!  ASSERT(SIZE(mesh%cells(j)%point_list)==5, "Wrong size for vertex list")
!  DO i=1,5
!    ASSERT( mesh%cells(j)%point_list(i) == cells_ref(i), "Wrong vertex id or mesh id")
!  ENDDO
!  ! Cell 4, quad
!  j=4
!  cells_ref = (/5, 4, 29, 38, 28/)
!  ASSERT(SIZE(mesh%cells(j)%point_list)==5, "Wrong size for vertex list")
!  DO i=1,5
!    ASSERT( mesh%cells(j)%point_list(i) == cells_ref(i), "Wrong vertex id or mesh id")
!  ENDDO
!  DEALLOCATE(cells_ref)
!  ! Cell 18, tri
!  j=18
!  ALLOCATE(cells_ref(4))
!  cells_ref = (/4, 6, 40, 8/)
!  ASSERT(SIZE(mesh%cells(j)%point_list)==4, "Wrong size for vertex list")
!  DO i=1,4
!    ASSERT( mesh%cells(j)%point_list(i) == cells_ref(i), "Wrong vertex id or mesh id")
!  ENDDO
!  DEALLOCATE(cells_ref)
!  ASSERT(.NOT. ALLOCATED(mesh%material_ids), "Material IDS are allocated")
!  ! Check cell sets
!  ASSERT(ALLOCATED(mesh%cell_sets), "Cell sets are allocated")
!  ASSERT(SIZE(mesh%cell_sets)==21, "Wrong number of cell sets")
!  ASSERT(mesh%cell_sets(6)%name=="GRID_L3_1_1", "Wrong set name")
!  ASSERT(SIZE(mesh%cell_sets(6)%cell_list)==4, "Wrong set size")
!  DO i =1,4
!    ASSERT(mesh%cell_sets(6)%cell_list(i) == i, "Wrong cell id")
!  ENDDO
!
!  CALL mesh%clear()
!ENDSUBROUTINE test_import_three_level_grid_implicit_hierarchy
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE testExportXDMFMesh()
!  !
!  ! ****************************************************************************
!  ! NOTE:
!  !   Since tests run sequentially within the file, to reach this subroutine
!  !   without error, import has to be working as intended. If errors occur
!  !   within testImportXDMFMesh, those should be addressed first.
!  !   Export is verified by importing the exported mesh. This is not
!  !   ideal unit test design, but manually setting up all of the meshes of
!  !   interest to test the export subroutine would take over a thousand lines
!  !   easily.
!  ! ****************************************************************************
!  !
!  ! Test the various major branches in export logic:
!  ! - Levels:       1 vs 2 or more
!  ! - Topology:     Mixed vs Single
!  ! - Materials:    Yes vs No
!  ! - Cell sets:    Yes vs No
!  ! -----------------------------------------------------------------------------
!  ! | Component   | Variation            | Tested by                           |
!  ! ----------------------------------------------------------------------------
!  ! | Levels      | 1                    | three_level_grid_IH                 |
!  ! | Levels      | 2 or more            | two_pins, three_level_grid          |
!  ! | Topology    | Mixed                | three_level_grid_IH                 |
!  ! | Topology    | Single               | two_pins, three_level_grid          |
!  ! | Materials   | Yes                  | two_pins                            |
!  ! | Materials   | No                   | both three_level_grids              |
!  ! | Cell sets   | Yes                  | two_pins, three_level_grid_IH       |
!  ! | Cell sets   | No                   | three_level_grid                    |
!  ! ----------------------------------------------------------------------------
!  !
!  ! Test case with two pins
!  ! - Levels:       2
!  ! - Topology:     Single, Triangle_6
!  ! - Materials:    Yes
!  ! - Cell sets:    Yes
!  COMPONENT_TEST('test two pins')
!  CALL test_export_two_pins()
!  !
!  ! Test case with three level grid, explicit hierarchy
!  ! Note: the GRID has 3 levels, therefore the mesh has 4 levels
!  ! - Levels:       4
!  ! - Topology:     Single, Triangle or Quad in each leaf
!  ! - Materials:    No
!  ! - Cell sets:    No
!  COMPONENT_TEST('test three level grid')
!  CALL test_export_three_level_grid()
!  !
!  ! Test case with three level grid but the mesh hierarchy is implied
!  ! through cell sets instead of explicitly through XDMF XML
!  ! - Levels:       1
!  ! - Topology:     Mixed, Triangle and Quad
!  ! - Materials:    No
!  ! - Cell sets:    Yes
!  COMPONENT_TEST('test three level grid w/ implicit hierarchy')
!  CALL test_export_three_level_grid_implicit_hierarchy()
!ENDSUBROUTINE testExportXDMFMesh
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE test_export_two_pins()
!  TYPE(XDMFMeshType) :: mesh, pin1, emesh
!  TYPE(StringType) :: fname
!  INTEGER(SIK) :: i,j
!
!  fname='gridmesh_two_pins.xdmf'
!  CALL importXDMFMesh(fname, mesh)
!
!  ! Export
!  fname='write_two_pins.xdmf'
!  CALL exportXDMFMesh(fname, mesh)
!  CALL importXDMFMesh(fname, emesh)
!  ASSERT(emesh%name == "mesh_domain", "Root mesh name is incorrect")
!  ASSERT(ASSOCIATED(emesh%children), "Children not associated")
!  ASSERT(SIZE(emesh%children)==2, "Wrong number of children")
!  ! Check pin1
!  pin1 = emesh%children(1)
!  ASSERT(pin1%name == "GRID_L1_1_1", "pin1 mesh name is incorrect")
!  ASSERT(.NOT.ASSOCIATED(pin1%children), "Children are associated")
!  ASSERT(ASSOCIATED(pin1%parent), "Parent not associated")
!  ASSERT(pin1%parent%name == "mesh_domain", "pin1 parent name is incorrect")
!  ASSERT(pin1%singleTopology == .TRUE., "pin1 is not single topology")
!  !     pin1 vertices
!  ASSERT(ALLOCATED(pin1%vertices), "Vertices not allocated")
!  ASSERT(SIZE(pin1%vertices)==109*3, "Wrong number of vertices")
!  ASSERT(SIZE(pin1%vertices, DIM=2)==109, "Wrong shape of vertices")
!  DO i=1,109
!    DO j=1,3
!      ASSERT( (ABS(pin1%vertices(j, i) - two_pins_pin1_vertices(j,i)) < 1.0E-9), "Unequal vertices")
!    ENDDO
!  ENDDO
!  !     pin1 cells
!  ASSERT(ALLOCATED(pin1%cells), "Cells not allocated")
!  ASSERT(SIZE(pin1%cells)==46, "Wrong number of cells")
!  DO i=1,46
!    ASSERT(SIZE(pin1%cells(i)%point_list)==7, "Wrong size for vertex list")
!    ASSERT( pin1%cells(i)%point_list(1) == two_pins_pin1_cells(1, i), "Wrong cell type")
!    DO j=2,7
!      ASSERT( pin1%cells(i)%point_list(j) == two_pins_pin1_cells(j, i) + 1, "Wrong vertex id")
!    ENDDO
!  ENDDO
!  !     pin1 material_ids
!  ASSERT(ALLOCATED(pin1%material_ids), "material_ids not allocated")
!  ASSERT(SIZE(pin1%material_ids)==46, "Wrong number of cells")
!  DO i=1,46
!    ASSERT( pin1%material_ids(i) == two_pins_pin1_material_ids(i) + 1, "Unequal material_id")
!  ENDDO
!  !     pin1 cell_sets
!  ASSERT(ALLOCATED(pin1%cell_sets), "cell_sets not allocated")
!  ASSERT(SIZE(pin1%cell_sets)==1, "Wrong number of cell sets")
!  ASSERT(SIZE(pin1%cell_sets(1)%cell_list)==46, "Wrong number of cells")
!  ASSERT(pin1%cell_sets(1)%name=="Pin_1", "Wrong cell_set name")
!  DO i=1,46
!    ASSERT( pin1%cell_sets(1)%cell_list(i) == i, "Wrong cells")
!  ENDDO
!
!  CALL mesh%clear()
!  CALL pin1%clear()
!  CALL emesh%clear()
!ENDSUBROUTINE test_export_two_pins
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE test_export_three_level_grid()
!  TYPE(XDMFMeshType) :: mesh, L1, L2, L3, emesh
!  TYPE(StringType) :: fname
!  INTEGER(SIK) :: i,j
!
!  fname='gridmesh_three_level_grid.xdmf'
!  CALL importXDMFMesh(fname, mesh)
!
!  ! Export
!  fname='write_three_level_grid.xdmf'
!  CALL exportXDMFMesh(fname, mesh)
!  CALL importXDMFMesh(fname, emesh)
!  ! Check correct number of children
!  ASSERT(emesh%name == "three_lvl_grid", "Root mesh name is incorrect")
!  ASSERT(ASSOCIATED(emesh%children), "Children not associated")
!  ASSERT(SIZE(emesh%children)==1, "Wrong number of children")
!  ! Check L1
!  L1 = emesh%children(1)
!  ASSERT(L1%name == "GRID_L1_1_1", "L1 mesh name is incorrect")
!  ASSERT(ASSOCIATED(L1%children), "Children are not associated")
!  ASSERT(ASSOCIATED(L1%parent), "Parent not associated")
!  ASSERT(L1%parent%name == "three_lvl_grid", "L1 parent name is incorrect")
!  ASSERT(SIZE(L1%children) == 4, "Wrong number of children")
!  ! Check L2_2_1
!  L2 = L1%children(2)
!  ASSERT(L2%name == "GRID_L2_2_1", "L2 mesh name is incorrect")
!  ASSERT(ASSOCIATED(L2%children), "Children are not associated")
!  ASSERT(ASSOCIATED(L2%parent), "Parent not associated")
!  ASSERT(L2%parent%name == "GRID_L1_1_1", "L2 parent name is incorrect")
!  ASSERT(SIZE(L2%children) == 4, "Wrong number of children")
!  ! Check L3_3_2
!  L3 = L2%children(3)
!  ASSERT(L3%name == "GRID_L3_3_2", "L3 mesh name is incorrect")
!  ASSERT(.NOT. ASSOCIATED(L3%children), "Children are associated")
!  ASSERT(ASSOCIATED(L3%parent), "Parent not associated")
!  ASSERT(L3%parent%name == "GRID_L2_2_1", "L3 parent name is incorrect")
!  !     L3_3_2 vertices
!  ASSERT(ALLOCATED(L3%vertices), "Vertices not allocated")
!  ASSERT(SIZE(L3%vertices)==5*3, "Wrong number of vertices")
!  ASSERT(SIZE(L3%vertices, DIM=2)==5, "Wrong shape of vertices")
!  DO i=1,5
!    DO j=1,3
!      ASSERT( (ABS(L3%vertices(j, i) - three_level_grid_L3_vertices(j,i)) < 1.0E-9), "Unequal vertices")
!    ENDDO
!  ENDDO
!  !     L3_3_2 cells
!  ASSERT(ALLOCATED(L3%cells), "Cells not allocated")
!  ASSERT(SIZE(L3%cells)==3, "Wrong number of cells")
!  ASSERT(L3%singleTopology == .TRUE., "L3 is not single topology")
!  DO i=1,3
!    ASSERT(SIZE(L3%cells(i)%point_list)==4, "Wrong size for vertex list")
!    ASSERT( L3%cells(i)%point_list(1) == 4, "Wrong cell type, should be triangle=4")
!    DO j=2,4
!      ASSERT( L3%cells(i)%point_list(j) == three_level_grid_L3_cells(j-1, i) + 1, "Wrong vertex id")
!    ENDDO
!  ENDDO
!  ASSERT(.NOT. ALLOCATED(L3%material_ids), "Material IDS are allocated")
!  ASSERT(.NOT. ALLOCATED(L3%cell_sets), "Cell sets are allocated")
!
!  CALL mesh%clear()
!  CALL L1%clear()
!  CALL L2%clear()
!  CALL L3%clear()
!  CALL emesh%clear()
!ENDSUBROUTINE test_export_three_level_grid
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE test_export_three_level_grid_implicit_hierarchy()
!  TYPE(XDMFMeshType) :: mesh,emesh
!  TYPE(StringType) :: fname
!  INTEGER(SIK) :: i,j
!  INTEGER(SIK),ALLOCATABLE :: cells_ref(:)
!
!  fname='three_level_grid.xdmf'
!  CALL importXDMFMesh(fname, mesh)
!
!  ! Export
!  fname='write_three_level_grid_IH.xdmf'
!  CALL exportXDMFMesh(fname, mesh)
!  CALL importXDMFMesh(fname, emesh)
!  ! Check correct number of children
!  ASSERT(emesh%name == "three_lvl_grid", "Root mesh name is incorrect")
!  ASSERT(.NOT.ASSOCIATED(emesh%children), "Children are associated")
!  ! vertices
!  ASSERT(ALLOCATED(emesh%vertices), "Vertices not allocated")
!  ASSERT(SIZE(emesh%vertices)==42*3, "Wrong number of vertices")
!  ASSERT(SIZE(emesh%vertices, DIM=2)==42, "Wrong shape of vertices")
!  ! cells
!  ASSERT(ALLOCATED(emesh%cells), "Cells not allocated")
!  ASSERT(SIZE(emesh%cells)==46, "Wrong number of cells")
!  ASSERT(emesh%singleTopology == .FALSE., "Mesh is single topology")
!  ! Spot check cells
!  ! Cell 1, quad
!  j=1
!  ALLOCATE(cells_ref(5))
!  cells_ref = (/5, 26, 2, 27, 38/)
!  ASSERT(SIZE(emesh%cells(j)%point_list)==5, "Wrong size for vertex list")
!  DO i=1,5
!    ASSERT( emesh%cells(j)%point_list(i) == cells_ref(i), "Wrong vertex id or mesh id")
!  ENDDO
!  ! Cell 4, quad
!  j=4
!  cells_ref = (/5, 4, 29, 38, 28/)
!  ASSERT(SIZE(emesh%cells(j)%point_list)==5, "Wrong size for vertex list")
!  DO i=1,5
!    ASSERT( emesh%cells(j)%point_list(i) == cells_ref(i), "Wrong vertex id or mesh id")
!  ENDDO
!  DEALLOCATE(cells_ref)
!  ! Cell 18, tri
!  j=18
!  ALLOCATE(cells_ref(4))
!  cells_ref = (/4, 6, 40, 8/)
!  ASSERT(SIZE(emesh%cells(j)%point_list)==4, "Wrong size for vertex list")
!  DO i=1,4
!    ASSERT( emesh%cells(j)%point_list(i) == cells_ref(i), "Wrong vertex id or mesh id")
!  ENDDO
!  DEALLOCATE(cells_ref)
!  ASSERT(.NOT. ALLOCATED(emesh%material_ids), "Material IDS are allocated")
!  ! Check cell sets
!  ASSERT(ALLOCATED(emesh%cell_sets), "Cell sets are allocated")
!  ASSERT(SIZE(emesh%cell_sets)==21, "Wrong number of cell sets")
!  ASSERT(emesh%cell_sets(6)%name=="GRID_L3_1_1", "Wrong set name")
!  ASSERT(SIZE(emesh%cell_sets(6)%cell_list)==4, "Wrong set size")
!  DO i =1,4
!    ASSERT(emesh%cell_sets(6)%cell_list(i) == i, "Wrong cell id")
!  ENDDO
!
!  CALL mesh%clear()
!  CALL emesh%clear()
!ENDSUBROUTINE test_export_three_level_grid_implicit_hierarchy
!!
!!-------------------------------------------------------------------------------
!SUBROUTINE testPointInsideCell()
!  TYPE(XDMFMeshType) :: mesh
!  TYPE(PointType) :: p
!
!  COMPONENT_TEST('Triangle')
!  !          v3 (1,1)
!  !        /  |
!  !      /    |
!  !    /      |
!  !  /        |
!  ! v1-------v2 (1,0)
!  ! (0,0)
!  ! Triangle
!  ! vertices
!  ALLOCATE(mesh%vertices(3,9))
!  mesh%vertices(:,1) = (/0.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,2) = (/1.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,3) = (/1.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,4) = (/0.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,5) = (/0.5_SDK, -0.20710678118_SDK, 0.0_SDK/)
!  mesh%vertices(:,6) = (/1.20710678118_SDK, 0.5_SDK, 0.0_SDK/)
!  mesh%vertices(:,7) = (/0.5_SDK, 1.20710678118_SDK, 0.0_SDK/)
!  mesh%vertices(:,8) = (/-0.20710678118_SDK, 0.5_SDK, 0.0_SDK/)
!  mesh%vertices(:,9) = (/0.5_SDK, 0.5_SDK, 0.0_SDK/)
!
!  ALLOCATE(mesh%cells(1))
!  ALLOCATE(mesh%cells(1)%point_list(4))
!  mesh%cells(1)%point_list = (/4, 1, 2, 3/)
!
!  CALL mesh%setupEdges()
!
!  CALL p%init(DIM=2, X=3.0_SRK, Y=3.0_SRK)
!  ASSERT(.NOT.mesh%pointInsideCell(1_SIK, p), "Should not be in cell!")
!  CALL p%clear()
!
!  CALL p%init(DIM=2, X=0.9_SRK, Y=0.2_SRK)
!  ASSERT(mesh%pointInsideCell(1_SIK, p), "Should be in cell!")
!  CALL p%clear()
!  CALL mesh%clear()
!
!  COMPONENT_TEST('Quadrilateral')
!  ! (0,1) v4-------v3 (1,1)
!  !       |        |
!  !       |        |
!  !       |        |
!  !       |        |
!  !       v1-------v2 (1,0)
!  ! (0,0)
!  ! Quadrilateral
!  ALLOCATE(mesh%vertices(3,9))
!  mesh%vertices(:,1) = (/0.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,2) = (/1.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,3) = (/1.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,4) = (/0.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,5) = (/0.5_SDK, -0.20710678118_SDK, 0.0_SDK/)
!  mesh%vertices(:,6) = (/1.20710678118_SDK, 0.5_SDK, 0.0_SDK/)
!  mesh%vertices(:,7) = (/0.5_SDK, 1.20710678118_SDK, 0.0_SDK/)
!  mesh%vertices(:,8) = (/-0.20710678118_SDK, 0.5_SDK, 0.0_SDK/)
!  mesh%vertices(:,9) = (/0.5_SDK, 0.5_SDK, 0.0_SDK/)
!
!  ALLOCATE(mesh%cells(1))
!  ALLOCATE(mesh%cells(1)%point_list(5))
!  mesh%cells(1)%point_list = (/5, 1, 2, 3, 4/)
!
!  CALL mesh%setupEdges()
!
!  CALL p%init(DIM=2, X=3.0_SRK, Y=3.0_SRK)
!  ASSERT(.NOT.mesh%pointInsideCell(1_SIK, p), "Should not be in cell!")
!  CALL p%clear()
!
!  CALL p%init(DIM=2, X=0.9_SRK, Y=0.2_SRK)
!  ASSERT(mesh%pointInsideCell(1_SIK, p), "Should be in cell!")
!  CALL p%clear()
!  CALL mesh%clear()
!
!  COMPONENT_TEST('Triangle6')
!  !          v3
!  !        /   \
!  !     v9      v6  This should look very close to a half circle, with the flat edge
!  !    /        /   at 45 degrees. Hard to make an ASCII diagram for this.
!  !  /         /   Area approc pi/4
!  ! v1        v2
!  !    --v5--
!  ALLOCATE(mesh%vertices(3,9))
!  mesh%vertices(:,1) = (/0.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,2) = (/1.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,3) = (/1.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,4) = (/0.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,5) = (/0.5_SDK, -0.20710678118_SDK, 0.0_SDK/)
!  mesh%vertices(:,6) = (/1.20710678118_SDK, 0.5_SDK, 0.0_SDK/)
!  mesh%vertices(:,7) = (/0.5_SDK, 1.20710678118_SDK, 0.0_SDK/)
!  mesh%vertices(:,8) = (/-0.20710678118_SDK, 0.5_SDK, 0.0_SDK/)
!  mesh%vertices(:,9) = (/0.5_SDK, 0.5_SDK, 0.0_SDK/)
!
!  ALLOCATE(mesh%cells(1))
!  ALLOCATE(mesh%cells(1)%point_list(7))
!  mesh%cells(1)%point_list = (/36, 1, 2, 3, 5, 6, 9/)
!
!  CALL mesh%setupEdges()
!
!  CALL p%init(DIM=2, X=3.0_SRK, Y=3.0_SRK)
!  ASSERT(.NOT.mesh%pointInsideCell(1_SIK, p), "Should not be in cell!")
!  CALL p%clear()
!
!  CALL p%init(DIM=2, X=0.9_SRK, Y=0.2_SRK)
!  ASSERT(mesh%pointInsideCell(1_SIK, p), "Should be in cell!")
!  CALL p%clear()
!  CALL mesh%clear()
!
!  COMPONENT_TEST('Quad8')
!  !        --v7--
!  !   v4--       --v3
!  !  /               \
!  ! /                 \
!  !v8                 v6    Should look very close to a circle
!  ! \                 /     Area approx pi/2
!  !  \               /
!  !   v1--       --v2
!  !       -- v5--
!
!  ALLOCATE(mesh%vertices(3,9))
!  mesh%vertices(:,1) = (/0.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,2) = (/1.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,3) = (/1.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,4) = (/0.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,5) = (/0.5_SDK, -0.20710678118_SDK, 0.0_SDK/)
!  mesh%vertices(:,6) = (/1.20710678118_SDK, 0.5_SDK, 0.0_SDK/)
!  mesh%vertices(:,7) = (/0.5_SDK, 1.20710678118_SDK, 0.0_SDK/)
!  mesh%vertices(:,8) = (/-0.20710678118_SDK, 0.5_SDK, 0.0_SDK/)
!  mesh%vertices(:,9) = (/0.5_SDK, 0.5_SDK, 0.0_SDK/)
!
!  ALLOCATE(mesh%cells(1))
!  ALLOCATE(mesh%cells(1)%point_list(9))
!  mesh%cells(1)%point_list = (/37, 1, 2, 3, 4, 5, 6, 7, 8/)
!  
!  CALL mesh%setupEdges()
!
!  CALL p%init(DIM=2, X=3.0_SRK, Y=3.0_SRK)
!  ASSERT(.NOT.mesh%pointInsideCell(1_SIK, p), "Should not be in cell!")
!  CALL p%clear()
!
!  CALL p%init(DIM=2, X=0.9_SRK, Y=0.2_SRK)
!  ASSERT(mesh%pointInsideCell(1_SIK, p), "Should be in cell!")
!  CALL p%clear()
!  CALL mesh%clear()
!
!  COMPONENT_TEST('Shared last edge triangles')
!  ! v4--------v3 (1,1)
!  ! |      /  |
!  ! |    /    |
!  ! |  /      |
!  ! |/        |
!  ! v1-------v2 (1,0)
!  ! (0,0)
!  ! Triangle
!  ! vertices
!  ALLOCATE(mesh%vertices(3,4))
!  mesh%vertices(:,1) = (/0.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,2) = (/1.0_SDK, 0.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,3) = (/1.0_SDK, 1.0_SDK, 0.0_SDK/)
!  mesh%vertices(:,4) = (/0.0_SDK, 1.0_SDK, 0.0_SDK/)
!
!  ALLOCATE(mesh%cells(2))
!  ALLOCATE(mesh%cells(1)%point_list(4))
!  mesh%cells(1)%point_list = (/4, 1, 2, 3/)
!  ALLOCATE(mesh%cells(2)%point_list(4))
!  mesh%cells(2)%point_list = (/4, 3, 4, 1/)
!
!  CALL mesh%setupEdges()
!
!  CALL p%init(DIM=2, X=3.0_SRK, Y=3.0_SRK)
!  ASSERT(.NOT.mesh%pointInsideCell(1_SIK, p), "Should not be in cell!")
!  ASSERT(.NOT.mesh%pointInsideCell(2_SIK, p), "Should not be in cell!")
!  CALL p%clear()
!
!  CALL p%init(DIM=2, X=0.9_SRK, Y=0.2_SRK)
!  ASSERT(mesh%pointInsideCell(1_SIK, p), "Should be in cell!")
!  ASSERT(.NOT.mesh%pointInsideCell(2_SIK, p), "Should not be in cell!")
!  CALL p%clear()
!  CALL mesh%clear()
!ENDSUBROUTINE testPointInsideCell
ENDPROGRAM testXDMFMesh

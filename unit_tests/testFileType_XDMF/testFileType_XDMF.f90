!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!
!                          Futility Development Group                          !
!                             All rights reserved.                             !
!                                                                              !
! Futility is a jointly-maintained, open-source project between the University !
! of Michigan and Oak Ridge National Laboratory.  The copyright and license    !
! can be found in LICENSE.txt in the head directory of this repository.        !
!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!
PROGRAM testXDMFFileType
#include "UnitTest.h"
USE ISO_FORTRAN_ENV
USE UnitTest
USE IntrType
USE Strings
USE FileType_XDMF
IMPLICIT NONE

REAL(SDK) :: two_pins_pin1_vertices(3,109) = RESHAPE( (/ &
    0.0000000000000000,        0.0000000000000000,        0.0000000000000000,&     
    2.0000000000000000,        0.0000000000000000,        0.0000000000000000,&     
    0.0000000000000000,        2.0000000000000000,        0.0000000000000000,&     
    2.0000000000000000,        2.0000000000000000,        0.0000000000000000,&     
    1.5000000000000000,        1.0000000000000000,        0.0000000000000000,&     
   0.50000000000000000,        0.0000000000000000,        0.0000000000000000,&     
    1.0000000000000000,        0.0000000000000000,        0.0000000000000000,&     
    1.5000000000000000,        0.0000000000000000,        0.0000000000000000,&     
   0.25000000000000000,        0.0000000000000000,        0.0000000000000000,&     
   0.75000000000000000,        0.0000000000000000,        0.0000000000000000,&     
    1.2500000000000000,        0.0000000000000000,        0.0000000000000000,&     
    1.7500000000000000,        0.0000000000000000,        0.0000000000000000,&     
    0.0000000000000000,        1.5000000000000000,        0.0000000000000000,&     
    0.0000000000000000,        1.0000000000000000,        0.0000000000000000,&     
    0.0000000000000000,       0.50000000000000000,        0.0000000000000000,&     
    0.0000000000000000,        1.7500000000000000,        0.0000000000000000,&     
    0.0000000000000000,        1.2500000000000000,        0.0000000000000000,&     
    0.0000000000000000,       0.75000000000000000,        0.0000000000000000,&     
    0.0000000000000000,       0.25000000000000000,        0.0000000000000000,&     
    2.0000000000000000,       0.50000000000000000,        0.0000000000000000,&     
    2.0000000000000000,        1.0000000000000000,        0.0000000000000000,&     
    2.0000000000000000,        1.5000000000000000,        0.0000000000000000,&     
    2.0000000000000000,       0.25000000000000000,        0.0000000000000000,&     
    2.0000000000000000,       0.75000000000000000,        0.0000000000000000,&     
    2.0000000000000000,        1.2500000000000000,        0.0000000000000000,&     
    2.0000000000000000,        1.7500000000000000,        0.0000000000000000,&     
    1.5000000000000000,        2.0000000000000000,        0.0000000000000000,&     
    1.0000000000000000,        2.0000000000000000,        0.0000000000000000,&     
   0.50000000000000000,        2.0000000000000000,        0.0000000000000000,&     
    1.7500000000000000,        2.0000000000000000,        0.0000000000000000,&     
    1.2500000000000000,        2.0000000000000000,        0.0000000000000000,&     
   0.75000000000000000,        2.0000000000000000,        0.0000000000000000,&     
   0.25000000000000000,        2.0000000000000000,        0.0000000000000000,&     
    1.3117449009294000,        1.3909157412340001,        0.0000000000000000,&     
   0.88873953302183994,        1.4874639560909000,        0.0000000000000000,&     
   0.54951556604879004,        1.2169418695587999,        0.0000000000000000,&     
   0.54951556604879004,       0.78305813044121997,        0.0000000000000000,&     
   0.88873953302183994,       0.51253604390909002,        0.0000000000000000,&     
    1.3117449009294000,       0.60908425876599004,        0.0000000000000000,&     
    1.4504844339512000,        1.2169418695587999,        0.0000000000000000,&     
    1.1112604669782000,        1.4874639560909000,        0.0000000000000000,&     
   0.68825509907062998,        1.3909157412340001,        0.0000000000000000,&     
   0.50000000000000000,        1.0000000000000000,        0.0000000000000000,&     
   0.68825509907062998,       0.60908425876599004,        0.0000000000000000,&     
    1.1112604669782000,       0.51253604390909002,        0.0000000000000000,&     
    1.4504844339512000,       0.78305813044121997,        0.0000000000000000,&     
    1.0000000000000000,        1.0000000000000000,        0.0000000000000000,&     
    1.1558724504647000,        1.1954578706170000,        0.0000000000000000,&     
    1.2500000000000000,        1.0000000000000000,        0.0000000000000000,&     
   0.94436976651091997,        1.2437319780455001,        0.0000000000000000,&     
    1.1558724504647000,       0.80454212938298997,        0.0000000000000000,&     
   0.77475778302440002,        1.1084709347794000,        0.0000000000000000,&     
   0.77475778302440002,       0.89152906522061004,        0.0000000000000000,&     
   0.94436976651091997,       0.75626802195454002,        0.0000000000000000,&     
   0.39945256244833000,        1.6005474375516999,        0.0000000000000000,&     
   0.39945256244833000,       0.39945256244833000,        0.0000000000000000,&     
    1.6749575669735000,       0.67495756697348996,        0.0000000000000000,&     
    1.6749575669735000,        1.3250424330265000,        0.0000000000000000,&     
    1.6076357762794000,        1.6521790377186001,        0.0000000000000000,&     
    1.6076357762794000,       0.34782096228136000,        0.0000000000000000,&     
    1.2323349413967000,        1.7035415484495000,        0.0000000000000000,&     
    1.2323349413967000,       0.29645845155054001,        0.0000000000000000,&     
   0.27475778302440002,       0.89152906522061004,        0.0000000000000000,&     
   0.27475778302440002,        1.1084709347794000,        0.0000000000000000,&     
   0.27475778302440002,       0.64152906522061004,        0.0000000000000000,&     
   0.27475778302440002,        1.3584709347794000,        0.0000000000000000,&     
   0.94436976651091997,       0.25626802195454002,        0.0000000000000000,&     
   0.69436976651091997,       0.25626802195454002,        0.0000000000000000,&     
   0.69436976651091997,        1.7437319780455001,        0.0000000000000000,&     
   0.94436976651091997,        1.7437319780455001,        0.0000000000000000,&     
   0.44972628122415997,        1.8002737187758000,        0.0000000000000000,&     
   0.64409604773508999,        1.5440056968213001,        0.0000000000000000,&     
   0.64409604773508999,       0.45599430317870998,        0.0000000000000000,&     
   0.44972628122415997,       0.19972628122416000,        0.0000000000000000,&     
   0.47448406424855999,        1.4087446535552000,        0.0000000000000000,&     
   0.19972628122416000,        1.5502737187758000,        0.0000000000000000,&     
   0.19972628122416000,       0.44972628122415997,        0.0000000000000000,&     
   0.47448406424855999,       0.59125534644476996,        0.0000000000000000,&     
    1.8038178881397000,       0.42391048114067997,        0.0000000000000000,&     
    1.8038178881397000,       0.17391048114068000,        0.0000000000000000,&     
    1.8038178881397000,        1.8260895188593000,        0.0000000000000000,&     
    1.8038178881397000,        1.5760895188593000,        0.0000000000000000,&     
   0.19972628122416000,       0.19972628122416000,        0.0000000000000000,&     
   0.19972628122416000,        1.8002737187758000,        0.0000000000000000,&     
    1.5538178881397000,       0.17391048114068000,        0.0000000000000000,&     
    1.5538178881397000,        1.8260895188593000,        0.0000000000000000,&     
    1.1161674706983999,       0.14822922577527001,        0.0000000000000000,&     
    1.0605372372093000,       0.40449724772981999,        0.0000000000000000,&     
    1.0605372372093000,        1.5955027522702001,        0.0000000000000000,&     
    1.1161674706983999,        1.8517707742247000,        0.0000000000000000,&     
    1.5874787834866999,       0.83747878348673999,        0.0000000000000000,&     
    1.8374787834866999,       0.83747878348673999,        0.0000000000000000,&     
    1.7500000000000000,        1.0000000000000000,        0.0000000000000000,&     
    1.8374787834866999,        1.1625212165133001,        0.0000000000000000,&     
    1.5874787834866999,        1.1625212165133001,        0.0000000000000000,&     
    1.8374787834866999,        1.4125212165133001,        0.0000000000000000,&     
    1.8374787834866999,       0.58747878348673999,        0.0000000000000000,&     
    1.3661674706983999,       0.14822922577527001,        0.0000000000000000,&     
    1.3661674706983999,        1.8517707742247000,        0.0000000000000000,&     
    1.4933512339513999,       0.64202091286973995,        0.0000000000000000,&     
    1.4933512339513999,        1.3579790871302999,        0.0000000000000000,&     
    1.6412966716263999,       0.51138926462741996,        0.0000000000000000,&     
    1.6412966716263999,        1.4886107353725999,        0.0000000000000000,&     
    1.2720399211630999,       0.45277135515826000,        0.0000000000000000,&     
    1.2720399211630999,        1.5472286448417001,        0.0000000000000000,&     
    1.4199853588381000,        1.6778602930840001,        0.0000000000000000,&     
    1.4199853588381000,       0.32213970691595001,        0.0000000000000000,&     
    1.4596903386044000,        1.5215473894763001,        0.0000000000000000,&     
    1.4596903386044000,       0.47845261052367000,        0.0000000000000000 & 
/), (/3, 109/))

CREATE_TEST('XDMF TYPE')
REGISTER_SUBTEST('two_pins',test_two_pins)


FINALIZE_TEST()
!
!===============================================================================
CONTAINS
!
!-------------------------------------------------------------------------------
!
SUBROUTINE test_two_pins()
  TYPE(XDMFFileType) :: testXDMFFile
  TYPE(XDMFMeshType) :: mesh, pin1, pin2
  TYPE(StringType) :: fname, str_in, str_out
  LOGICAL(SBK) :: bool
  INTEGER(SIK) :: i,j

  fname='gridmesh_two_pins.xdmf'
  CALL testXDMFFile%importFromDisk(fname, mesh)
  ! Check correct number of children
  ASSERT(mesh%name == "mesh_domain", "Root mesh name is incorrect")
  ASSERT(ASSOCIATED(mesh%children), "Children not associated")
  ASSERT(SIZE(mesh%children)==2, "Wrong number of children")
  ! Check pin1
  pin1 = mesh%children(1)
  ASSERT(pin1%name == "GRID_L1_1_1", "pin1 mesh name is incorrect")
  ASSERT(.NOT.ASSOCIATED(pin1%children), "Children are associated")
  ASSERT(ASSOCIATED(pin1%parent), "Parent not associated")
  ASSERT(pin1%parent%name == "mesh_domain", "pin1 parent name is incorrect")
  !     pin1 vertices
  ASSERT(ALLOCATED(pin1%vertices), "Vertices not allocated")
  ASSERT(SIZE(pin1%vertices)==109*3, "Wrong number of vertices")
  ASSERT(SIZE(pin1%vertices, DIM=2)==109, "Wrong shape of vertices")
  DO i=1,109
    DO j=1,3
      ASSERT( (ABS(pin1%vertices(j, i) - two_pins_pin1_vertices(j,i)) < 1.0E-6), "Unequal vertices")
    ENDDO
  ENDDO


ENDSUBROUTINE test_two_pins
ENDPROGRAM testXDMFFileType

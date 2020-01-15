!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!
!                          Futility Development Group                          !
!                             All rights reserved.                             !
!                                                                              !
! Futility is a jointly-maintained, open-source project between the University !
! of Michigan and Oak Ridge National Laboratory.  The copyright and license    !
! can be found in LICENSE.txt in the head directory of this repository.        !
!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!
!> @brief Module provides water properties at saturation conditions.
!>
!> The module provides interfaces to retrieve the saturation properties of
!> water give teh temperature or pressure:
!>  - pressure at a given temperature
!>  - temperature at a given pressure
!>  - liquid density at a given pressure or temperature
!>  - vapor density at a given pressure or temperature
!>
!> The properties have the following units:
!>  - temperature - Kelvin
!>  - pressure - psia
!>  - density - g/cc
!>
!> In evaluating the table the properties are linearly interpolated. The
!> table uses 1 degree K increments and covers virtually the full range
!> of saturation temperatures.
!>
!> If invalid inputs are given to any of the interfaces, the resulting value
!> of the output property is -HUGE(0.0_SRK).
!>
!> Reference:
!>  1. E.W. Lemmon, M.O. McLinden and D.G. Friend, "Thermophysical Properties
!>     of Fluid Systems" in NIST Chemistry WebBook, NIST Standard Reference
!>     Database Number 69, Eds. P.J. Linstrom and W.G. Mallard, National
!>     Institute of Standards and Technology, Gaithersburg MD, 20899,
!>     http://webbook.nist.gov, (retrieved April 7, 2015).
!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!
MODULE WaterSatProperties
USE IntrType

IMPLICIT NONE
PRIVATE

PUBLIC :: WaterSatProperties_Init
PUBLIC :: WaterSatProperties_GetPres
PUBLIC :: WaterSatProperties_GetTemp
PUBLIC :: WaterSatProperties_GetVapDens
PUBLIC :: WaterSatProperties_GetLiqDens

INTEGER(SIK),PARAMETER :: PRESSURE=1,RHOL=2,RHOV=3
LOGICAL(SBK),SAVE :: initTables=.FALSE.
REAL(SRK),DIMENSION(3,274:647),SAVE :: eostable=0
!
!===============================================================================
CONTAINS
!
!-------------------------------------------------------------------------------
SUBROUTINE WaterSatProperties_Init()
  IF(.NOT.initTables) THEN
    initTables=.TRUE.
    eostable(:,274)=(/9.42767845430E-02_SRK,9.99843254839E-01_SRK,5.14333839986E-06_SRK/)
    eostable(:,275)=(/1.01301777209E-01_SRK,9.99887406263E-01_SRK,5.50664918582E-06_SRK/)
    eostable(:,276)=(/1.08786394624E-01_SRK,9.99914453906E-01_SRK,5.89224918821E-06_SRK/)
    eostable(:,277)=(/1.16756232221E-01_SRK,9.99924951433E-01_SRK,6.30128437672E-06_SRK/)
    eostable(:,278)=(/1.25238147278E-01_SRK,9.99919420186E-01_SRK,6.73494699900E-06_SRK/)
    eostable(:,279)=(/1.34260128641E-01_SRK,9.99898351730E-01_SRK,7.19447684124E-06_SRK/)
    eostable(:,280)=(/1.43851379172E-01_SRK,9.99862210140E-01_SRK,7.68116249906E-06_SRK/)
    eostable(:,281)=(/1.54042441030E-01_SRK,9.99811434074E-01_SRK,8.19634265840E-06_SRK/)
    eostable(:,282)=(/1.64865115538E-01_SRK,9.99746438652E-01_SRK,8.74140738552E-06_SRK/)
    eostable(:,283)=(/1.76352613445E-01_SRK,9.99667617159E-01_SRK,9.31779942553E-06_SRK/)
    eostable(:,284)=(/1.88539516994E-01_SRK,9.99575342598E-01_SRK,9.92701550866E-06_SRK/)
    eostable(:,285)=(/2.01461839856E-01_SRK,9.99469969100E-01_SRK,1.05706076637E-05_SRK/)
    eostable(:,286)=(/2.15157128029E-01_SRK,9.99351833214E-01_SRK,1.12501845376E-05_SRK/)
    eostable(:,287)=(/2.29664381429E-01_SRK,9.99221255086E-01_SRK,1.19674127210E-05_SRK/)
    eostable(:,288)=(/2.45024243496E-01_SRK,9.99078539539E-01_SRK,1.27240180784E-05_SRK/)
    eostable(:,289)=(/2.61278923762E-01_SRK,9.98923977058E-01_SRK,1.35217870828E-05_SRK/)
    eostable(:,290)=(/2.78472328048E-01_SRK,9.98757844705E-01_SRK,1.43625681531E-05_SRK/)
    eostable(:,291)=(/2.96650034161E-01_SRK,9.98580406949E-01_SRK,1.52482729956E-05_SRK/)
    eostable(:,292)=(/3.15859389523E-01_SRK,9.98391916443E-01_SRK,1.61808779456E-05_SRK/)
    eostable(:,293)=(/3.36149554297E-01_SRK,9.98192614727E-01_SRK,1.71624253122E-05_SRK/)
    eostable(:,294)=(/3.57571503158E-01_SRK,9.97982732892E-01_SRK,1.81950247219E-05_SRK/)
    eostable(:,295)=(/3.80178108503E-01_SRK,9.97762492182E-01_SRK,1.92808544636E-05_SRK/)
    eostable(:,296)=(/4.04024208516E-01_SRK,9.97532104561E-01_SRK,2.04221628311E-05_SRK/)
    eostable(:,297)=(/4.29166609963E-01_SRK,9.97291773229E-01_SRK,2.16212694652E-05_SRK/)
    eostable(:,298)=(/4.55664143625E-01_SRK,9.97041693113E-01_SRK,2.28805666931E-05_SRK/)
    eostable(:,299)=(/4.83577730268E-01_SRK,9.96782051315E-01_SRK,2.42025208644E-05_SRK/)
    eostable(:,300)=(/5.12970461890E-01_SRK,9.96513027530E-01_SRK,2.55896736840E-05_SRK/)
    eostable(:,301)=(/5.43907546645E-01_SRK,9.96234794439E-01_SRK,2.70446435403E-05_SRK/)
    eostable(:,302)=(/5.76456473963E-01_SRK,9.95947518071E-01_SRK,2.85701268281E-05_SRK/)
    eostable(:,303)=(/6.10687006249E-01_SRK,9.95651358148E-01_SRK,3.01688992666E-05_SRK/)
    eostable(:,304)=(/6.46671225974E-01_SRK,9.95346468397E-01_SRK,3.18438172102E-05_SRK/)
    eostable(:,305)=(/6.84483597655E-01_SRK,9.95032996856E-01_SRK,3.35978189529E-05_SRK/)
    eostable(:,306)=(/7.24201025551E-01_SRK,9.94711086143E-01_SRK,3.54339260251E-05_SRK/)
    eostable(:,307)=(/7.65902900331E-01_SRK,9.94380873727E-01_SRK,3.73552444821E-05_SRK/)
    eostable(:,308)=(/8.09671123051E-01_SRK,9.94042492166E-01_SRK,3.93649661843E-05_SRK/)
    eostable(:,309)=(/8.55590223787E-01_SRK,9.93696069342E-01_SRK,4.14663700674E-05_SRK/)
    eostable(:,310)=(/9.03747313345E-01_SRK,9.93341728676E-01_SRK,4.36628234040E-05_SRK/)
    eostable(:,311)=(/9.54232232270E-01_SRK,9.92979589330E-01_SRK,4.59577830537E-05_SRK/)
    eostable(:,312)=(/1.00713752463E+00_SRK,9.92609766402E-01_SRK,4.83547967035E-05_SRK/)
    eostable(:,313)=(/1.06255855628E+00_SRK,9.92232371105E-01_SRK,5.08575040965E-05_SRK/)
    eostable(:,314)=(/1.12059351457E+00_SRK,9.91847510935E-01_SRK,5.34696382486E-05_SRK/)
    eostable(:,315)=(/1.18134345785E+00_SRK,9.91455289835E-01_SRK,5.61950266543E-05_SRK/)
    eostable(:,316)=(/1.24491242166E+00_SRK,9.91055808346E-01_SRK,5.90375924787E-05_SRK/)
    eostable(:,317)=(/1.31140740786E+00_SRK,9.90649163749E-01_SRK,6.20013557377E-05_SRK/)
    eostable(:,318)=(/1.38093847183E+00_SRK,9.90235450201E-01_SRK,6.50904344646E-05_SRK/)
    eostable(:,319)=(/1.45361875969E+00_SRK,9.89814758862E-01_SRK,6.83090458632E-05_SRK/)
    eostable(:,320)=(/1.52956455816E+00_SRK,9.89387178019E-01_SRK,7.16615074476E-05_SRK/)
    eostable(:,321)=(/1.60889535303E+00_SRK,9.88952793199E-01_SRK,7.51522381673E-05_SRK/)
    eostable(:,322)=(/1.69173385798E+00_SRK,9.88511687274E-01_SRK,7.87857595187E-05_SRK/)
    eostable(:,323)=(/1.77820610738E+00_SRK,9.88063940573E-01_SRK,8.25666966418E-05_SRK/)
    eostable(:,324)=(/1.86844145783E+00_SRK,9.87609630972E-01_SRK,8.64997794025E-05_SRK/)
    eostable(:,325)=(/1.96257266986E+00_SRK,9.87148833988E-01_SRK,9.05898434598E-05_SRK/)
    eostable(:,326)=(/2.06073592556E+00_SRK,9.86681622872E-01_SRK,9.48418313186E-05_SRK/)
    eostable(:,327)=(/2.16307092999E+00_SRK,9.86208068686E-01_SRK,9.92607933667E-05_SRK/)
    eostable(:,328)=(/2.26972089867E+00_SRK,9.85728240388E-01_SRK,1.03851888898E-04_SRK/)
    eostable(:,329)=(/2.38083264191E+00_SRK,9.85242204903E-01_SRK,1.08620387118E-04_SRK/)
    eostable(:,330)=(/2.49655661447E+00_SRK,9.84750027200E-01_SRK,1.13571668141E-04_SRK/)
    eostable(:,331)=(/2.61704694307E+00_SRK,9.84251770356E-01_SRK,1.18711223959E-04_SRK/)
    eostable(:,332)=(/2.74246147913E+00_SRK,9.83747495624E-01_SRK,1.24044659411E-04_SRK/)
    eostable(:,333)=(/2.87296186745E+00_SRK,9.83237262494E-01_SRK,1.29577693129E-04_SRK/)
    eostable(:,334)=(/3.00871354788E+00_SRK,9.82721128753E-01_SRK,1.35316158465E-04_SRK/)
    eostable(:,335)=(/3.14988584658E+00_SRK,9.82199150539E-01_SRK,1.41266004415E-04_SRK/)
    eostable(:,336)=(/3.29665199793E+00_SRK,9.81671382397E-01_SRK,1.47433296519E-04_SRK/)
    eostable(:,337)=(/3.44918918560E+00_SRK,9.81137877333E-01_SRK,1.53824217749E-04_SRK/)
    eostable(:,338)=(/3.60767860193E+00_SRK,9.80598686855E-01_SRK,1.60445069383E-04_SRK/)
    eostable(:,339)=(/3.77230548234E+00_SRK,9.80053861029E-01_SRK,1.67302271868E-04_SRK/)
    eostable(:,340)=(/3.94325913748E+00_SRK,9.79503448517E-01_SRK,1.74402365663E-04_SRK/)
    eostable(:,341)=(/4.12073301833E+00_SRK,9.78947496623E-01_SRK,1.81752012074E-04_SRK/)
    eostable(:,342)=(/4.30492475238E+00_SRK,9.78386051332E-01_SRK,1.89357994073E-04_SRK/)
    eostable(:,343)=(/4.49603616016E+00_SRK,9.77819157350E-01_SRK,1.97227217109E-04_SRK/)
    eostable(:,344)=(/4.69427333358E+00_SRK,9.77246858142E-01_SRK,2.05366709894E-04_SRK/)
    eostable(:,345)=(/4.89984664518E+00_SRK,9.76669195966E-01_SRK,2.13783625197E-04_SRK/)
    eostable(:,346)=(/5.11297080521E+00_SRK,9.76086211908E-01_SRK,2.22485240604E-04_SRK/)
    eostable(:,347)=(/5.33386489455E+00_SRK,9.75497945914E-01_SRK,2.31478959287E-04_SRK/)
    eostable(:,348)=(/5.56275239967E+00_SRK,9.74904436822E-01_SRK,2.40772310745E-04_SRK/)
    eostable(:,349)=(/5.79986125741E+00_SRK,9.74305722393E-01_SRK,2.50372951550E-04_SRK/)
    eostable(:,350)=(/6.04542388016E+00_SRK,9.73701839336E-01_SRK,2.60288666067E-04_SRK/)
    eostable(:,351)=(/6.29967720897E+00_SRK,9.73092823339E-01_SRK,2.70527367184E-04_SRK/)
    eostable(:,352)=(/6.56286273205E+00_SRK,9.72478709094E-01_SRK,2.81097097014E-04_SRK/)
    eostable(:,353)=(/6.83522652639E+00_SRK,9.71859530324E-01_SRK,2.92006027599E-04_SRK/)
    eostable(:,354)=(/7.11701929331E+00_SRK,9.71235319802E-01_SRK,3.03262461607E-04_SRK/)
    eostable(:,355)=(/7.40849638959E+00_SRK,9.70606109381E-01_SRK,3.14874833018E-04_SRK/)
    eostable(:,356)=(/7.70991785977E+00_SRK,9.69971930012E-01_SRK,3.26851707805E-04_SRK/)
    eostable(:,357)=(/8.02154846700E+00_SRK,9.69332811765E-01_SRK,3.39201784606E-04_SRK/)
    eostable(:,358)=(/8.34365772546E+00_SRK,9.68688783852E-01_SRK,3.51933895400E-04_SRK/)
    eostable(:,359)=(/8.67651992805E+00_SRK,9.68039874646E-01_SRK,3.65057006164E-04_SRK/)
    eostable(:,360)=(/9.02041417992E+00_SRK,9.67386111698E-01_SRK,3.78580217539E-04_SRK/)
    eostable(:,361)=(/9.37562442793E+00_SRK,9.66727521757E-01_SRK,3.92512765485E-04_SRK/)
    eostable(:,362)=(/9.74243947501E+00_SRK,9.66064130788E-01_SRK,4.06864021935E-04_SRK/)
    eostable(:,363)=(/1.01211530299E+01_SRK,9.65395963984E-01_SRK,4.21643495450E-04_SRK/)
    eostable(:,364)=(/1.05120637116E+01_SRK,9.64723045788E-01_SRK,4.36860831868E-04_SRK/)
    eostable(:,365)=(/1.09154750905E+01_SRK,9.64045399907E-01_SRK,4.52525814955E-04_SRK/)
    eostable(:,366)=(/1.13316957051E+01_SRK,9.63363049323E-01_SRK,4.68648367055E-04_SRK/)
    eostable(:,367)=(/1.17610390872E+01_SRK,9.62676016312E-01_SRK,4.85238549741E-04_SRK/)
    eostable(:,368)=(/1.22038237862E+01_SRK,9.61984322452E-01_SRK,5.02306564471E-04_SRK/)
    eostable(:,369)=(/1.26603733917E+01_SRK,9.61287988644E-01_SRK,5.19862753237E-04_SRK/)
    eostable(:,370)=(/1.31310165579E+01_SRK,9.60587035118E-01_SRK,5.37917599230E-04_SRK/)
    eostable(:,371)=(/1.36160870145E+01_SRK,9.59881481446E-01_SRK,5.56481727497E-04_SRK/)
    eostable(:,372)=(/1.41159236011E+01_SRK,9.59171346557E-01_SRK,5.75565905609E-04_SRK/)
    eostable(:,373)=(/1.46308702730E+01_SRK,9.58456648744E-01_SRK,5.95181044333E-04_SRK/)
    eostable(:,374)=(/1.51612761317E+01_SRK,9.57737405679E-01_SRK,6.15338198308E-04_SRK/)
    eostable(:,375)=(/1.57074954334E+01_SRK,9.57013634419E-01_SRK,6.36048566735E-04_SRK/)
    eostable(:,376)=(/1.62698876076E+01_SRK,9.56285351419E-01_SRK,6.57323494062E-04_SRK/)
    eostable(:,377)=(/1.68488172798E+01_SRK,9.55552572540E-01_SRK,6.79174470689E-04_SRK/)
    eostable(:,378)=(/1.74446542788E+01_SRK,9.54815313058E-01_SRK,7.01613133681E-04_SRK/)
    eostable(:,379)=(/1.80577736616E+01_SRK,9.54073587673E-01_SRK,7.24651267484E-04_SRK/)
    eostable(:,380)=(/1.86885557124E+01_SRK,9.53327410520E-01_SRK,7.48300804656E-04_SRK/)
    eostable(:,381)=(/1.93373859694E+01_SRK,9.52576795171E-01_SRK,7.72573826614E-04_SRK/)
    eostable(:,382)=(/2.00046552331E+01_SRK,9.51821754650E-01_SRK,7.97482564388E-04_SRK/)
    eostable(:,383)=(/2.06907595738E+01_SRK,9.51062301435E-01_SRK,8.23039399391E-04_SRK/)
    eostable(:,384)=(/2.13961003488E+01_SRK,9.50298447466E-01_SRK,8.49256864200E-04_SRK/)
    eostable(:,385)=(/2.21210842114E+01_SRK,9.49530204156E-01_SRK,8.76147643359E-04_SRK/)
    eostable(:,386)=(/2.28661231162E+01_SRK,9.48757582390E-01_SRK,9.03724574192E-04_SRK/)
    eostable(:,387)=(/2.36316343316E+01_SRK,9.47980592539E-01_SRK,9.32000647634E-04_SRK/)
    eostable(:,388)=(/2.44180404508E+01_SRK,9.47199244462E-01_SRK,9.60989009085E-04_SRK/)
    eostable(:,389)=(/2.52257693911E+01_SRK,9.46413547511E-01_SRK,9.90702959273E-04_SRK/)
    eostable(:,390)=(/2.60552544074E+01_SRK,9.45623510539E-01_SRK,1.02115595515E-03_SRK/)
    eostable(:,391)=(/2.69069340997E+01_SRK,9.44829141903E-01_SRK,1.05236161079E-03_SRK/)
    eostable(:,392)=(/2.77812524130E+01_SRK,9.44030449472E-01_SRK,1.08433369834E-03_SRK/)
    eostable(:,393)=(/2.86786586416E+01_SRK,9.43227440627E-01_SRK,1.11708614894E-03_SRK/)
    eostable(:,394)=(/2.95996074402E+01_SRK,9.42420122272E-01_SRK,1.15063305373E-03_SRK/)
    eostable(:,395)=(/3.05445588228E+01_SRK,9.41608500830E-01_SRK,1.18498866485E-03_SRK/)
    eostable(:,396)=(/3.15139781645E+01_SRK,9.40792582257E-01_SRK,1.22016739645E-03_SRK/)
    eostable(:,397)=(/3.25083362057E+01_SRK,9.39972372037E-01_SRK,1.25618382574E-03_SRK/)
    eostable(:,398)=(/3.35281090533E+01_SRK,9.39147875192E-01_SRK,1.29305269411E-03_SRK/)
    eostable(:,399)=(/3.45737781859E+01_SRK,9.38319096280E-01_SRK,1.33078890817E-03_SRK/)
    eostable(:,400)=(/3.56458304417E+01_SRK,9.37486039405E-01_SRK,1.36940754097E-03_SRK/)
    eostable(:,401)=(/3.67447580334E+01_SRK,9.36648708214E-01_SRK,1.40892383311E-03_SRK/)
    eostable(:,402)=(/3.78710585406E+01_SRK,9.35807105903E-01_SRK,1.44935319395E-03_SRK/)
    eostable(:,403)=(/3.90252349029E+01_SRK,9.34961235220E-01_SRK,1.49071120288E-03_SRK/)
    eostable(:,404)=(/4.02077954309E+01_SRK,9.34111098467E-01_SRK,1.53301361054E-03_SRK/)
    eostable(:,405)=(/4.14192537928E+01_SRK,9.33256697501E-01_SRK,1.57627634016E-03_SRK/)
    eostable(:,406)=(/4.26601290160E+01_SRK,9.32398033740E-01_SRK,1.62051548888E-03_SRK/)
    eostable(:,407)=(/4.39309454837E+01_SRK,9.31535108159E-01_SRK,1.66574732913E-03_SRK/)
    eostable(:,408)=(/4.52322329293E+01_SRK,9.30667921300E-01_SRK,1.71198831004E-03_SRK/)
    eostable(:,409)=(/4.65645264317E+01_SRK,9.29796473268E-01_SRK,1.75925505892E-03_SRK/)
    eostable(:,410)=(/4.79283664141E+01_SRK,9.28920763732E-01_SRK,1.80756438273E-03_SRK/)
    eostable(:,411)=(/4.93242986365E+01_SRK,9.28040791931E-01_SRK,1.85693326963E-03_SRK/)
    eostable(:,412)=(/5.07528741851E+01_SRK,9.27156556674E-01_SRK,1.90737889056E-03_SRK/)
    eostable(:,413)=(/5.22146494745E+01_SRK,9.26268056337E-01_SRK,1.95891860088E-03_SRK/)
    eostable(:,414)=(/5.37101862330E+01_SRK,9.25375288870E-01_SRK,2.01156994203E-03_SRK/)
    eostable(:,415)=(/5.52400515038E+01_SRK,9.24478251794E-01_SRK,2.06535064325E-03_SRK/)
    eostable(:,416)=(/5.68048176270E+01_SRK,9.23576942203E-01_SRK,2.12027862337E-03_SRK/)
    eostable(:,417)=(/5.84050622420E+01_SRK,9.22671356765E-01_SRK,2.17637199262E-03_SRK/)
    eostable(:,418)=(/6.00413682701E+01_SRK,9.21761491721E-01_SRK,2.23364905452E-03_SRK/)
    eostable(:,419)=(/6.17143239147E+01_SRK,9.20847342889E-01_SRK,2.29212830778E-03_SRK/)
    eostable(:,420)=(/6.34245226419E+01_SRK,9.19928905658E-01_SRK,2.35182844833E-03_SRK/)
    eostable(:,421)=(/6.51725631832E+01_SRK,9.19006174994E-01_SRK,2.41276837130E-03_SRK/)
    eostable(:,422)=(/6.69590495126E+01_SRK,9.18079145437E-01_SRK,2.47496717320E-03_SRK/)
    eostable(:,423)=(/6.87845908474E+01_SRK,9.17147811101E-01_SRK,2.53844415400E-03_SRK/)
    eostable(:,424)=(/7.06498016319E+01_SRK,9.16212165675E-01_SRK,2.60321881942E-03_SRK/)
    eostable(:,425)=(/7.25553015286E+01_SRK,9.15272202421E-01_SRK,2.66931088319E-03_SRK/)
    eostable(:,426)=(/7.45017154050E+01_SRK,9.14327914174E-01_SRK,2.73674026939E-03_SRK/)
    eostable(:,427)=(/7.64896733286E+01_SRK,9.13379293340E-01_SRK,2.80552711489E-03_SRK/)
    eostable(:,428)=(/7.85198105456E+01_SRK,9.12426331899E-01_SRK,2.87569177185E-03_SRK/)
    eostable(:,429)=(/8.05927674775E+01_SRK,9.11469021398E-01_SRK,2.94725481026E-03_SRK/)
    eostable(:,430)=(/8.27091897064E+01_SRK,9.10507352956E-01_SRK,3.02023702060E-03_SRK/)
    eostable(:,431)=(/8.48697279606E+01_SRK,9.09541317259E-01_SRK,3.09465941652E-03_SRK/)
    eostable(:,432)=(/8.70750381068E+01_SRK,9.08570904559E-01_SRK,3.17054323768E-03_SRK/)
    eostable(:,433)=(/8.93257811330E+01_SRK,9.07596104672E-01_SRK,3.24790995257E-03_SRK/)
    eostable(:,434)=(/9.16226231381E+01_SRK,9.06616906980E-01_SRK,3.32678126150E-03_SRK/)
    eostable(:,435)=(/9.39662353198E+01_SRK,9.05633300424E-01_SRK,3.40717909961E-03_SRK/)
    eostable(:,436)=(/9.63572939586E+01_SRK,9.04645273504E-01_SRK,3.48912564002E-03_SRK/)
    eostable(:,437)=(/9.87964804079E+01_SRK,9.03652814280E-01_SRK,3.57264329704E-03_SRK/)
    eostable(:,438)=(/1.01284481080E+02_SRK,9.02655910365E-01_SRK,3.65775472945E-03_SRK/)
    eostable(:,439)=(/1.03821987431E+02_SRK,9.01654548925E-01_SRK,3.74448284394E-03_SRK/)
    eostable(:,440)=(/1.06409695949E+02_SRK,9.00648716676E-01_SRK,3.83285079859E-03_SRK/)
    eostable(:,441)=(/1.09048308140E+02_SRK,8.99638399881E-01_SRK,3.92288200646E-03_SRK/)
    eostable(:,442)=(/1.11738530513E+02_SRK,8.98623584350E-01_SRK,4.01460013931E-03_SRK/)
    eostable(:,443)=(/1.14481074571E+02_SRK,8.97604255431E-01_SRK,4.10802913142E-03_SRK/)
    eostable(:,444)=(/1.17276656793E+02_SRK,8.96580398013E-01_SRK,4.20319318346E-03_SRK/)
    eostable(:,445)=(/1.20125998620E+02_SRK,8.95551996521E-01_SRK,4.30011676656E-03_SRK/)
    eostable(:,446)=(/1.23029826446E+02_SRK,8.94519034908E-01_SRK,4.39882462644E-03_SRK/)
    eostable(:,447)=(/1.25988871601E+02_SRK,8.93481496659E-01_SRK,4.49934178768E-03_SRK/)
    eostable(:,448)=(/1.29003870334E+02_SRK,8.92439364781E-01_SRK,4.60169355810E-03_SRK/)
    eostable(:,449)=(/1.32075563810E+02_SRK,8.91392621804E-01_SRK,4.70590553326E-03_SRK/)
    eostable(:,450)=(/1.35204698085E+02_SRK,8.90341249771E-01_SRK,4.81200360112E-03_SRK/)
    eostable(:,451)=(/1.38392024099E+02_SRK,8.89285230240E-01_SRK,4.92001394679E-03_SRK/)
    eostable(:,452)=(/1.41638297663E+02_SRK,8.88224544276E-01_SRK,5.02996305745E-03_SRK/)
    eostable(:,453)=(/1.44944279442E+02_SRK,8.87159172446E-01_SRK,5.14187772741E-03_SRK/)
    eostable(:,454)=(/1.48310734946E+02_SRK,8.86089094817E-01_SRK,5.25578506326E-03_SRK/)
    eostable(:,455)=(/1.51738434514E+02_SRK,8.85014290948E-01_SRK,5.37171248930E-03_SRK/)
    eostable(:,456)=(/1.55228153302E+02_SRK,8.83934739887E-01_SRK,5.48968775290E-03_SRK/)
    eostable(:,457)=(/1.58780671275E+02_SRK,8.82850420165E-01_SRK,5.60973893029E-03_SRK/)
    eostable(:,458)=(/1.62396773186E+02_SRK,8.81761309790E-01_SRK,5.73189443229E-03_SRK/)
    eostable(:,459)=(/1.66077248571E+02_SRK,8.80667386241E-01_SRK,5.85618301032E-03_SRK/)
    eostable(:,460)=(/1.69822891735E+02_SRK,8.79568626463E-01_SRK,5.98263376256E-03_SRK/)
    eostable(:,461)=(/1.73634501737E+02_SRK,8.78465006863E-01_SRK,6.11127614027E-03_SRK/)
    eostable(:,462)=(/1.77512882384E+02_SRK,8.77356503296E-01_SRK,6.24213995430E-03_SRK/)
    eostable(:,463)=(/1.81458842218E+02_SRK,8.76243091068E-01_SRK,6.37525538180E-03_SRK/)
    eostable(:,464)=(/1.85473194501E+02_SRK,8.75124744922E-01_SRK,6.51065297314E-03_SRK/)
    eostable(:,465)=(/1.89556757211E+02_SRK,8.74001439036E-01_SRK,6.64836365896E-03_SRK/)
    eostable(:,466)=(/1.93710353026E+02_SRK,8.72873147012E-01_SRK,6.78841875750E-03_SRK/)
    eostable(:,467)=(/1.97934809318E+02_SRK,8.71739841869E-01_SRK,6.93084998212E-03_SRK/)
    eostable(:,468)=(/2.02230958140E+02_SRK,8.70601496037E-01_SRK,7.07568944902E-03_SRK/)
    eostable(:,469)=(/2.06599636221E+02_SRK,8.69458081349E-01_SRK,7.22296968520E-03_SRK/)
    eostable(:,470)=(/2.11041684952E+02_SRK,8.68309569030E-01_SRK,7.37272363666E-03_SRK/)
    eostable(:,471)=(/2.15557950383E+02_SRK,8.67155929691E-01_SRK,7.52498467683E-03_SRK/)
    eostable(:,472)=(/2.20149283212E+02_SRK,8.65997133318E-01_SRK,7.67978661526E-03_SRK/)
    eostable(:,473)=(/2.24816538774E+02_SRK,8.64833149267E-01_SRK,7.83716370653E-03_SRK/)
    eostable(:,474)=(/2.29560577043E+02_SRK,8.63663946247E-01_SRK,7.99715065949E-03_SRK/)
    eostable(:,475)=(/2.34382262614E+02_SRK,8.62489492320E-01_SRK,8.15978264668E-03_SRK/)
    eostable(:,476)=(/2.39282464708E+02_SRK,8.61309754883E-01_SRK,8.32509531415E-03_SRK/)
    eostable(:,477)=(/2.44262057158E+02_SRK,8.60124700659E-01_SRK,8.49312479147E-03_SRK/)
    eostable(:,478)=(/2.49321918408E+02_SRK,8.58934295691E-01_SRK,8.66390770207E-03_SRK/)
    eostable(:,479)=(/2.54462931507E+02_SRK,8.57738505325E-01_SRK,8.83748117391E-03_SRK/)
    eostable(:,480)=(/2.59685984105E+02_SRK,8.56537294201E-01_SRK,9.01388285047E-03_SRK/)
    eostable(:,481)=(/2.64991968451E+02_SRK,8.55330626245E-01_SRK,9.19315090205E-03_SRK/)
    eostable(:,482)=(/2.70381781389E+02_SRK,8.54118464647E-01_SRK,9.37532403741E-03_SRK/)
    eostable(:,483)=(/2.75856324356E+02_SRK,8.52900771860E-01_SRK,9.56044151579E-03_SRK/)
    eostable(:,484)=(/2.81416503379E+02_SRK,8.51677509577E-01_SRK,9.74854315931E-03_SRK/)
    eostable(:,485)=(/2.87063229079E+02_SRK,8.50448638726E-01_SRK,9.93966936567E-03_SRK/)
    eostable(:,486)=(/2.92797416665E+02_SRK,8.49214119449E-01_SRK,1.01338611213E-02_SRK/)
    eostable(:,487)=(/2.98619985938E+02_SRK,8.47973911091E-01_SRK,1.03311600151E-02_SRK/)
    eostable(:,488)=(/3.04531861294E+02_SRK,8.46727972187E-01_SRK,1.05316082521E-02_SRK/)
    eostable(:,489)=(/3.10533971721E+02_SRK,8.45476260443E-01_SRK,1.07352486681E-02_SRK/)
    eostable(:,490)=(/3.16627250805E+02_SRK,8.44218732723E-01_SRK,1.09421247443E-02_SRK/)
    eostable(:,491)=(/3.22812636735E+02_SRK,8.42955345031E-01_SRK,1.11522806231E-02_SRK/)
    eostable(:,492)=(/3.29091072307E+02_SRK,8.41686052493E-01_SRK,1.13657611234E-02_SRK/)
    eostable(:,493)=(/3.35463504928E+02_SRK,8.40410809344E-01_SRK,1.15826117572E-02_SRK/)
    eostable(:,494)=(/3.41930886620E+02_SRK,8.39129568908E-01_SRK,1.18028787464E-02_SRK/)
    eostable(:,495)=(/3.48494174036E+02_SRK,8.37842283574E-01_SRK,1.20266090399E-02_SRK/)
    eostable(:,496)=(/3.55154328459E+02_SRK,8.36548904787E-01_SRK,1.22538503322E-02_SRK/)
    eostable(:,497)=(/3.61912315818E+02_SRK,8.35249383020E-01_SRK,1.24846510811E-02_SRK/)
    eostable(:,498)=(/3.68769106693E+02_SRK,8.33943667756E-01_SRK,1.27190605276E-02_SRK/)
    eostable(:,499)=(/3.75725676328E+02_SRK,8.32631707467E-01_SRK,1.29571287150E-02_SRK/)
    eostable(:,500)=(/3.82783004648E+02_SRK,8.31313449594E-01_SRK,1.31989065097E-02_SRK/)
    eostable(:,501)=(/3.89942076265E+02_SRK,8.29988840520E-01_SRK,1.34444456221E-02_SRK/)
    eostable(:,502)=(/3.97203880501E+02_SRK,8.28657825550E-01_SRK,1.36937986286E-02_SRK/)
    eostable(:,503)=(/4.04569411394E+02_SRK,8.27320348885E-01_SRK,1.39470189937E-02_SRK/)
    eostable(:,504)=(/4.12039667723E+02_SRK,8.25976353599E-01_SRK,1.42041610936E-02_SRK/)
    eostable(:,505)=(/4.19615653025E+02_SRK,8.24625781608E-01_SRK,1.44652802402E-02_SRK/)
    eostable(:,506)=(/4.27298375612E+02_SRK,8.23268573650E-01_SRK,1.47304327058E-02_SRK/)
    eostable(:,507)=(/4.35088848593E+02_SRK,8.21904669253E-01_SRK,1.49996757491E-02_SRK/)
    eostable(:,508)=(/4.42988089896E+02_SRK,8.20534006706E-01_SRK,1.52730676415E-02_SRK/)
    eostable(:,509)=(/4.50997122296E+02_SRK,8.19156523031E-01_SRK,1.55506676949E-02_SRK/)
    eostable(:,510)=(/4.59116973434E+02_SRK,8.17772153950E-01_SRK,1.58325362899E-02_SRK/)
    eostable(:,511)=(/4.67348675844E+02_SRK,8.16380833855E-01_SRK,1.61187349056E-02_SRK/)
    eostable(:,512)=(/4.75693266989E+02_SRK,8.14982495775E-01_SRK,1.64093261498E-02_SRK/)
    eostable(:,513)=(/4.84151789280E+02_SRK,8.13577071338E-01_SRK,1.67043737911E-02_SRK/)
    eostable(:,514)=(/4.92725290116E+02_SRK,8.12164490740E-01_SRK,1.70039427912E-02_SRK/)
    eostable(:,515)=(/5.01414821912E+02_SRK,8.10744682705E-01_SRK,1.73080993388E-02_SRK/)
    eostable(:,516)=(/5.10221442138E+02_SRK,8.09317574449E-01_SRK,1.76169108852E-02_SRK/)
    eostable(:,517)=(/5.19146213350E+02_SRK,8.07883091639E-01_SRK,1.79304461804E-02_SRK/)
    eostable(:,518)=(/5.28190203234E+02_SRK,8.06441158350E-01_SRK,1.82487753111E-02_SRK/)
    eostable(:,519)=(/5.37354484644E+02_SRK,8.04991697026E-01_SRK,1.85719697395E-02_SRK/)
    eostable(:,520)=(/5.46640135645E+02_SRK,8.03534628433E-01_SRK,1.89001023444E-02_SRK/)
    eostable(:,521)=(/5.56048239555E+02_SRK,8.02069871615E-01_SRK,1.92332474633E-02_SRK/)
    eostable(:,522)=(/5.65579884995E+02_SRK,8.00597343845E-01_SRK,1.95714809359E-02_SRK/)
    eostable(:,523)=(/5.75236165935E+02_SRK,7.99116960574E-01_SRK,1.99148801498E-02_SRK/)
    eostable(:,524)=(/5.85018181747E+02_SRK,7.97628635384E-01_SRK,2.02635240875E-02_SRK/)
    eostable(:,525)=(/5.94927037256E+02_SRK,7.96132279928E-01_SRK,2.06174933756E-02_SRK/)
    eostable(:,526)=(/6.04963842796E+02_SRK,7.94627803883E-01_SRK,2.09768703356E-02_SRK/)
    eostable(:,527)=(/6.15129714270E+02_SRK,7.93115114883E-01_SRK,2.13417390370E-02_SRK/)
    eostable(:,528)=(/6.25425773206E+02_SRK,7.91594118466E-01_SRK,2.17121853521E-02_SRK/)
    eostable(:,529)=(/6.35853146824E+02_SRK,7.90064718008E-01_SRK,2.20882970131E-02_SRK/)
    eostable(:,530)=(/6.46412968102E+02_SRK,7.88526814661E-01_SRK,2.24701636722E-02_SRK/)
    eostable(:,531)=(/6.57106375840E+02_SRK,7.86980307282E-01_SRK,2.28578769629E-02_SRK/)
    eostable(:,532)=(/6.67934514737E+02_SRK,7.85425092366E-01_SRK,2.32515305647E-02_SRK/)
    eostable(:,533)=(/6.78898535460E+02_SRK,7.83861063971E-01_SRK,2.36512202703E-02_SRK/)
    eostable(:,534)=(/6.89999594727E+02_SRK,7.82288113645E-01_SRK,2.40570440553E-02_SRK/)
    eostable(:,535)=(/7.01238855380E+02_SRK,7.80706130340E-01_SRK,2.44691021512E-02_SRK/)
    eostable(:,536)=(/7.12617486477E+02_SRK,7.79115000341E-01_SRK,2.48874971211E-02_SRK/)
    eostable(:,537)=(/7.24136663373E+02_SRK,7.77514607167E-01_SRK,2.53123339390E-02_SRK/)
    eostable(:,538)=(/7.35797567814E+02_SRK,7.75904831493E-01_SRK,2.57437200723E-02_SRK/)
    eostable(:,539)=(/7.47601388030E+02_SRK,7.74285551049E-01_SRK,2.61817655674E-02_SRK/)
    eostable(:,540)=(/7.59549318832E+02_SRK,7.72656640528E-01_SRK,2.66265831404E-02_SRK/)
    eostable(:,541)=(/7.71642561716E+02_SRK,7.71017971482E-01_SRK,2.70782882701E-02_SRK/)
    eostable(:,542)=(/7.83882324968E+02_SRK,7.69369412218E-01_SRK,2.75369992963E-02_SRK/)
    eostable(:,543)=(/7.96269823772E+02_SRK,7.67710827684E-01_SRK,2.80028375220E-02_SRK/)
    eostable(:,544)=(/8.08806280327E+02_SRK,7.66042079361E-01_SRK,2.84759273207E-02_SRK/)
    eostable(:,545)=(/8.21492923966E+02_SRK,7.64363025137E-01_SRK,2.89563962474E-02_SRK/)
    eostable(:,546)=(/8.34330991274E+02_SRK,7.62673519183E-01_SRK,2.94443751565E-02_SRK/)
    eostable(:,547)=(/8.47321726223E+02_SRK,7.60973411823E-01_SRK,2.99399983237E-02_SRK/)
    eostable(:,548)=(/8.60466380304E+02_SRK,7.59262549400E-01_SRK,3.04434035740E-02_SRK/)
    eostable(:,549)=(/8.73766212658E+02_SRK,7.57540774125E-01_SRK,3.09547324162E-02_SRK/)
    eostable(:,550)=(/8.87222490229E+02_SRK,7.55807923937E-01_SRK,3.14741301835E-02_SRK/)
    eostable(:,551)=(/9.00836487906E+02_SRK,7.54063832340E-01_SRK,3.20017461803E-02_SRK/)
    eostable(:,552)=(/9.14609488682E+02_SRK,7.52308328242E-01_SRK,3.25377338374E-02_SRK/)
    eostable(:,553)=(/9.28542783814E+02_SRK,7.50541235785E-01_SRK,3.30822508738E-02_SRK/)
    eostable(:,554)=(/9.42637672990E+02_SRK,7.48762374162E-01_SRK,3.36354594670E-02_SRK/)
    eostable(:,555)=(/9.56895464498E+02_SRK,7.46971557433E-01_SRK,3.41975264313E-02_SRK/)
    eostable(:,556)=(/9.71317475415E+02_SRK,7.45168594327E-01_SRK,3.47686234061E-02_SRK/)
    eostable(:,557)=(/9.85905031786E+02_SRK,7.43353288036E-01_SRK,3.53489270527E-02_SRK/)
    eostable(:,558)=(/1.00065946882E+03_SRK,7.41525435999E-01_SRK,3.59386192623E-02_SRK/)
    eostable(:,559)=(/1.01558213111E+03_SRK,7.39684829674E-01_SRK,3.65378873741E-02_SRK/)
    eostable(:,560)=(/1.03067437280E+03_SRK,7.37831254300E-01_SRK,3.71469244052E-02_SRK/)
    eostable(:,561)=(/1.04593755785E+03_SRK,7.35964488651E-01_SRK,3.77659292929E-02_SRK/)
    eostable(:,562)=(/1.06137306024E+03_SRK,7.34084304767E-01_SRK,3.83951071500E-02_SRK/)
    eostable(:,563)=(/1.07698226420E+03_SRK,7.32190467683E-01_SRK,3.90346695337E-02_SRK/)
    eostable(:,564)=(/1.09276656448E+03_SRK,7.30282735137E-01_SRK,3.96848347299E-02_SRK/)
    eostable(:,565)=(/1.10872736659E+03_SRK,7.28360857264E-01_SRK,4.03458280527E-02_SRK/)
    eostable(:,566)=(/1.12486608705E+03_SRK,7.26424576277E-01_SRK,4.10178821617E-02_SRK/)
    eostable(:,567)=(/1.14118415369E+03_SRK,7.24473626123E-01_SRK,4.17012373965E-02_SRK/)
    eostable(:,568)=(/1.15768300594E+03_SRK,7.22507732133E-01_SRK,4.23961421309E-02_SRK/)
    eostable(:,569)=(/1.17436409510E+03_SRK,7.20526610638E-01_SRK,4.31028531482E-02_SRK/)
    eostable(:,570)=(/1.19122888469E+03_SRK,7.18529968578E-01_SRK,4.38216360380E-02_SRK/)
    eostable(:,571)=(/1.20827885075E+03_SRK,7.16517503077E-01_SRK,4.45527656174E-02_SRK/)
    eostable(:,572)=(/1.22551548219E+03_SRK,7.14488900999E-01_SRK,4.52965263773E-02_SRK/)
    eostable(:,573)=(/1.24294028113E+03_SRK,7.12443838483E-01_SRK,4.60532129566E-02_SRK/)
    eostable(:,574)=(/1.26055476328E+03_SRK,7.10381980438E-01_SRK,4.68231306456E-02_SRK/)
    eostable(:,575)=(/1.27836045832E+03_SRK,7.08302980021E-01_SRK,4.76065959210E-02_SRK/)
    eostable(:,576)=(/1.29635891032E+03_SRK,7.06206478070E-01_SRK,4.84039370160E-02_SRK/)
    eostable(:,577)=(/1.31455167813E+03_SRK,7.04092102516E-01_SRK,4.92154945260E-02_SRK/)
    eostable(:,578)=(/1.33294033583E+03_SRK,7.01959467743E-01_SRK,5.00416220554E-02_SRK/)
    eostable(:,579)=(/1.35152647318E+03_SRK,6.99808173917E-01_SRK,5.08826869069E-02_SRK/)
    eostable(:,580)=(/1.37031169613E+03_SRK,6.97637806262E-01_SRK,5.17390708172E-02_SRK/)
    eostable(:,581)=(/1.38929762728E+03_SRK,6.95447934294E-01_SRK,5.26111707436E-02_SRK/)
    eostable(:,582)=(/1.40848590642E+03_SRK,6.93238110996E-01_SRK,5.34993997055E-02_SRK/)
    eostable(:,583)=(/1.42787819110E+03_SRK,6.91007871935E-01_SRK,5.44041876847E-02_SRK/)
    eostable(:,584)=(/1.44747615716E+03_SRK,6.88756734314E-01_SRK,5.53259825907E-02_SRK/)
    eostable(:,585)=(/1.46728149937E+03_SRK,6.86484195952E-01_SRK,5.62652512969E-02_SRK/)
    eostable(:,586)=(/1.48729593207E+03_SRK,6.84189734186E-01_SRK,5.72224807523E-02_SRK/)
    eostable(:,587)=(/1.50752118979E+03_SRK,6.81872804681E-01_SRK,5.81981791782E-02_SRK/)
    eostable(:,588)=(/1.52795902799E+03_SRK,6.79532840141E-01_SRK,5.91928773553E-02_SRK/)
    eostable(:,589)=(/1.54861122376E+03_SRK,6.77169248920E-01_SRK,6.02071300119E-02_SRK/)
    eostable(:,590)=(/1.56947957663E+03_SRK,6.74781413492E-01_SRK,6.12415173211E-02_SRK/)
    eostable(:,591)=(/1.59056590934E+03_SRK,6.72368688802E-01_SRK,6.22966465193E-02_SRK/)
    eostable(:,592)=(/1.61187206871E+03_SRK,6.69930400446E-01_SRK,6.33731536567E-02_SRK/)
    eostable(:,593)=(/1.63339992654E+03_SRK,6.67465842684E-01_SRK,6.44717054945E-02_SRK/)
    eostable(:,594)=(/1.65515138055E+03_SRK,6.64974276251E-01_SRK,6.55930015630E-02_SRK/)
    eostable(:,595)=(/1.67712835538E+03_SRK,6.62454925946E-01_SRK,6.67377763974E-02_SRK/)
    eostable(:,596)=(/1.69933280363E+03_SRK,6.59906977959E-01_SRK,6.79068019731E-02_SRK/)
    eostable(:,597)=(/1.72176670699E+03_SRK,6.57329576911E-01_SRK,6.91008903569E-02_SRK/)
    eostable(:,598)=(/1.74443207736E+03_SRK,6.54721822562E-01_SRK,7.03208966052E-02_SRK/)
    eostable(:,599)=(/1.76733095812E+03_SRK,6.52082766138E-01_SRK,7.15677219316E-02_SRK/)
    eostable(:,600)=(/1.79046542542E+03_SRK,6.49411406218E-01_SRK,7.28423171792E-02_SRK/)
    eostable(:,601)=(/1.81383758951E+03_SRK,6.46706684134E-01_SRK,7.41456866306E-02_SRK/)
    eostable(:,602)=(/1.83744959623E+03_SRK,6.43967478792E-01_SRK,7.54788922010E-02_SRK/)
    eostable(:,603)=(/1.86130362848E+03_SRK,6.41192600838E-01_SRK,7.68430580588E-02_SRK/)
    eostable(:,604)=(/1.88540190785E+03_SRK,6.38380786076E-01_SRK,7.82393757286E-02_SRK/)
    eostable(:,605)=(/1.90974669624E+03_SRK,6.35530688014E-01_SRK,7.96691097421E-02_SRK/)
    eostable(:,606)=(/1.93434029770E+03_SRK,6.32640869426E-01_SRK,8.11336039078E-02_SRK/)
    eostable(:,607)=(/1.95918506022E+03_SRK,6.29709792758E-01_SRK,8.26342882851E-02_SRK/)
    eostable(:,608)=(/1.98428337769E+03_SRK,6.26735809228E-01_SRK,8.41726869628E-02_SRK/)
    eostable(:,609)=(/2.00963769190E+03_SRK,6.23717146411E-01_SRK,8.57504267579E-02_SRK/)
    eostable(:,610)=(/2.03525049471E+03_SRK,6.20651894085E-01_SRK,8.73692469709E-02_SRK/)
    eostable(:,611)=(/2.06112433023E+03_SRK,6.17537988080E-01_SRK,8.90310103600E-02_SRK/)
    eostable(:,612)=(/2.08726179714E+03_SRK,6.14373191829E-01_SRK,9.07377155250E-02_SRK/)
    eostable(:,613)=(/2.11366555107E+03_SRK,6.11155075282E-01_SRK,9.24915109296E-02_SRK/)
    eostable(:,614)=(/2.14033830712E+03_SRK,6.07880990801E-01_SRK,9.42947108362E-02_SRK/)
    eostable(:,615)=(/2.16728284242E+03_SRK,6.04548045578E-01_SRK,9.61498134821E-02_SRK/)
    eostable(:,616)=(/2.19450199885E+03_SRK,6.01153070090E-01_SRK,9.80595218963E-02_SRK/)
    eostable(:,617)=(/2.22199868578E+03_SRK,5.97692582015E-01_SRK,1.00026767845E-01_SRK/)
    eostable(:,618)=(/2.24977588307E+03_SRK,5.94162744982E-01_SRK,1.02054739502E-01_SRK/)
    eostable(:,619)=(/2.27783664400E+03_SRK,5.90559321433E-01_SRK,1.04146913578E-01_SRK/)
    eostable(:,620)=(/2.30618409863E+03_SRK,5.86877618850E-01_SRK,1.06307092842E-01_SRK/)
    eostable(:,621)=(/2.33482145715E+03_SRK,5.83112428490E-01_SRK,1.08539450158E-01_SRK/)
    eostable(:,622)=(/2.36375201379E+03_SRK,5.79257955786E-01_SRK,1.10848580525E-01_SRK/)
    eostable(:,623)=(/2.39297915099E+03_SRK,5.75307741544E-01_SRK,1.13239562965E-01_SRK/)
    eostable(:,624)=(/2.42250634449E+03_SRK,5.71254573149E-01_SRK,1.15718034656E-01_SRK/)
    eostable(:,625)=(/2.45233716922E+03_SRK,5.67090385172E-01_SRK,1.18290280442E-01_SRK/)
    eostable(:,626)=(/2.48247530683E+03_SRK,5.62806149093E-01_SRK,1.20963341846E-01_SRK/)
    eostable(:,627)=(/2.51292455544E+03_SRK,5.58391752350E-01_SRK,1.23745151071E-01_SRK/)
    eostable(:,628)=(/2.54368884247E+03_SRK,5.53835867722E-01_SRK,1.26644697450E-01_SRK/)
    eostable(:,629)=(/2.57477224236E+03_SRK,5.49125814951E-01_SRK,1.29672236529E-01_SRK/)
    eostable(:,630)=(/2.60617900101E+03_SRK,5.44247417437E-01_SRK,1.32839556025E-01_SRK/)
    eostable(:,631)=(/2.63791356961E+03_SRK,5.39184856917E-01_SRK,1.36160318717E-01_SRK/)
    eostable(:,632)=(/2.66998065445E+03_SRK,5.33920526999E-01_SRK,1.39650511943E-01_SRK/)
    eostable(:,633)=(/2.70238528151E+03_SRK,5.28434876525E-01_SRK,1.43329044869E-01_SRK/)
    eostable(:,634)=(/2.73513289242E+03_SRK,5.22706211979E-01_SRK,1.47218560096E-01_SRK/)
    eostable(:,635)=(/2.76822947229E+03_SRK,5.16710372113E-01_SRK,1.51346556440E-01_SRK/)
    eostable(:,636)=(/2.80168172161E+03_SRK,5.10420076436E-01_SRK,1.55746979347E-01_SRK/)
    eostable(:,637)=(/2.83549727827E+03_SRK,5.03803532816E-01_SRK,1.60462531308E-01_SRK/)
    eostable(:,638)=(/2.86968498951E+03_SRK,4.96821508197E-01_SRK,1.65548126242E-01_SRK/)
    eostable(:,639)=(/2.90425521942E+03_SRK,4.89421439113E-01_SRK,1.71076229801E-01_SRK/)
    eostable(:,640)=(/2.93922015278E+03_SRK,4.81526146100E-01_SRK,1.77145452592E-01_SRK/)
    eostable(:,641)=(/2.97459401744E+03_SRK,4.73012905154E-01_SRK,1.83895080578E-01_SRK/)
    eostable(:,642)=(/3.01039308475E+03_SRK,4.63674610686E-01_SRK,1.91531249058E-01_SRK/)
    eostable(:,643)=(/3.04663518597E+03_SRK,4.53144141581E-01_SRK,2.00378185969E-01_SRK/)
    eostable(:,644)=(/3.08333823065E+03_SRK,4.40732911809E-01_SRK,2.10990802828E-01_SRK/)
    eostable(:,645)=(/3.12051723860E+03_SRK,4.25048244509E-01_SRK,2.24450536593E-01_SRK/)
    eostable(:,646)=(/3.15818384329E+03_SRK,4.02957909280E-01_SRK,2.43461855885E-01_SRK/)
    eostable(:,647)=(/3.19640055732E+03_SRK,3.57340727141E-01_SRK,2.86508220087E-01_SRK/)
  ENDIF
ENDSUBROUTINE WaterSatProperties_Init
!
!-------------------------------------------------------------------------------
FUNCTION WaterSatProperties_GetPres(T) RESULT(P)
  REAL(SRK),INTENT(IN) :: T
  REAL(SRK) :: P

  INTEGER(SIK) :: it
  REAL(SRK) :: dT

  P=-HUGE(P)
  IF(initTables) THEN
    it=INT(T)
    dT=T-REAL(it,SRK)
    IF(273 < it .AND. it < 675) &
        P=eostable(PRESSURE,it+1)*dT-eostable(PRESSURE,it)*dT+eostable(PRESSURE,it)
  ENDIF
ENDFUNCTION WaterSatProperties_GetPres
!
!-------------------------------------------------------------------------------
FUNCTION WaterSatProperties_GetTemp(P) RESULT(T)
  REAL(SRK),INTENT(IN) :: P
  REAL(SRK) :: T

  INTEGER(SIK) :: iphi,iplo,ipmid

  T=-HUGE(T)
  IF(initTables) THEN
    iplo=274
    iphi=647
    DO WHILE(iphi >= iplo)
      ipmid=iplo+iphi
      ipmid=ipmid/2
      IF(eostable(PRESSURE,ipmid) .APPROXEQA. P) THEN
        iphi=ipmid
        iplo=ipmid-1
        EXIT
      ELSEIF(eostable(PRESSURE,ipmid) < P) THEN
        iplo=ipmid+1
      ELSE
        iphi=ipmid-1
      ENDIF
    ENDDO
    !In normal exit iplo=iphi+1
    IF(iplo < 648 .AND. iphi > 273) &
        T=REAL(iphi,SRK)+(P-eostable(PRESSURE,iphi))/(eostable(PRESSURE,iplo)-eostable(PRESSURE,iphi))
  ENDIF
ENDFUNCTION WaterSatProperties_GetTemp
!
!-------------------------------------------------------------------------------
FUNCTION WaterSatProperties_GetVapDens(P,T) RESULT(vrho)
  REAL(SRK),INTENT(IN),OPTIONAL :: P
  REAL(SRK),INTENT(IN),OPTIONAL :: T
  REAL(SRK) :: vrho

  INTEGER(SIK) :: it
  REAL(SRK) :: T_local,dT

  vrho=-HUGE(vrho)
  IF(initTables) THEN
    T_local=vrho
    IF(PRESENT(T)) THEN
      T_local=T
    ELSEIF(PRESENT(P)) THEN
      T_local=WaterSatProperties_GetTemp(P)
    ENDIF
    IF(T_local /= vrho) THEN
      it=INT(T_local)
      dT=T_local-REAL(it,SRK)
      IF(273 < it .AND. it < 675) &
          vrho=eostable(RHOV,it+1)*dT-eostable(RHOV,it)*dT+eostable(RHOV,it)
    ENDIF
  ENDIF
ENDFUNCTION WaterSatProperties_GetVapDens
!
!-------------------------------------------------------------------------------
FUNCTION WaterSatProperties_GetLiqDens(P,T) RESULT(lrho)
  REAL(SRK),INTENT(IN),OPTIONAL :: P
  REAL(SRK),INTENT(IN),OPTIONAL :: T
  REAL(SRK) :: lrho

  INTEGER(SIK) :: it
  REAL(SRK) :: T_local,dT

  lrho=-HUGE(lrho)
  IF(initTables) THEN
    T_local=lrho
    IF(PRESENT(T)) THEN
      T_local=T
    ELSEIF(PRESENT(P)) THEN
      T_local=WaterSatProperties_GetTemp(P)
    ENDIF
    IF(T_local /= lrho) THEN
      it=INT(T_local)
      dT=T_local-REAL(it,SRK)
      IF(273 < it .AND. it < 675) &
          lrho=eostable(RHOL,it+1)*dT-eostable(RHOL,it)*dT+eostable(RHOL,it)
    ENDIF
  ENDIF
ENDFUNCTION WaterSatProperties_GetLiqDens
!
ENDMODULE WaterSatProperties

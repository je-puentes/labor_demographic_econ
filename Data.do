* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix                   ///
  int     year         1-4      ///
  long    sample       5-10     ///
  double  serial       11-18    ///
  double  cbserial     19-31    ///
  double  hhwt         32-41    ///
  double  cluster      42-54    ///
  byte    metro        55-55    ///
  double  strata       56-67    ///
  byte    gq           68-68    ///
  long    hhincome     69-75    ///
  int     pernum       76-79    ///
  double  perwt        80-89    ///
  byte    sfrelate     90-90    ///
  byte    sploc        91-92    ///
  byte    sprule       93-94    ///
  byte    nchild       95-95    ///
  byte    nchlt5       96-96    ///
  byte    relate       97-98    ///
  int     related      99-102   ///
  byte    sex          103-103  ///
  int     age          104-106  ///
  byte    marst        107-107  ///
  byte    race         108-108  ///
  int     raced        109-111  ///
  byte    educ         112-113  ///
  int     educd        114-116  ///
  byte    empstat      117-117  ///
  byte    empstatd     118-119  ///
  byte    wkswork2     120-120  ///
  byte    uhrswork     121-122  ///
  long    inctot       123-129  ///
  long    incwage      130-135  ///
  long    incss        136-140  ///
  long    incwelfr     141-145  ///
  int     pernum_sp    146-149  ///
  double  perwt_sp     150-159  ///
  byte    sfrelate_sp  160-160  ///
  byte    sploc_sp     161-162  ///
  byte    sprule_sp    163-164  ///
  byte    nchild_sp    165-165  ///
  byte    nchlt5_sp    166-166  ///
  byte    relate_sp    167-168  ///
  int     related_sp   169-172  ///
  byte    sex_sp       173-173  ///
  int     age_sp       174-176  ///
  byte    marst_sp     177-177  ///
  byte    race_sp      178-178  ///
  int     raced_sp     179-181  ///
  byte    educ_sp      182-183  ///
  int     educd_sp     184-186  ///
  byte    empstat_sp   187-187  ///
  byte    empstatd_sp  188-189  ///
  byte    wkswork2_sp  190-190  ///
  byte    uhrswork_sp  191-192  ///
  long    inctot_sp    193-199  ///
  long    incwage_sp   200-205  ///
  long    incss_sp     206-210  ///
  long    incwelfr_sp  211-215  ///
  using `"usa_00003.dat"'

replace hhwt        = hhwt        / 100
replace perwt       = perwt       / 100
replace perwt_sp    = perwt_sp    / 100

format serial      %8.0f
format cbserial    %13.0f
format hhwt        %10.2f
format cluster     %13.0f
format strata      %12.0f
format perwt       %10.2f
format perwt_sp    %10.2f

label var year        `"Census year"'
label var sample      `"IPUMS sample identifier"'
label var serial      `"Household serial number"'
label var cbserial    `"Original Census Bureau household serial number"'
label var hhwt        `"Household weight"'
label var cluster     `"Household cluster for variance estimation"'
label var metro       `"Metropolitan status"'
label var strata      `"Household strata for variance estimation"'
label var gq          `"Group quarters status"'
label var hhincome    `"Total household income "'
label var pernum      `"Person number in sample unit"'
label var perwt       `"Person weight"'
label var sfrelate    `"Relationship within subfamily"'
label var sploc       `"Spouse's location in household"'
label var sprule      `"Rule for linking spouse or partner (new)"'
label var nchild      `"Number of own children in the household"'
label var nchlt5      `"Number of own children under age 5 in household"'
label var relate      `"Relationship to household head [general version]"'
label var related     `"Relationship to household head [detailed version]"'
label var sex         `"Sex"'
label var age         `"Age"'
label var marst       `"Marital status"'
label var race        `"Race [general version]"'
label var raced       `"Race [detailed version]"'
label var educ        `"Educational attainment [general version]"'
label var educd       `"Educational attainment [detailed version]"'
label var empstat     `"Employment status [general version]"'
label var empstatd    `"Employment status [detailed version]"'
label var wkswork2    `"Weeks worked last year, intervalled"'
label var uhrswork    `"Usual hours worked per week"'
label var inctot      `"Total personal income"'
label var incwage     `"Wage and salary income"'
label var incss       `"Social Security income"'
label var incwelfr    `"Welfare (public assistance) income"'
label var pernum_sp   `"Person number in sample unit [of Spouse's location in household]"'
label var perwt_sp    `"Person weight [of Spouse's location in household]"'
label var sfrelate_sp `"Relationship within subfamily [of Spouse's location in household]"'
label var sploc_sp    `"Spouse's location in household [of Spouse's location in household]"'
label var sprule_sp   `"Rule for linking spouse or partner (new) [of Spouse's location in household]"'
label var nchild_sp   `"Number of own children in the household [of Spouse's location in household]"'
label var nchlt5_sp   `"Number of own children under age 5 in household [of Spouse's location in househo"'
label var relate_sp   `"Relationship to household head [of Spouse's location in household; general versi"'
label var related_sp  `"Relationship to household head [of Spouse's location in household; detailed vers"'
label var sex_sp      `"Sex [of Spouse's location in household]"'
label var age_sp      `"Age [of Spouse's location in household]"'
label var marst_sp    `"Marital status [of Spouse's location in household]"'
label var race_sp     `"Race [of Spouse's location in household; general version]"'
label var raced_sp    `"Race [of Spouse's location in household; detailed version]"'
label var educ_sp     `"Educational attainment [of Spouse's location in household; general version]"'
label var educd_sp    `"Educational attainment [of Spouse's location in household; detailed version]"'
label var empstat_sp  `"Employment status [of Spouse's location in household; general version]"'
label var empstatd_sp `"Employment status [of Spouse's location in household; detailed version]"'
label var wkswork2_sp `"Weeks worked last year, intervalled [of Spouse's location in household]"'
label var uhrswork_sp `"Usual hours worked per week [of Spouse's location in household]"'
label var inctot_sp   `"Total personal income [of Spouse's location in household]"'
label var incwage_sp  `"Wage and salary income [of Spouse's location in household]"'
label var incss_sp    `"Social Security income [of Spouse's location in household]"'
label var incwelfr_sp `"Welfare (public assistance) income [of Spouse's location in household]"'

label define year_lbl 1850 `"1850"'
label define year_lbl 1860 `"1860"', add
label define year_lbl 1870 `"1870"', add
label define year_lbl 1880 `"1880"', add
label define year_lbl 1900 `"1900"', add
label define year_lbl 1910 `"1910"', add
label define year_lbl 1920 `"1920"', add
label define year_lbl 1930 `"1930"', add
label define year_lbl 1940 `"1940"', add
label define year_lbl 1950 `"1950"', add
label define year_lbl 1960 `"1960"', add
label define year_lbl 1970 `"1970"', add
label define year_lbl 1980 `"1980"', add
label define year_lbl 1990 `"1990"', add
label define year_lbl 2000 `"2000"', add
label define year_lbl 2001 `"2001"', add
label define year_lbl 2002 `"2002"', add
label define year_lbl 2003 `"2003"', add
label define year_lbl 2004 `"2004"', add
label define year_lbl 2005 `"2005"', add
label define year_lbl 2006 `"2006"', add
label define year_lbl 2007 `"2007"', add
label define year_lbl 2008 `"2008"', add
label define year_lbl 2009 `"2009"', add
label define year_lbl 2010 `"2010"', add
label define year_lbl 2011 `"2011"', add
label define year_lbl 2012 `"2012"', add
label define year_lbl 2013 `"2013"', add
label define year_lbl 2014 `"2014"', add
label define year_lbl 2015 `"2015"', add
label define year_lbl 2016 `"2016"', add
label define year_lbl 2017 `"2017"', add
label define year_lbl 2018 `"2018"', add
label define year_lbl 2019 `"2019"', add
label define year_lbl 2020 `"2020"', add
label define year_lbl 2021 `"2021"', add
label values year year_lbl

label define sample_lbl 202102 `"2021 PRCS"'
label define sample_lbl 202101 `"2021 ACS"', add
label define sample_lbl 202004 `"2016-2020, PRCS 5-year"', add
label define sample_lbl 202003 `"2016-2020, ACS 5-year"', add
label define sample_lbl 202001 `"2020 ACS"', add
label define sample_lbl 201904 `"2015-2019, PRCS 5-year"', add
label define sample_lbl 201903 `"2015-2019, ACS 5-year"', add
label define sample_lbl 201902 `"2019 PRCS"', add
label define sample_lbl 201901 `"2019 ACS"', add
label define sample_lbl 201804 `"2014-2018, PRCS 5-year"', add
label define sample_lbl 201803 `"2014-2018, ACS 5-year"', add
label define sample_lbl 201802 `"2018 PRCS"', add
label define sample_lbl 201801 `"2018 ACS"', add
label define sample_lbl 201704 `"2013-2017, PRCS 5-year"', add
label define sample_lbl 201703 `"2013-2017, ACS 5-year"', add
label define sample_lbl 201702 `"2017 PRCS"', add
label define sample_lbl 201701 `"2017 ACS"', add
label define sample_lbl 201604 `"2012-2016, PRCS 5-year"', add
label define sample_lbl 201603 `"2012-2016, ACS 5-year"', add
label define sample_lbl 201602 `"2016 PRCS"', add
label define sample_lbl 201601 `"2016 ACS"', add
label define sample_lbl 201504 `"2011-2015, PRCS 5-year"', add
label define sample_lbl 201503 `"2011-2015, ACS 5-year"', add
label define sample_lbl 201502 `"2015 PRCS"', add
label define sample_lbl 201501 `"2015 ACS"', add
label define sample_lbl 201404 `"2010-2014, PRCS 5-year"', add
label define sample_lbl 201403 `"2010-2014, ACS 5-year"', add
label define sample_lbl 201402 `"2014 PRCS"', add
label define sample_lbl 201401 `"2014 ACS"', add
label define sample_lbl 201306 `"2009-2013, PRCS 5-year"', add
label define sample_lbl 201305 `"2009-2013, ACS 5-year"', add
label define sample_lbl 201304 `"2011-2013, PRCS 3-year"', add
label define sample_lbl 201303 `"2011-2013, ACS 3-year"', add
label define sample_lbl 201302 `"2013 PRCS"', add
label define sample_lbl 201301 `"2013 ACS"', add
label define sample_lbl 201206 `"2008-2012, PRCS 5-year"', add
label define sample_lbl 201205 `"2008-2012, ACS 5-year"', add
label define sample_lbl 201204 `"2010-2012, PRCS 3-year"', add
label define sample_lbl 201203 `"2010-2012, ACS 3-year"', add
label define sample_lbl 201202 `"2012 PRCS"', add
label define sample_lbl 201201 `"2012 ACS"', add
label define sample_lbl 201106 `"2007-2011, PRCS 5-year"', add
label define sample_lbl 201105 `"2007-2011, ACS 5-year"', add
label define sample_lbl 201104 `"2009-2011, PRCS 3-year"', add
label define sample_lbl 201103 `"2009-2011, ACS 3-year"', add
label define sample_lbl 201102 `"2011 PRCS"', add
label define sample_lbl 201101 `"2011 ACS"', add
label define sample_lbl 201008 `"2010 Puerto Rico 10%"', add
label define sample_lbl 201007 `"2010 10%"', add
label define sample_lbl 201006 `"2006-2010, PRCS 5-year"', add
label define sample_lbl 201005 `"2006-2010, ACS 5-year"', add
label define sample_lbl 201004 `"2008-2010, PRCS 3-year"', add
label define sample_lbl 201003 `"2008-2010, ACS 3-year"', add
label define sample_lbl 201002 `"2010 PRCS"', add
label define sample_lbl 201001 `"2010 ACS"', add
label define sample_lbl 200906 `"2005-2009, PRCS 5-year"', add
label define sample_lbl 200905 `"2005-2009, ACS 5-year"', add
label define sample_lbl 200904 `"2007-2009, PRCS 3-year"', add
label define sample_lbl 200903 `"2007-2009, ACS 3-year"', add
label define sample_lbl 200902 `"2009 PRCS"', add
label define sample_lbl 200901 `"2009 ACS"', add
label define sample_lbl 200804 `"2006-2008, PRCS 3-year"', add
label define sample_lbl 200803 `"2006-2008, ACS 3-year"', add
label define sample_lbl 200802 `"2008 PRCS"', add
label define sample_lbl 200801 `"2008 ACS"', add
label define sample_lbl 200704 `"2005-2007, PRCS 3-year"', add
label define sample_lbl 200703 `"2005-2007, ACS 3-year"', add
label define sample_lbl 200702 `"2007 PRCS"', add
label define sample_lbl 200701 `"2007 ACS"', add
label define sample_lbl 200602 `"2006 PRCS"', add
label define sample_lbl 200601 `"2006 ACS"', add
label define sample_lbl 200502 `"2005 PRCS"', add
label define sample_lbl 200501 `"2005 ACS"', add
label define sample_lbl 200401 `"2004 ACS"', add
label define sample_lbl 200301 `"2003 ACS"', add
label define sample_lbl 200201 `"2002 ACS"', add
label define sample_lbl 200101 `"2001 ACS"', add
label define sample_lbl 200008 `"2000 Puerto Rico 1%"', add
label define sample_lbl 200007 `"2000 1%"', add
label define sample_lbl 200006 `"2000 Puerto Rico 1% sample (old version)"', add
label define sample_lbl 200005 `"2000 Puerto Rico 5%"', add
label define sample_lbl 200004 `"2000 ACS"', add
label define sample_lbl 200003 `"2000 Unweighted 1%"', add
label define sample_lbl 200002 `"2000 1% sample (old version)"', add
label define sample_lbl 200001 `"2000 5%"', add
label define sample_lbl 199007 `"1990 Puerto Rico 1%"', add
label define sample_lbl 199006 `"1990 Puerto Rico 5%"', add
label define sample_lbl 199005 `"1990 Labor Market Area"', add
label define sample_lbl 199004 `"1990 Elderly"', add
label define sample_lbl 199003 `"1990 Unweighted 1%"', add
label define sample_lbl 199002 `"1990 1%"', add
label define sample_lbl 199001 `"1990 5%"', add
label define sample_lbl 198007 `"1980 Puerto Rico 1%"', add
label define sample_lbl 198006 `"1980 Puerto Rico 5%"', add
label define sample_lbl 198005 `"1980 Detailed metro/non-metro"', add
label define sample_lbl 198004 `"1980 Labor Market Area"', add
label define sample_lbl 198003 `"1980 Urban/Rural"', add
label define sample_lbl 198002 `"1980 1%"', add
label define sample_lbl 198001 `"1980 5%"', add
label define sample_lbl 197009 `"1970 Puerto Rico Neighborhood"', add
label define sample_lbl 197008 `"1970 Puerto Rico Municipio"', add
label define sample_lbl 197007 `"1970 Puerto Rico State"', add
label define sample_lbl 197006 `"1970 Form 2 Neighborhood"', add
label define sample_lbl 197005 `"1970 Form 1 Neighborhood"', add
label define sample_lbl 197004 `"1970 Form 2 Metro"', add
label define sample_lbl 197003 `"1970 Form 1 Metro"', add
label define sample_lbl 197002 `"1970 Form 2 State"', add
label define sample_lbl 197001 `"1970 Form 1 State"', add
label define sample_lbl 196002 `"1960 5%"', add
label define sample_lbl 196001 `"1960 1%"', add
label define sample_lbl 195001 `"1950 1%"', add
label define sample_lbl 194002 `"1940 100% database"', add
label define sample_lbl 194001 `"1940 1%"', add
label define sample_lbl 193004 `"1930 100% database"', add
label define sample_lbl 193003 `"1930 Puerto Rico"', add
label define sample_lbl 193002 `"1930 5%"', add
label define sample_lbl 193001 `"1930 1%"', add
label define sample_lbl 192003 `"1920 100% database"', add
label define sample_lbl 192002 `"1920 Puerto Rico sample"', add
label define sample_lbl 192001 `"1920 1%"', add
label define sample_lbl 191004 `"1910 100% database"', add
label define sample_lbl 191003 `"1910 1.4% sample with oversamples"', add
label define sample_lbl 191002 `"1910 1%"', add
label define sample_lbl 191001 `"1910 Puerto Rico"', add
label define sample_lbl 190004 `"1900 100% database"', add
label define sample_lbl 190003 `"1900 1% sample with oversamples"', add
label define sample_lbl 190002 `"1900 1%"', add
label define sample_lbl 190001 `"1900 5%"', add
label define sample_lbl 188003 `"1880 100% database"', add
label define sample_lbl 188002 `"1880 10%"', add
label define sample_lbl 188001 `"1880 1%"', add
label define sample_lbl 187003 `"1870 100% database"', add
label define sample_lbl 187002 `"1870 1% sample with black oversample"', add
label define sample_lbl 187001 `"1870 1%"', add
label define sample_lbl 186003 `"1860 100% database"', add
label define sample_lbl 186002 `"1860 1% sample with black oversample"', add
label define sample_lbl 186001 `"1860 1%"', add
label define sample_lbl 185002 `"1850 100% database"', add
label define sample_lbl 185001 `"1850 1%"', add
label values sample sample_lbl

label define metro_lbl 0 `"Metropolitan status indeterminable (mixed)"'
label define metro_lbl 1 `"Not in metropolitan area"', add
label define metro_lbl 2 `"In metropolitan area: In central/principal city"', add
label define metro_lbl 3 `"In metropolitan area: Not in central/principal city"', add
label define metro_lbl 4 `"In metropolitan area: Central/principal city status indeterminable (mixed)"', add
label values metro metro_lbl

label define gq_lbl 0 `"Vacant unit"'
label define gq_lbl 1 `"Households under 1970 definition"', add
label define gq_lbl 2 `"Additional households under 1990 definition"', add
label define gq_lbl 3 `"Group quarters--Institutions"', add
label define gq_lbl 4 `"Other group quarters"', add
label define gq_lbl 5 `"Additional households under 2000 definition"', add
label define gq_lbl 6 `"Fragment"', add
label values gq gq_lbl

label define hhincome_lbl 9999998 `"9999998"'
label define hhincome_lbl 9999999 `"9999999"', add
label values hhincome hhincome_lbl

label define sfrelate_lbl 0 `"Group quarters or not in subfamily"'
label define sfrelate_lbl 1 `"Reference person"', add
label define sfrelate_lbl 2 `"Spouse (married-couple subfamily only)"', add
label define sfrelate_lbl 3 `"Child"', add
label values sfrelate sfrelate_lbl

label define sprule_lbl 00 `"No spouse or partner link"'
label define sprule_lbl 11 `"Direct link, clarity level 1"', add
label define sprule_lbl 12 `"Direct link, clarity level 2"', add
label define sprule_lbl 13 `"Direct link, clarity level 3"', add
label define sprule_lbl 14 `"Direct link, clarity level 4"', add
label define sprule_lbl 21 `"Second level link, clarity level 1"', add
label define sprule_lbl 22 `"Second level link, clarity level 2"', add
label define sprule_lbl 23 `"Second level link, clarity level 3"', add
label define sprule_lbl 24 `"Second level link, clarity level 4"', add
label define sprule_lbl 31 `"Third level link, clarity level 1"', add
label define sprule_lbl 32 `"Third level link, clarity level 2"', add
label define sprule_lbl 33 `"Third level link, clarity level 3"', add
label define sprule_lbl 34 `"Third level link, clarity level 4"', add
label define sprule_lbl 41 `"Fourth level link, clarity level 1"', add
label define sprule_lbl 42 `"Fourth level link, clarity level 2"', add
label define sprule_lbl 43 `"Fourth level link, clarity level 3"', add
label define sprule_lbl 44 `"Fourth level link, clarity level 4"', add
label define sprule_lbl 51 `"Fifth level link, clarity level 1"', add
label define sprule_lbl 52 `"Fifth level link, clarity level 2"', add
label define sprule_lbl 53 `"Fifth level link, clarity level 3"', add
label define sprule_lbl 54 `"Fifth level link, clarity level 4"', add
label values sprule sprule_lbl

label define nchild_lbl 0 `"0 children present"'
label define nchild_lbl 1 `"1 child present"', add
label define nchild_lbl 2 `"2"', add
label define nchild_lbl 3 `"3"', add
label define nchild_lbl 4 `"4"', add
label define nchild_lbl 5 `"5"', add
label define nchild_lbl 6 `"6"', add
label define nchild_lbl 7 `"7"', add
label define nchild_lbl 8 `"8"', add
label define nchild_lbl 9 `"9+"', add
label values nchild nchild_lbl

label define nchlt5_lbl 0 `"No children under age 5"'
label define nchlt5_lbl 1 `"1 child under age 5"', add
label define nchlt5_lbl 2 `"2"', add
label define nchlt5_lbl 3 `"3"', add
label define nchlt5_lbl 4 `"4"', add
label define nchlt5_lbl 5 `"5"', add
label define nchlt5_lbl 6 `"6"', add
label define nchlt5_lbl 7 `"7"', add
label define nchlt5_lbl 8 `"8"', add
label define nchlt5_lbl 9 `"9+"', add
label values nchlt5 nchlt5_lbl

label define relate_lbl 01 `"Head/Householder"'
label define relate_lbl 02 `"Spouse"', add
label define relate_lbl 03 `"Child"', add
label define relate_lbl 04 `"Child-in-law"', add
label define relate_lbl 05 `"Parent"', add
label define relate_lbl 06 `"Parent-in-Law"', add
label define relate_lbl 07 `"Sibling"', add
label define relate_lbl 08 `"Sibling-in-Law"', add
label define relate_lbl 09 `"Grandchild"', add
label define relate_lbl 10 `"Other relatives"', add
label define relate_lbl 11 `"Partner, friend, visitor"', add
label define relate_lbl 12 `"Other non-relatives"', add
label define relate_lbl 13 `"Institutional inmates"', add
label values relate relate_lbl

label define related_lbl 0101 `"Head/Householder"'
label define related_lbl 0201 `"Spouse"', add
label define related_lbl 0202 `"2nd/3rd Wife (Polygamous)"', add
label define related_lbl 0301 `"Child"', add
label define related_lbl 0302 `"Adopted Child"', add
label define related_lbl 0303 `"Stepchild"', add
label define related_lbl 0304 `"Adopted, n.s."', add
label define related_lbl 0401 `"Child-in-law"', add
label define related_lbl 0402 `"Step Child-in-law"', add
label define related_lbl 0501 `"Parent"', add
label define related_lbl 0502 `"Stepparent"', add
label define related_lbl 0601 `"Parent-in-Law"', add
label define related_lbl 0602 `"Stepparent-in-law"', add
label define related_lbl 0701 `"Sibling"', add
label define related_lbl 0702 `"Step/Half/Adopted Sibling"', add
label define related_lbl 0801 `"Sibling-in-Law"', add
label define related_lbl 0802 `"Step/Half Sibling-in-law"', add
label define related_lbl 0901 `"Grandchild"', add
label define related_lbl 0902 `"Adopted Grandchild"', add
label define related_lbl 0903 `"Step Grandchild"', add
label define related_lbl 0904 `"Grandchild-in-law"', add
label define related_lbl 1000 `"Other relatives:"', add
label define related_lbl 1001 `"Other Relatives"', add
label define related_lbl 1011 `"Grandparent"', add
label define related_lbl 1012 `"Step Grandparent"', add
label define related_lbl 1013 `"Grandparent-in-law"', add
label define related_lbl 1021 `"Aunt or Uncle"', add
label define related_lbl 1022 `"Aunt,Uncle-in-law"', add
label define related_lbl 1031 `"Nephew, Niece"', add
label define related_lbl 1032 `"Neph/Niece-in-law"', add
label define related_lbl 1033 `"Step/Adopted Nephew/Niece"', add
label define related_lbl 1034 `"Grand Niece/Nephew"', add
label define related_lbl 1041 `"Cousin"', add
label define related_lbl 1042 `"Cousin-in-law"', add
label define related_lbl 1051 `"Great Grandchild"', add
label define related_lbl 1061 `"Other relatives, nec"', add
label define related_lbl 1100 `"Partner, Friend, Visitor"', add
label define related_lbl 1110 `"Partner/friend"', add
label define related_lbl 1111 `"Friend"', add
label define related_lbl 1112 `"Partner"', add
label define related_lbl 1113 `"Partner/roommate"', add
label define related_lbl 1114 `"Unmarried Partner"', add
label define related_lbl 1115 `"Housemate/Roomate"', add
label define related_lbl 1120 `"Relative of partner"', add
label define related_lbl 1130 `"Concubine/Mistress"', add
label define related_lbl 1131 `"Visitor"', add
label define related_lbl 1132 `"Companion and family of companion"', add
label define related_lbl 1139 `"Allocated partner/friend/visitor"', add
label define related_lbl 1200 `"Other non-relatives"', add
label define related_lbl 1201 `"Roomers/boarders/lodgers"', add
label define related_lbl 1202 `"Boarders"', add
label define related_lbl 1203 `"Lodgers"', add
label define related_lbl 1204 `"Roomer"', add
label define related_lbl 1205 `"Tenant"', add
label define related_lbl 1206 `"Foster child"', add
label define related_lbl 1210 `"Employees:"', add
label define related_lbl 1211 `"Servant"', add
label define related_lbl 1212 `"Housekeeper"', add
label define related_lbl 1213 `"Maid"', add
label define related_lbl 1214 `"Cook"', add
label define related_lbl 1215 `"Nurse"', add
label define related_lbl 1216 `"Other probable domestic employee"', add
label define related_lbl 1217 `"Other employee"', add
label define related_lbl 1219 `"Relative of employee"', add
label define related_lbl 1221 `"Military"', add
label define related_lbl 1222 `"Students"', add
label define related_lbl 1223 `"Members of religious orders"', add
label define related_lbl 1230 `"Other non-relatives"', add
label define related_lbl 1239 `"Allocated other non-relative"', add
label define related_lbl 1240 `"Roomers/boarders/lodgers and foster children"', add
label define related_lbl 1241 `"Roomers/boarders/lodgers"', add
label define related_lbl 1242 `"Foster children"', add
label define related_lbl 1250 `"Employees"', add
label define related_lbl 1251 `"Domestic employees"', add
label define related_lbl 1252 `"Non-domestic employees"', add
label define related_lbl 1253 `"Relative of employee"', add
label define related_lbl 1260 `"Other non-relatives (1990 includes employees)"', add
label define related_lbl 1270 `"Non-inmate 1990"', add
label define related_lbl 1281 `"Head of group quarters"', add
label define related_lbl 1282 `"Employees of group quarters"', add
label define related_lbl 1283 `"Relative of head, staff, or employee group quarters"', add
label define related_lbl 1284 `"Other non-inmate 1940-1959"', add
label define related_lbl 1291 `"Military"', add
label define related_lbl 1292 `"College dormitories"', add
label define related_lbl 1293 `"Residents of rooming houses"', add
label define related_lbl 1294 `"Other non-inmate 1980 (includes employees and non-inmates in"', add
label define related_lbl 1295 `"Other non-inmates 1960-1970 (includes employees)"', add
label define related_lbl 1296 `"Non-inmates in institutions"', add
label define related_lbl 1301 `"Institutional inmates"', add
label define related_lbl 9996 `"Unclassifiable"', add
label define related_lbl 9997 `"Unknown"', add
label define related_lbl 9998 `"Illegible"', add
label define related_lbl 9999 `"Missing"', add
label values related related_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label values sex sex_lbl

label define age_lbl 000 `"Less than 1 year old"'
label define age_lbl 001 `"1"', add
label define age_lbl 002 `"2"', add
label define age_lbl 003 `"3"', add
label define age_lbl 004 `"4"', add
label define age_lbl 005 `"5"', add
label define age_lbl 006 `"6"', add
label define age_lbl 007 `"7"', add
label define age_lbl 008 `"8"', add
label define age_lbl 009 `"9"', add
label define age_lbl 010 `"10"', add
label define age_lbl 011 `"11"', add
label define age_lbl 012 `"12"', add
label define age_lbl 013 `"13"', add
label define age_lbl 014 `"14"', add
label define age_lbl 015 `"15"', add
label define age_lbl 016 `"16"', add
label define age_lbl 017 `"17"', add
label define age_lbl 018 `"18"', add
label define age_lbl 019 `"19"', add
label define age_lbl 020 `"20"', add
label define age_lbl 021 `"21"', add
label define age_lbl 022 `"22"', add
label define age_lbl 023 `"23"', add
label define age_lbl 024 `"24"', add
label define age_lbl 025 `"25"', add
label define age_lbl 026 `"26"', add
label define age_lbl 027 `"27"', add
label define age_lbl 028 `"28"', add
label define age_lbl 029 `"29"', add
label define age_lbl 030 `"30"', add
label define age_lbl 031 `"31"', add
label define age_lbl 032 `"32"', add
label define age_lbl 033 `"33"', add
label define age_lbl 034 `"34"', add
label define age_lbl 035 `"35"', add
label define age_lbl 036 `"36"', add
label define age_lbl 037 `"37"', add
label define age_lbl 038 `"38"', add
label define age_lbl 039 `"39"', add
label define age_lbl 040 `"40"', add
label define age_lbl 041 `"41"', add
label define age_lbl 042 `"42"', add
label define age_lbl 043 `"43"', add
label define age_lbl 044 `"44"', add
label define age_lbl 045 `"45"', add
label define age_lbl 046 `"46"', add
label define age_lbl 047 `"47"', add
label define age_lbl 048 `"48"', add
label define age_lbl 049 `"49"', add
label define age_lbl 050 `"50"', add
label define age_lbl 051 `"51"', add
label define age_lbl 052 `"52"', add
label define age_lbl 053 `"53"', add
label define age_lbl 054 `"54"', add
label define age_lbl 055 `"55"', add
label define age_lbl 056 `"56"', add
label define age_lbl 057 `"57"', add
label define age_lbl 058 `"58"', add
label define age_lbl 059 `"59"', add
label define age_lbl 060 `"60"', add
label define age_lbl 061 `"61"', add
label define age_lbl 062 `"62"', add
label define age_lbl 063 `"63"', add
label define age_lbl 064 `"64"', add
label define age_lbl 065 `"65"', add
label define age_lbl 066 `"66"', add
label define age_lbl 067 `"67"', add
label define age_lbl 068 `"68"', add
label define age_lbl 069 `"69"', add
label define age_lbl 070 `"70"', add
label define age_lbl 071 `"71"', add
label define age_lbl 072 `"72"', add
label define age_lbl 073 `"73"', add
label define age_lbl 074 `"74"', add
label define age_lbl 075 `"75"', add
label define age_lbl 076 `"76"', add
label define age_lbl 077 `"77"', add
label define age_lbl 078 `"78"', add
label define age_lbl 079 `"79"', add
label define age_lbl 080 `"80"', add
label define age_lbl 081 `"81"', add
label define age_lbl 082 `"82"', add
label define age_lbl 083 `"83"', add
label define age_lbl 084 `"84"', add
label define age_lbl 085 `"85"', add
label define age_lbl 086 `"86"', add
label define age_lbl 087 `"87"', add
label define age_lbl 088 `"88"', add
label define age_lbl 089 `"89"', add
label define age_lbl 090 `"90 (90+ in 1980 and 1990)"', add
label define age_lbl 091 `"91"', add
label define age_lbl 092 `"92"', add
label define age_lbl 093 `"93"', add
label define age_lbl 094 `"94"', add
label define age_lbl 095 `"95"', add
label define age_lbl 096 `"96"', add
label define age_lbl 097 `"97"', add
label define age_lbl 098 `"98"', add
label define age_lbl 099 `"99"', add
label define age_lbl 100 `"100 (100+ in 1960-1970)"', add
label define age_lbl 101 `"101"', add
label define age_lbl 102 `"102"', add
label define age_lbl 103 `"103"', add
label define age_lbl 104 `"104"', add
label define age_lbl 105 `"105"', add
label define age_lbl 106 `"106"', add
label define age_lbl 107 `"107"', add
label define age_lbl 108 `"108"', add
label define age_lbl 109 `"109"', add
label define age_lbl 110 `"110"', add
label define age_lbl 111 `"111"', add
label define age_lbl 112 `"112 (112+ in the 1980 internal data)"', add
label define age_lbl 113 `"113"', add
label define age_lbl 114 `"114"', add
label define age_lbl 115 `"115 (115+ in the 1990 internal data)"', add
label define age_lbl 116 `"116"', add
label define age_lbl 117 `"117"', add
label define age_lbl 118 `"118"', add
label define age_lbl 119 `"119"', add
label define age_lbl 120 `"120"', add
label define age_lbl 121 `"121"', add
label define age_lbl 122 `"122"', add
label define age_lbl 123 `"123"', add
label define age_lbl 124 `"124"', add
label define age_lbl 125 `"125"', add
label define age_lbl 126 `"126"', add
label define age_lbl 129 `"129"', add
label define age_lbl 130 `"130"', add
label define age_lbl 135 `"135"', add
label values age age_lbl

label define marst_lbl 1 `"Married, spouse present"'
label define marst_lbl 2 `"Married, spouse absent"', add
label define marst_lbl 3 `"Separated"', add
label define marst_lbl 4 `"Divorced"', add
label define marst_lbl 5 `"Widowed"', add
label define marst_lbl 6 `"Never married/single"', add
label values marst marst_lbl

label define race_lbl 1 `"White"'
label define race_lbl 2 `"Black/African American"', add
label define race_lbl 3 `"American Indian or Alaska Native"', add
label define race_lbl 4 `"Chinese"', add
label define race_lbl 5 `"Japanese"', add
label define race_lbl 6 `"Other Asian or Pacific Islander"', add
label define race_lbl 7 `"Other race, nec"', add
label define race_lbl 8 `"Two major races"', add
label define race_lbl 9 `"Three or more major races"', add
label values race race_lbl

label define raced_lbl 100 `"White"'
label define raced_lbl 110 `"Spanish write_in"', add
label define raced_lbl 120 `"Blank (white) (1850)"', add
label define raced_lbl 130 `"Portuguese"', add
label define raced_lbl 140 `"Mexican (1930)"', add
label define raced_lbl 150 `"Puerto Rican (1910 Hawaii)"', add
label define raced_lbl 200 `"Black/African American"', add
label define raced_lbl 210 `"Mulatto"', add
label define raced_lbl 300 `"American Indian/Alaska Native"', add
label define raced_lbl 302 `"Apache"', add
label define raced_lbl 303 `"Blackfoot"', add
label define raced_lbl 304 `"Cherokee"', add
label define raced_lbl 305 `"Cheyenne"', add
label define raced_lbl 306 `"Chickasaw"', add
label define raced_lbl 307 `"Chippewa"', add
label define raced_lbl 308 `"Choctaw"', add
label define raced_lbl 309 `"Comanche"', add
label define raced_lbl 310 `"Creek"', add
label define raced_lbl 311 `"Crow"', add
label define raced_lbl 312 `"Iroquois"', add
label define raced_lbl 313 `"Kiowa"', add
label define raced_lbl 314 `"Lumbee"', add
label define raced_lbl 315 `"Navajo"', add
label define raced_lbl 316 `"Osage"', add
label define raced_lbl 317 `"Paiute"', add
label define raced_lbl 318 `"Pima"', add
label define raced_lbl 319 `"Potawatomi"', add
label define raced_lbl 320 `"Pueblo"', add
label define raced_lbl 321 `"Seminole"', add
label define raced_lbl 322 `"Shoshone"', add
label define raced_lbl 323 `"Sioux"', add
label define raced_lbl 324 `"Tlingit (Tlingit_Haida, 2000/ACS)"', add
label define raced_lbl 325 `"Tohono O Odham"', add
label define raced_lbl 326 `"All other tribes (1990)"', add
label define raced_lbl 328 `"Hopi"', add
label define raced_lbl 329 `"Central American Indian"', add
label define raced_lbl 330 `"Spanish American Indian"', add
label define raced_lbl 350 `"Delaware"', add
label define raced_lbl 351 `"Latin American Indian"', add
label define raced_lbl 352 `"Puget Sound Salish"', add
label define raced_lbl 353 `"Yakama"', add
label define raced_lbl 354 `"Yaqui"', add
label define raced_lbl 355 `"Colville"', add
label define raced_lbl 356 `"Houma"', add
label define raced_lbl 357 `"Menominee"', add
label define raced_lbl 358 `"Yuman"', add
label define raced_lbl 359 `"South American Indian"', add
label define raced_lbl 360 `"Mexican American Indian"', add
label define raced_lbl 361 `"Other Amer. Indian tribe (2000,ACS)"', add
label define raced_lbl 362 `"2+ Amer. Indian tribes (2000,ACS)"', add
label define raced_lbl 370 `"Alaskan Athabaskan"', add
label define raced_lbl 371 `"Aleut"', add
label define raced_lbl 372 `"Eskimo"', add
label define raced_lbl 373 `"Alaskan mixed"', add
label define raced_lbl 374 `"Inupiat"', add
label define raced_lbl 375 `"Yup'ik"', add
label define raced_lbl 379 `"Other Alaska Native tribe(s) (2000,ACS)"', add
label define raced_lbl 398 `"Both Am. Ind. and Alaska Native (2000,ACS)"', add
label define raced_lbl 399 `"Tribe not specified"', add
label define raced_lbl 400 `"Chinese"', add
label define raced_lbl 410 `"Taiwanese"', add
label define raced_lbl 420 `"Chinese and Taiwanese"', add
label define raced_lbl 500 `"Japanese"', add
label define raced_lbl 600 `"Filipino"', add
label define raced_lbl 610 `"Asian Indian (Hindu 1920_1940)"', add
label define raced_lbl 620 `"Korean"', add
label define raced_lbl 630 `"Hawaiian"', add
label define raced_lbl 631 `"Hawaiian and Asian (1900,1920)"', add
label define raced_lbl 632 `"Hawaiian and European (1900,1920)"', add
label define raced_lbl 634 `"Hawaiian mixed"', add
label define raced_lbl 640 `"Vietnamese"', add
label define raced_lbl 641 `"Bhutanese"', add
label define raced_lbl 642 `"Mongolian"', add
label define raced_lbl 643 `"Nepalese"', add
label define raced_lbl 650 `"Other Asian or Pacific Islander (1920,1980)"', add
label define raced_lbl 651 `"Asian only (CPS)"', add
label define raced_lbl 652 `"Pacific Islander only (CPS)"', add
label define raced_lbl 653 `"Asian or Pacific Islander, n.s. (1990 Internal Census files)"', add
label define raced_lbl 660 `"Cambodian"', add
label define raced_lbl 661 `"Hmong"', add
label define raced_lbl 662 `"Laotian"', add
label define raced_lbl 663 `"Thai"', add
label define raced_lbl 664 `"Bangladeshi"', add
label define raced_lbl 665 `"Burmese"', add
label define raced_lbl 666 `"Indonesian"', add
label define raced_lbl 667 `"Malaysian"', add
label define raced_lbl 668 `"Okinawan"', add
label define raced_lbl 669 `"Pakistani"', add
label define raced_lbl 670 `"Sri Lankan"', add
label define raced_lbl 671 `"Other Asian, n.e.c."', add
label define raced_lbl 672 `"Asian, not specified"', add
label define raced_lbl 673 `"Chinese and Japanese"', add
label define raced_lbl 674 `"Chinese and Filipino"', add
label define raced_lbl 675 `"Chinese and Vietnamese"', add
label define raced_lbl 676 `"Chinese and Asian write_in"', add
label define raced_lbl 677 `"Japanese and Filipino"', add
label define raced_lbl 678 `"Asian Indian and Asian write_in"', add
label define raced_lbl 679 `"Other Asian race combinations"', add
label define raced_lbl 680 `"Samoan"', add
label define raced_lbl 681 `"Tahitian"', add
label define raced_lbl 682 `"Tongan"', add
label define raced_lbl 683 `"Other Polynesian (1990)"', add
label define raced_lbl 684 `"1+ other Polynesian races (2000,ACS)"', add
label define raced_lbl 685 `"Chamorro"', add
label define raced_lbl 686 `"Northern Mariana Islander"', add
label define raced_lbl 687 `"Palauan"', add
label define raced_lbl 688 `"Other Micronesian (1990)"', add
label define raced_lbl 689 `"1+ other Micronesian races (2000,ACS)"', add
label define raced_lbl 690 `"Fijian"', add
label define raced_lbl 691 `"Other Melanesian (1990)"', add
label define raced_lbl 692 `"1+ other Melanesian races (2000,ACS)"', add
label define raced_lbl 698 `"2+ PI races from 2+ PI regions"', add
label define raced_lbl 699 `"Pacific Islander, n.s."', add
label define raced_lbl 700 `"Other race, n.e.c."', add
label define raced_lbl 801 `"White and Black"', add
label define raced_lbl 802 `"White and AIAN"', add
label define raced_lbl 810 `"White and Asian"', add
label define raced_lbl 811 `"White and Chinese"', add
label define raced_lbl 812 `"White and Japanese"', add
label define raced_lbl 813 `"White and Filipino"', add
label define raced_lbl 814 `"White and Asian Indian"', add
label define raced_lbl 815 `"White and Korean"', add
label define raced_lbl 816 `"White and Vietnamese"', add
label define raced_lbl 817 `"White and Asian write_in"', add
label define raced_lbl 818 `"White and other Asian race(s)"', add
label define raced_lbl 819 `"White and two or more Asian groups"', add
label define raced_lbl 820 `"White and PI"', add
label define raced_lbl 821 `"White and Native Hawaiian"', add
label define raced_lbl 822 `"White and Samoan"', add
label define raced_lbl 823 `"White and Chamorro"', add
label define raced_lbl 824 `"White and PI write_in"', add
label define raced_lbl 825 `"White and other PI race(s)"', add
label define raced_lbl 826 `"White and other race write_in"', add
label define raced_lbl 827 `"White and other race, n.e.c."', add
label define raced_lbl 830 `"Black and AIAN"', add
label define raced_lbl 831 `"Black and Asian"', add
label define raced_lbl 832 `"Black and Chinese"', add
label define raced_lbl 833 `"Black and Japanese"', add
label define raced_lbl 834 `"Black and Filipino"', add
label define raced_lbl 835 `"Black and Asian Indian"', add
label define raced_lbl 836 `"Black and Korean"', add
label define raced_lbl 837 `"Black and Asian write_in"', add
label define raced_lbl 838 `"Black and other Asian race(s)"', add
label define raced_lbl 840 `"Black and PI"', add
label define raced_lbl 841 `"Black and PI write_in"', add
label define raced_lbl 842 `"Black and other PI race(s)"', add
label define raced_lbl 845 `"Black and other race write_in"', add
label define raced_lbl 850 `"AIAN and Asian"', add
label define raced_lbl 851 `"AIAN and Filipino (2000 1%)"', add
label define raced_lbl 852 `"AIAN and Asian Indian"', add
label define raced_lbl 853 `"AIAN and Asian write_in (2000 1%)"', add
label define raced_lbl 854 `"AIAN and other Asian race(s)"', add
label define raced_lbl 855 `"AIAN and PI"', add
label define raced_lbl 856 `"AIAN and other race write_in"', add
label define raced_lbl 860 `"Asian and PI"', add
label define raced_lbl 861 `"Chinese and Hawaiian"', add
label define raced_lbl 862 `"Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_lbl 863 `"Japanese and Hawaiian (2000 1%)"', add
label define raced_lbl 864 `"Filipino and Hawaiian"', add
label define raced_lbl 865 `"Filipino and PI write_in"', add
label define raced_lbl 866 `"Asian Indian and PI write_in (2000 1%)"', add
label define raced_lbl 867 `"Asian write_in and PI write_in"', add
label define raced_lbl 868 `"Other Asian race(s) and PI race(s)"', add
label define raced_lbl 869 `"Japanese and Korean (ACS)"', add
label define raced_lbl 880 `"Asian and other race write_in"', add
label define raced_lbl 881 `"Chinese and other race write_in"', add
label define raced_lbl 882 `"Japanese and other race write_in"', add
label define raced_lbl 883 `"Filipino and other race write_in"', add
label define raced_lbl 884 `"Asian Indian and other race write_in"', add
label define raced_lbl 885 `"Asian write_in and other race write_in"', add
label define raced_lbl 886 `"Other Asian race(s) and other race write_in"', add
label define raced_lbl 887 `"Chinese and Korean"', add
label define raced_lbl 890 `"PI and other race write_in:"', add
label define raced_lbl 891 `"PI write_in and other race write_in"', add
label define raced_lbl 892 `"Other PI race(s) and other race write_in"', add
label define raced_lbl 893 `"Native Hawaiian or PI other race(s)"', add
label define raced_lbl 899 `"API and other race write_in"', add
label define raced_lbl 901 `"White, Black, AIAN"', add
label define raced_lbl 902 `"White, Black, Asian"', add
label define raced_lbl 903 `"White, Black, PI"', add
label define raced_lbl 904 `"White, Black, other race write_in"', add
label define raced_lbl 905 `"White, AIAN, Asian"', add
label define raced_lbl 906 `"White, AIAN, PI"', add
label define raced_lbl 907 `"White, AIAN, other race write_in"', add
label define raced_lbl 910 `"White, Asian, PI"', add
label define raced_lbl 911 `"White, Chinese, Hawaiian"', add
label define raced_lbl 912 `"White, Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_lbl 913 `"White, Japanese, Hawaiian (2000 1%)"', add
label define raced_lbl 914 `"White, Filipino, Hawaiian"', add
label define raced_lbl 915 `"Other White, Asian race(s), PI race(s)"', add
label define raced_lbl 916 `"White, AIAN and Filipino"', add
label define raced_lbl 917 `"White, Black, and Filipino"', add
label define raced_lbl 920 `"White, Asian, other race write_in"', add
label define raced_lbl 921 `"White, Filipino, other race write_in (2000 1%)"', add
label define raced_lbl 922 `"White, Asian write_in, other race write_in (2000 1%)"', add
label define raced_lbl 923 `"Other White, Asian race(s), other race write_in (2000 1%)"', add
label define raced_lbl 925 `"White, PI, other race write_in"', add
label define raced_lbl 930 `"Black, AIAN, Asian"', add
label define raced_lbl 931 `"Black, AIAN, PI"', add
label define raced_lbl 932 `"Black, AIAN, other race write_in"', add
label define raced_lbl 933 `"Black, Asian, PI"', add
label define raced_lbl 934 `"Black, Asian, other race write_in"', add
label define raced_lbl 935 `"Black, PI, other race write_in"', add
label define raced_lbl 940 `"AIAN, Asian, PI"', add
label define raced_lbl 941 `"AIAN, Asian, other race write_in"', add
label define raced_lbl 942 `"AIAN, PI, other race write_in"', add
label define raced_lbl 943 `"Asian, PI, other race write_in"', add
label define raced_lbl 944 `"Asian (Chinese, Japanese, Korean, Vietnamese); and Native Hawaiian or PI; and Other"', add
label define raced_lbl 949 `"2 or 3 races (CPS)"', add
label define raced_lbl 950 `"White, Black, AIAN, Asian"', add
label define raced_lbl 951 `"White, Black, AIAN, PI"', add
label define raced_lbl 952 `"White, Black, AIAN, other race write_in"', add
label define raced_lbl 953 `"White, Black, Asian, PI"', add
label define raced_lbl 954 `"White, Black, Asian, other race write_in"', add
label define raced_lbl 955 `"White, Black, PI, other race write_in"', add
label define raced_lbl 960 `"White, AIAN, Asian, PI"', add
label define raced_lbl 961 `"White, AIAN, Asian, other race write_in"', add
label define raced_lbl 962 `"White, AIAN, PI, other race write_in"', add
label define raced_lbl 963 `"White, Asian, PI, other race write_in"', add
label define raced_lbl 964 `"White, Chinese, Japanese, Native Hawaiian"', add
label define raced_lbl 970 `"Black, AIAN, Asian, PI"', add
label define raced_lbl 971 `"Black, AIAN, Asian, other race write_in"', add
label define raced_lbl 972 `"Black, AIAN, PI, other race write_in"', add
label define raced_lbl 973 `"Black, Asian, PI, other race write_in"', add
label define raced_lbl 974 `"AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 975 `"AIAN, Asian, PI, Hawaiian other race write_in"', add
label define raced_lbl 976 `"Two specified Asian  (Chinese and other Asian, Chinese and Japanese, Japanese and other Asian, Korean and other Asian); Native Hawaiian/PI; and Other Race"', add
label define raced_lbl 980 `"White, Black, AIAN, Asian, PI"', add
label define raced_lbl 981 `"White, Black, AIAN, Asian, other race write_in"', add
label define raced_lbl 982 `"White, Black, AIAN, PI, other race write_in"', add
label define raced_lbl 983 `"White, Black, Asian, PI, other race write_in"', add
label define raced_lbl 984 `"White, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 985 `"Black, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 986 `"Black, AIAN, Asian, PI, Hawaiian, other race write_in"', add
label define raced_lbl 989 `"4 or 5 races (CPS)"', add
label define raced_lbl 990 `"White, Black, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 991 `"White race; Some other race; Black or African American race and/or American Indian and Alaska Native race and/or Asian groups and/or Native Hawaiian and Other Pacific Islander groups"', add
label define raced_lbl 996 `"2+ races, n.e.c. (CPS)"', add
label values raced raced_lbl

label define educ_lbl 00 `"N/A or no schooling"'
label define educ_lbl 01 `"Nursery school to grade 4"', add
label define educ_lbl 02 `"Grade 5, 6, 7, or 8"', add
label define educ_lbl 03 `"Grade 9"', add
label define educ_lbl 04 `"Grade 10"', add
label define educ_lbl 05 `"Grade 11"', add
label define educ_lbl 06 `"Grade 12"', add
label define educ_lbl 07 `"1 year of college"', add
label define educ_lbl 08 `"2 years of college"', add
label define educ_lbl 09 `"3 years of college"', add
label define educ_lbl 10 `"4 years of college"', add
label define educ_lbl 11 `"5+ years of college"', add
label values educ educ_lbl

label define educd_lbl 000 `"N/A or no schooling"'
label define educd_lbl 001 `"N/A"', add
label define educd_lbl 002 `"No schooling completed"', add
label define educd_lbl 010 `"Nursery school to grade 4"', add
label define educd_lbl 011 `"Nursery school, preschool"', add
label define educd_lbl 012 `"Kindergarten"', add
label define educd_lbl 013 `"Grade 1, 2, 3, or 4"', add
label define educd_lbl 014 `"Grade 1"', add
label define educd_lbl 015 `"Grade 2"', add
label define educd_lbl 016 `"Grade 3"', add
label define educd_lbl 017 `"Grade 4"', add
label define educd_lbl 020 `"Grade 5, 6, 7, or 8"', add
label define educd_lbl 021 `"Grade 5 or 6"', add
label define educd_lbl 022 `"Grade 5"', add
label define educd_lbl 023 `"Grade 6"', add
label define educd_lbl 024 `"Grade 7 or 8"', add
label define educd_lbl 025 `"Grade 7"', add
label define educd_lbl 026 `"Grade 8"', add
label define educd_lbl 030 `"Grade 9"', add
label define educd_lbl 040 `"Grade 10"', add
label define educd_lbl 050 `"Grade 11"', add
label define educd_lbl 060 `"Grade 12"', add
label define educd_lbl 061 `"12th grade, no diploma"', add
label define educd_lbl 062 `"High school graduate or GED"', add
label define educd_lbl 063 `"Regular high school diploma"', add
label define educd_lbl 064 `"GED or alternative credential"', add
label define educd_lbl 065 `"Some college, but less than 1 year"', add
label define educd_lbl 070 `"1 year of college"', add
label define educd_lbl 071 `"1 or more years of college credit, no degree"', add
label define educd_lbl 080 `"2 years of college"', add
label define educd_lbl 081 `"Associate's degree, type not specified"', add
label define educd_lbl 082 `"Associate's degree, occupational program"', add
label define educd_lbl 083 `"Associate's degree, academic program"', add
label define educd_lbl 090 `"3 years of college"', add
label define educd_lbl 100 `"4 years of college"', add
label define educd_lbl 101 `"Bachelor's degree"', add
label define educd_lbl 110 `"5+ years of college"', add
label define educd_lbl 111 `"6 years of college (6+ in 1960-1970)"', add
label define educd_lbl 112 `"7 years of college"', add
label define educd_lbl 113 `"8+ years of college"', add
label define educd_lbl 114 `"Master's degree"', add
label define educd_lbl 115 `"Professional degree beyond a bachelor's degree"', add
label define educd_lbl 116 `"Doctoral degree"', add
label define educd_lbl 999 `"Missing"', add
label values educd educd_lbl

label define empstat_lbl 0 `"N/A"'
label define empstat_lbl 1 `"Employed"', add
label define empstat_lbl 2 `"Unemployed"', add
label define empstat_lbl 3 `"Not in labor force"', add
label values empstat empstat_lbl

label define empstatd_lbl 00 `"N/A"'
label define empstatd_lbl 10 `"At work"', add
label define empstatd_lbl 11 `"At work, public emerg"', add
label define empstatd_lbl 12 `"Has job, not working"', add
label define empstatd_lbl 13 `"Armed forces"', add
label define empstatd_lbl 14 `"Armed forces--at work"', add
label define empstatd_lbl 15 `"Armed forces--not at work but with job"', add
label define empstatd_lbl 20 `"Unemployed"', add
label define empstatd_lbl 21 `"Unemp, exper worker"', add
label define empstatd_lbl 22 `"Unemp, new worker"', add
label define empstatd_lbl 30 `"Not in Labor Force"', add
label define empstatd_lbl 31 `"NILF, housework"', add
label define empstatd_lbl 32 `"NILF, unable to work"', add
label define empstatd_lbl 33 `"NILF, school"', add
label define empstatd_lbl 34 `"NILF, other"', add
label values empstatd empstatd_lbl

label define wkswork2_lbl 0 `"N/A"'
label define wkswork2_lbl 1 `"1-13 weeks"', add
label define wkswork2_lbl 2 `"14-26 weeks"', add
label define wkswork2_lbl 3 `"27-39 weeks"', add
label define wkswork2_lbl 4 `"40-47 weeks"', add
label define wkswork2_lbl 5 `"48-49 weeks"', add
label define wkswork2_lbl 6 `"50-52 weeks"', add
label values wkswork2 wkswork2_lbl

label define uhrswork_lbl 00 `"N/A"'
label define uhrswork_lbl 01 `"1"', add
label define uhrswork_lbl 02 `"2"', add
label define uhrswork_lbl 03 `"3"', add
label define uhrswork_lbl 04 `"4"', add
label define uhrswork_lbl 05 `"5"', add
label define uhrswork_lbl 06 `"6"', add
label define uhrswork_lbl 07 `"7"', add
label define uhrswork_lbl 08 `"8"', add
label define uhrswork_lbl 09 `"9"', add
label define uhrswork_lbl 10 `"10"', add
label define uhrswork_lbl 11 `"11"', add
label define uhrswork_lbl 12 `"12"', add
label define uhrswork_lbl 13 `"13"', add
label define uhrswork_lbl 14 `"14"', add
label define uhrswork_lbl 15 `"15"', add
label define uhrswork_lbl 16 `"16"', add
label define uhrswork_lbl 17 `"17"', add
label define uhrswork_lbl 18 `"18"', add
label define uhrswork_lbl 19 `"19"', add
label define uhrswork_lbl 20 `"20"', add
label define uhrswork_lbl 21 `"21"', add
label define uhrswork_lbl 22 `"22"', add
label define uhrswork_lbl 23 `"23"', add
label define uhrswork_lbl 24 `"24"', add
label define uhrswork_lbl 25 `"25"', add
label define uhrswork_lbl 26 `"26"', add
label define uhrswork_lbl 27 `"27"', add
label define uhrswork_lbl 28 `"28"', add
label define uhrswork_lbl 29 `"29"', add
label define uhrswork_lbl 30 `"30"', add
label define uhrswork_lbl 31 `"31"', add
label define uhrswork_lbl 32 `"32"', add
label define uhrswork_lbl 33 `"33"', add
label define uhrswork_lbl 34 `"34"', add
label define uhrswork_lbl 35 `"35"', add
label define uhrswork_lbl 36 `"36"', add
label define uhrswork_lbl 37 `"37"', add
label define uhrswork_lbl 38 `"38"', add
label define uhrswork_lbl 39 `"39"', add
label define uhrswork_lbl 40 `"40"', add
label define uhrswork_lbl 41 `"41"', add
label define uhrswork_lbl 42 `"42"', add
label define uhrswork_lbl 43 `"43"', add
label define uhrswork_lbl 44 `"44"', add
label define uhrswork_lbl 45 `"45"', add
label define uhrswork_lbl 46 `"46"', add
label define uhrswork_lbl 47 `"47"', add
label define uhrswork_lbl 48 `"48"', add
label define uhrswork_lbl 49 `"49"', add
label define uhrswork_lbl 50 `"50"', add
label define uhrswork_lbl 51 `"51"', add
label define uhrswork_lbl 52 `"52"', add
label define uhrswork_lbl 53 `"53"', add
label define uhrswork_lbl 54 `"54"', add
label define uhrswork_lbl 55 `"55"', add
label define uhrswork_lbl 56 `"56"', add
label define uhrswork_lbl 57 `"57"', add
label define uhrswork_lbl 58 `"58"', add
label define uhrswork_lbl 59 `"59"', add
label define uhrswork_lbl 60 `"60"', add
label define uhrswork_lbl 61 `"61"', add
label define uhrswork_lbl 62 `"62"', add
label define uhrswork_lbl 63 `"63"', add
label define uhrswork_lbl 64 `"64"', add
label define uhrswork_lbl 65 `"65"', add
label define uhrswork_lbl 66 `"66"', add
label define uhrswork_lbl 67 `"67"', add
label define uhrswork_lbl 68 `"68"', add
label define uhrswork_lbl 69 `"69"', add
label define uhrswork_lbl 70 `"70"', add
label define uhrswork_lbl 71 `"71"', add
label define uhrswork_lbl 72 `"72"', add
label define uhrswork_lbl 73 `"73"', add
label define uhrswork_lbl 74 `"74"', add
label define uhrswork_lbl 75 `"75"', add
label define uhrswork_lbl 76 `"76"', add
label define uhrswork_lbl 77 `"77"', add
label define uhrswork_lbl 78 `"78"', add
label define uhrswork_lbl 79 `"79"', add
label define uhrswork_lbl 80 `"80"', add
label define uhrswork_lbl 81 `"81"', add
label define uhrswork_lbl 82 `"82"', add
label define uhrswork_lbl 83 `"83"', add
label define uhrswork_lbl 84 `"84"', add
label define uhrswork_lbl 85 `"85"', add
label define uhrswork_lbl 86 `"86"', add
label define uhrswork_lbl 87 `"87"', add
label define uhrswork_lbl 88 `"88"', add
label define uhrswork_lbl 89 `"89"', add
label define uhrswork_lbl 90 `"90"', add
label define uhrswork_lbl 91 `"91"', add
label define uhrswork_lbl 92 `"92"', add
label define uhrswork_lbl 93 `"93"', add
label define uhrswork_lbl 94 `"94"', add
label define uhrswork_lbl 95 `"95"', add
label define uhrswork_lbl 96 `"96"', add
label define uhrswork_lbl 97 `"97"', add
label define uhrswork_lbl 98 `"98"', add
label define uhrswork_lbl 99 `"99 (Topcode)"', add
label values uhrswork uhrswork_lbl

label define incwage_lbl 999998 `"Missing"'
label define incwage_lbl 999999 `"N/A"', add
label define incwage_lbl 010000 `"010000"', add
label define incwage_lbl 000000 `"000000"', add
label values incwage incwage_lbl

label define incwelfr_lbl 99999 `"NIU"'
label define incwelfr_lbl 99998 `"99998"', add
label define incwelfr_lbl 00000 `"00000"', add
label values incwelfr incwelfr_lbl

label define sfrelate_sp_lbl 0 `"Group quarters or not in subfamily"'
label define sfrelate_sp_lbl 1 `"Reference person"', add
label define sfrelate_sp_lbl 2 `"Spouse (married-couple subfamily only)"', add
label define sfrelate_sp_lbl 3 `"Child"', add
label values sfrelate_sp sfrelate_sp_lbl

label define sprule_sp_lbl 00 `"No spouse or partner link"'
label define sprule_sp_lbl 11 `"Direct link, clarity level 1"', add
label define sprule_sp_lbl 12 `"Direct link, clarity level 2"', add
label define sprule_sp_lbl 13 `"Direct link, clarity level 3"', add
label define sprule_sp_lbl 14 `"Direct link, clarity level 4"', add
label define sprule_sp_lbl 21 `"Second level link, clarity level 1"', add
label define sprule_sp_lbl 22 `"Second level link, clarity level 2"', add
label define sprule_sp_lbl 23 `"Second level link, clarity level 3"', add
label define sprule_sp_lbl 24 `"Second level link, clarity level 4"', add
label define sprule_sp_lbl 31 `"Third level link, clarity level 1"', add
label define sprule_sp_lbl 32 `"Third level link, clarity level 2"', add
label define sprule_sp_lbl 33 `"Third level link, clarity level 3"', add
label define sprule_sp_lbl 34 `"Third level link, clarity level 4"', add
label define sprule_sp_lbl 41 `"Fourth level link, clarity level 1"', add
label define sprule_sp_lbl 42 `"Fourth level link, clarity level 2"', add
label define sprule_sp_lbl 43 `"Fourth level link, clarity level 3"', add
label define sprule_sp_lbl 44 `"Fourth level link, clarity level 4"', add
label define sprule_sp_lbl 51 `"Fifth level link, clarity level 1"', add
label define sprule_sp_lbl 52 `"Fifth level link, clarity level 2"', add
label define sprule_sp_lbl 53 `"Fifth level link, clarity level 3"', add
label define sprule_sp_lbl 54 `"Fifth level link, clarity level 4"', add
label values sprule_sp sprule_sp_lbl

label define nchild_sp_lbl 0 `"0 children present"'
label define nchild_sp_lbl 1 `"1 child present"', add
label define nchild_sp_lbl 2 `"2"', add
label define nchild_sp_lbl 3 `"3"', add
label define nchild_sp_lbl 4 `"4"', add
label define nchild_sp_lbl 5 `"5"', add
label define nchild_sp_lbl 6 `"6"', add
label define nchild_sp_lbl 7 `"7"', add
label define nchild_sp_lbl 8 `"8"', add
label define nchild_sp_lbl 9 `"9+"', add
label values nchild_sp nchild_sp_lbl

label define nchlt5_sp_lbl 0 `"No children under age 5"'
label define nchlt5_sp_lbl 1 `"1 child under age 5"', add
label define nchlt5_sp_lbl 2 `"2"', add
label define nchlt5_sp_lbl 3 `"3"', add
label define nchlt5_sp_lbl 4 `"4"', add
label define nchlt5_sp_lbl 5 `"5"', add
label define nchlt5_sp_lbl 6 `"6"', add
label define nchlt5_sp_lbl 7 `"7"', add
label define nchlt5_sp_lbl 8 `"8"', add
label define nchlt5_sp_lbl 9 `"9+"', add
label values nchlt5_sp nchlt5_sp_lbl

label define relate_sp_lbl 01 `"Head/Householder"'
label define relate_sp_lbl 02 `"Spouse"', add
label define relate_sp_lbl 03 `"Child"', add
label define relate_sp_lbl 04 `"Child-in-law"', add
label define relate_sp_lbl 05 `"Parent"', add
label define relate_sp_lbl 06 `"Parent-in-Law"', add
label define relate_sp_lbl 07 `"Sibling"', add
label define relate_sp_lbl 08 `"Sibling-in-Law"', add
label define relate_sp_lbl 09 `"Grandchild"', add
label define relate_sp_lbl 10 `"Other relatives"', add
label define relate_sp_lbl 11 `"Partner, friend, visitor"', add
label define relate_sp_lbl 12 `"Other non-relatives"', add
label define relate_sp_lbl 13 `"Institutional inmates"', add
label values relate_sp relate_sp_lbl

label define related_sp_lbl 0101 `"Head/Householder"'
label define related_sp_lbl 0201 `"Spouse"', add
label define related_sp_lbl 0202 `"2nd/3rd Wife (Polygamous)"', add
label define related_sp_lbl 0301 `"Child"', add
label define related_sp_lbl 0302 `"Adopted Child"', add
label define related_sp_lbl 0303 `"Stepchild"', add
label define related_sp_lbl 0304 `"Adopted, n.s."', add
label define related_sp_lbl 0401 `"Child-in-law"', add
label define related_sp_lbl 0402 `"Step Child-in-law"', add
label define related_sp_lbl 0501 `"Parent"', add
label define related_sp_lbl 0502 `"Stepparent"', add
label define related_sp_lbl 0601 `"Parent-in-Law"', add
label define related_sp_lbl 0602 `"Stepparent-in-law"', add
label define related_sp_lbl 0701 `"Sibling"', add
label define related_sp_lbl 0702 `"Step/Half/Adopted Sibling"', add
label define related_sp_lbl 0801 `"Sibling-in-Law"', add
label define related_sp_lbl 0802 `"Step/Half Sibling-in-law"', add
label define related_sp_lbl 0901 `"Grandchild"', add
label define related_sp_lbl 0902 `"Adopted Grandchild"', add
label define related_sp_lbl 0903 `"Step Grandchild"', add
label define related_sp_lbl 0904 `"Grandchild-in-law"', add
label define related_sp_lbl 1000 `"Other relatives:"', add
label define related_sp_lbl 1001 `"Other Relatives"', add
label define related_sp_lbl 1011 `"Grandparent"', add
label define related_sp_lbl 1012 `"Step Grandparent"', add
label define related_sp_lbl 1013 `"Grandparent-in-law"', add
label define related_sp_lbl 1021 `"Aunt or Uncle"', add
label define related_sp_lbl 1022 `"Aunt,Uncle-in-law"', add
label define related_sp_lbl 1031 `"Nephew, Niece"', add
label define related_sp_lbl 1032 `"Neph/Niece-in-law"', add
label define related_sp_lbl 1033 `"Step/Adopted Nephew/Niece"', add
label define related_sp_lbl 1034 `"Grand Niece/Nephew"', add
label define related_sp_lbl 1041 `"Cousin"', add
label define related_sp_lbl 1042 `"Cousin-in-law"', add
label define related_sp_lbl 1051 `"Great Grandchild"', add
label define related_sp_lbl 1061 `"Other relatives, nec"', add
label define related_sp_lbl 1100 `"Partner, Friend, Visitor"', add
label define related_sp_lbl 1110 `"Partner/friend"', add
label define related_sp_lbl 1111 `"Friend"', add
label define related_sp_lbl 1112 `"Partner"', add
label define related_sp_lbl 1113 `"Partner/roommate"', add
label define related_sp_lbl 1114 `"Unmarried Partner"', add
label define related_sp_lbl 1115 `"Housemate/Roomate"', add
label define related_sp_lbl 1120 `"Relative of partner"', add
label define related_sp_lbl 1130 `"Concubine/Mistress"', add
label define related_sp_lbl 1131 `"Visitor"', add
label define related_sp_lbl 1132 `"Companion and family of companion"', add
label define related_sp_lbl 1139 `"Allocated partner/friend/visitor"', add
label define related_sp_lbl 1200 `"Other non-relatives"', add
label define related_sp_lbl 1201 `"Roomers/boarders/lodgers"', add
label define related_sp_lbl 1202 `"Boarders"', add
label define related_sp_lbl 1203 `"Lodgers"', add
label define related_sp_lbl 1204 `"Roomer"', add
label define related_sp_lbl 1205 `"Tenant"', add
label define related_sp_lbl 1206 `"Foster child"', add
label define related_sp_lbl 1210 `"Employees:"', add
label define related_sp_lbl 1211 `"Servant"', add
label define related_sp_lbl 1212 `"Housekeeper"', add
label define related_sp_lbl 1213 `"Maid"', add
label define related_sp_lbl 1214 `"Cook"', add
label define related_sp_lbl 1215 `"Nurse"', add
label define related_sp_lbl 1216 `"Other probable domestic employee"', add
label define related_sp_lbl 1217 `"Other employee"', add
label define related_sp_lbl 1219 `"Relative of employee"', add
label define related_sp_lbl 1221 `"Military"', add
label define related_sp_lbl 1222 `"Students"', add
label define related_sp_lbl 1223 `"Members of religious orders"', add
label define related_sp_lbl 1230 `"Other non-relatives"', add
label define related_sp_lbl 1239 `"Allocated other non-relative"', add
label define related_sp_lbl 1240 `"Roomers/boarders/lodgers and foster children"', add
label define related_sp_lbl 1241 `"Roomers/boarders/lodgers"', add
label define related_sp_lbl 1242 `"Foster children"', add
label define related_sp_lbl 1250 `"Employees"', add
label define related_sp_lbl 1251 `"Domestic employees"', add
label define related_sp_lbl 1252 `"Non-domestic employees"', add
label define related_sp_lbl 1253 `"Relative of employee"', add
label define related_sp_lbl 1260 `"Other non-relatives (1990 includes employees)"', add
label define related_sp_lbl 1270 `"Non-inmate 1990"', add
label define related_sp_lbl 1281 `"Head of group quarters"', add
label define related_sp_lbl 1282 `"Employees of group quarters"', add
label define related_sp_lbl 1283 `"Relative of head, staff, or employee group quarters"', add
label define related_sp_lbl 1284 `"Other non-inmate 1940-1959"', add
label define related_sp_lbl 1291 `"Military"', add
label define related_sp_lbl 1292 `"College dormitories"', add
label define related_sp_lbl 1293 `"Residents of rooming houses"', add
label define related_sp_lbl 1294 `"Other non-inmate 1980 (includes employees and non-inmates in"', add
label define related_sp_lbl 1295 `"Other non-inmates 1960-1970 (includes employees)"', add
label define related_sp_lbl 1296 `"Non-inmates in institutions"', add
label define related_sp_lbl 1301 `"Institutional inmates"', add
label define related_sp_lbl 9996 `"Unclassifiable"', add
label define related_sp_lbl 9997 `"Unknown"', add
label define related_sp_lbl 9998 `"Illegible"', add
label define related_sp_lbl 9999 `"Missing"', add
label values related_sp related_sp_lbl

label define sex_sp_lbl 1 `"Male"'
label define sex_sp_lbl 2 `"Female"', add
label values sex_sp sex_sp_lbl

label define age_sp_lbl 000 `"Less than 1 year old"'
label define age_sp_lbl 001 `"1"', add
label define age_sp_lbl 002 `"2"', add
label define age_sp_lbl 003 `"3"', add
label define age_sp_lbl 004 `"4"', add
label define age_sp_lbl 005 `"5"', add
label define age_sp_lbl 006 `"6"', add
label define age_sp_lbl 007 `"7"', add
label define age_sp_lbl 008 `"8"', add
label define age_sp_lbl 009 `"9"', add
label define age_sp_lbl 010 `"10"', add
label define age_sp_lbl 011 `"11"', add
label define age_sp_lbl 012 `"12"', add
label define age_sp_lbl 013 `"13"', add
label define age_sp_lbl 014 `"14"', add
label define age_sp_lbl 015 `"15"', add
label define age_sp_lbl 016 `"16"', add
label define age_sp_lbl 017 `"17"', add
label define age_sp_lbl 018 `"18"', add
label define age_sp_lbl 019 `"19"', add
label define age_sp_lbl 020 `"20"', add
label define age_sp_lbl 021 `"21"', add
label define age_sp_lbl 022 `"22"', add
label define age_sp_lbl 023 `"23"', add
label define age_sp_lbl 024 `"24"', add
label define age_sp_lbl 025 `"25"', add
label define age_sp_lbl 026 `"26"', add
label define age_sp_lbl 027 `"27"', add
label define age_sp_lbl 028 `"28"', add
label define age_sp_lbl 029 `"29"', add
label define age_sp_lbl 030 `"30"', add
label define age_sp_lbl 031 `"31"', add
label define age_sp_lbl 032 `"32"', add
label define age_sp_lbl 033 `"33"', add
label define age_sp_lbl 034 `"34"', add
label define age_sp_lbl 035 `"35"', add
label define age_sp_lbl 036 `"36"', add
label define age_sp_lbl 037 `"37"', add
label define age_sp_lbl 038 `"38"', add
label define age_sp_lbl 039 `"39"', add
label define age_sp_lbl 040 `"40"', add
label define age_sp_lbl 041 `"41"', add
label define age_sp_lbl 042 `"42"', add
label define age_sp_lbl 043 `"43"', add
label define age_sp_lbl 044 `"44"', add
label define age_sp_lbl 045 `"45"', add
label define age_sp_lbl 046 `"46"', add
label define age_sp_lbl 047 `"47"', add
label define age_sp_lbl 048 `"48"', add
label define age_sp_lbl 049 `"49"', add
label define age_sp_lbl 050 `"50"', add
label define age_sp_lbl 051 `"51"', add
label define age_sp_lbl 052 `"52"', add
label define age_sp_lbl 053 `"53"', add
label define age_sp_lbl 054 `"54"', add
label define age_sp_lbl 055 `"55"', add
label define age_sp_lbl 056 `"56"', add
label define age_sp_lbl 057 `"57"', add
label define age_sp_lbl 058 `"58"', add
label define age_sp_lbl 059 `"59"', add
label define age_sp_lbl 060 `"60"', add
label define age_sp_lbl 061 `"61"', add
label define age_sp_lbl 062 `"62"', add
label define age_sp_lbl 063 `"63"', add
label define age_sp_lbl 064 `"64"', add
label define age_sp_lbl 065 `"65"', add
label define age_sp_lbl 066 `"66"', add
label define age_sp_lbl 067 `"67"', add
label define age_sp_lbl 068 `"68"', add
label define age_sp_lbl 069 `"69"', add
label define age_sp_lbl 070 `"70"', add
label define age_sp_lbl 071 `"71"', add
label define age_sp_lbl 072 `"72"', add
label define age_sp_lbl 073 `"73"', add
label define age_sp_lbl 074 `"74"', add
label define age_sp_lbl 075 `"75"', add
label define age_sp_lbl 076 `"76"', add
label define age_sp_lbl 077 `"77"', add
label define age_sp_lbl 078 `"78"', add
label define age_sp_lbl 079 `"79"', add
label define age_sp_lbl 080 `"80"', add
label define age_sp_lbl 081 `"81"', add
label define age_sp_lbl 082 `"82"', add
label define age_sp_lbl 083 `"83"', add
label define age_sp_lbl 084 `"84"', add
label define age_sp_lbl 085 `"85"', add
label define age_sp_lbl 086 `"86"', add
label define age_sp_lbl 087 `"87"', add
label define age_sp_lbl 088 `"88"', add
label define age_sp_lbl 089 `"89"', add
label define age_sp_lbl 090 `"90 (90+ in 1980 and 1990)"', add
label define age_sp_lbl 091 `"91"', add
label define age_sp_lbl 092 `"92"', add
label define age_sp_lbl 093 `"93"', add
label define age_sp_lbl 094 `"94"', add
label define age_sp_lbl 095 `"95"', add
label define age_sp_lbl 096 `"96"', add
label define age_sp_lbl 097 `"97"', add
label define age_sp_lbl 098 `"98"', add
label define age_sp_lbl 099 `"99"', add
label define age_sp_lbl 100 `"100 (100+ in 1960-1970)"', add
label define age_sp_lbl 101 `"101"', add
label define age_sp_lbl 102 `"102"', add
label define age_sp_lbl 103 `"103"', add
label define age_sp_lbl 104 `"104"', add
label define age_sp_lbl 105 `"105"', add
label define age_sp_lbl 106 `"106"', add
label define age_sp_lbl 107 `"107"', add
label define age_sp_lbl 108 `"108"', add
label define age_sp_lbl 109 `"109"', add
label define age_sp_lbl 110 `"110"', add
label define age_sp_lbl 111 `"111"', add
label define age_sp_lbl 112 `"112 (112+ in the 1980 internal data)"', add
label define age_sp_lbl 113 `"113"', add
label define age_sp_lbl 114 `"114"', add
label define age_sp_lbl 115 `"115 (115+ in the 1990 internal data)"', add
label define age_sp_lbl 116 `"116"', add
label define age_sp_lbl 117 `"117"', add
label define age_sp_lbl 118 `"118"', add
label define age_sp_lbl 119 `"119"', add
label define age_sp_lbl 120 `"120"', add
label define age_sp_lbl 121 `"121"', add
label define age_sp_lbl 122 `"122"', add
label define age_sp_lbl 123 `"123"', add
label define age_sp_lbl 124 `"124"', add
label define age_sp_lbl 125 `"125"', add
label define age_sp_lbl 126 `"126"', add
label define age_sp_lbl 129 `"129"', add
label define age_sp_lbl 130 `"130"', add
label define age_sp_lbl 135 `"135"', add
label values age_sp age_sp_lbl

label define marst_sp_lbl 1 `"Married, spouse present"'
label define marst_sp_lbl 2 `"Married, spouse absent"', add
label define marst_sp_lbl 3 `"Separated"', add
label define marst_sp_lbl 4 `"Divorced"', add
label define marst_sp_lbl 5 `"Widowed"', add
label define marst_sp_lbl 6 `"Never married/single"', add
label values marst_sp marst_sp_lbl

label define race_sp_lbl 1 `"White"'
label define race_sp_lbl 2 `"Black/African American"', add
label define race_sp_lbl 3 `"American Indian or Alaska Native"', add
label define race_sp_lbl 4 `"Chinese"', add
label define race_sp_lbl 5 `"Japanese"', add
label define race_sp_lbl 6 `"Other Asian or Pacific Islander"', add
label define race_sp_lbl 7 `"Other race, nec"', add
label define race_sp_lbl 8 `"Two major races"', add
label define race_sp_lbl 9 `"Three or more major races"', add
label values race_sp race_sp_lbl

label define raced_sp_lbl 100 `"White"'
label define raced_sp_lbl 110 `"Spanish write_in"', add
label define raced_sp_lbl 120 `"Blank (white) (1850)"', add
label define raced_sp_lbl 130 `"Portuguese"', add
label define raced_sp_lbl 140 `"Mexican (1930)"', add
label define raced_sp_lbl 150 `"Puerto Rican (1910 Hawaii)"', add
label define raced_sp_lbl 200 `"Black/African American"', add
label define raced_sp_lbl 210 `"Mulatto"', add
label define raced_sp_lbl 300 `"American Indian/Alaska Native"', add
label define raced_sp_lbl 302 `"Apache"', add
label define raced_sp_lbl 303 `"Blackfoot"', add
label define raced_sp_lbl 304 `"Cherokee"', add
label define raced_sp_lbl 305 `"Cheyenne"', add
label define raced_sp_lbl 306 `"Chickasaw"', add
label define raced_sp_lbl 307 `"Chippewa"', add
label define raced_sp_lbl 308 `"Choctaw"', add
label define raced_sp_lbl 309 `"Comanche"', add
label define raced_sp_lbl 310 `"Creek"', add
label define raced_sp_lbl 311 `"Crow"', add
label define raced_sp_lbl 312 `"Iroquois"', add
label define raced_sp_lbl 313 `"Kiowa"', add
label define raced_sp_lbl 314 `"Lumbee"', add
label define raced_sp_lbl 315 `"Navajo"', add
label define raced_sp_lbl 316 `"Osage"', add
label define raced_sp_lbl 317 `"Paiute"', add
label define raced_sp_lbl 318 `"Pima"', add
label define raced_sp_lbl 319 `"Potawatomi"', add
label define raced_sp_lbl 320 `"Pueblo"', add
label define raced_sp_lbl 321 `"Seminole"', add
label define raced_sp_lbl 322 `"Shoshone"', add
label define raced_sp_lbl 323 `"Sioux"', add
label define raced_sp_lbl 324 `"Tlingit (Tlingit_Haida, 2000/ACS)"', add
label define raced_sp_lbl 325 `"Tohono O Odham"', add
label define raced_sp_lbl 326 `"All other tribes (1990)"', add
label define raced_sp_lbl 328 `"Hopi"', add
label define raced_sp_lbl 329 `"Central American Indian"', add
label define raced_sp_lbl 330 `"Spanish American Indian"', add
label define raced_sp_lbl 350 `"Delaware"', add
label define raced_sp_lbl 351 `"Latin American Indian"', add
label define raced_sp_lbl 352 `"Puget Sound Salish"', add
label define raced_sp_lbl 353 `"Yakama"', add
label define raced_sp_lbl 354 `"Yaqui"', add
label define raced_sp_lbl 355 `"Colville"', add
label define raced_sp_lbl 356 `"Houma"', add
label define raced_sp_lbl 357 `"Menominee"', add
label define raced_sp_lbl 358 `"Yuman"', add
label define raced_sp_lbl 359 `"South American Indian"', add
label define raced_sp_lbl 360 `"Mexican American Indian"', add
label define raced_sp_lbl 361 `"Other Amer. Indian tribe (2000,ACS)"', add
label define raced_sp_lbl 362 `"2+ Amer. Indian tribes (2000,ACS)"', add
label define raced_sp_lbl 370 `"Alaskan Athabaskan"', add
label define raced_sp_lbl 371 `"Aleut"', add
label define raced_sp_lbl 372 `"Eskimo"', add
label define raced_sp_lbl 373 `"Alaskan mixed"', add
label define raced_sp_lbl 374 `"Inupiat"', add
label define raced_sp_lbl 375 `"Yup'ik"', add
label define raced_sp_lbl 379 `"Other Alaska Native tribe(s) (2000,ACS)"', add
label define raced_sp_lbl 398 `"Both Am. Ind. and Alaska Native (2000,ACS)"', add
label define raced_sp_lbl 399 `"Tribe not specified"', add
label define raced_sp_lbl 400 `"Chinese"', add
label define raced_sp_lbl 410 `"Taiwanese"', add
label define raced_sp_lbl 420 `"Chinese and Taiwanese"', add
label define raced_sp_lbl 500 `"Japanese"', add
label define raced_sp_lbl 600 `"Filipino"', add
label define raced_sp_lbl 610 `"Asian Indian (Hindu 1920_1940)"', add
label define raced_sp_lbl 620 `"Korean"', add
label define raced_sp_lbl 630 `"Hawaiian"', add
label define raced_sp_lbl 631 `"Hawaiian and Asian (1900,1920)"', add
label define raced_sp_lbl 632 `"Hawaiian and European (1900,1920)"', add
label define raced_sp_lbl 634 `"Hawaiian mixed"', add
label define raced_sp_lbl 640 `"Vietnamese"', add
label define raced_sp_lbl 641 `"Bhutanese"', add
label define raced_sp_lbl 642 `"Mongolian"', add
label define raced_sp_lbl 643 `"Nepalese"', add
label define raced_sp_lbl 650 `"Other Asian or Pacific Islander (1920,1980)"', add
label define raced_sp_lbl 651 `"Asian only (CPS)"', add
label define raced_sp_lbl 652 `"Pacific Islander only (CPS)"', add
label define raced_sp_lbl 653 `"Asian or Pacific Islander, n.s. (1990 Internal Census files)"', add
label define raced_sp_lbl 660 `"Cambodian"', add
label define raced_sp_lbl 661 `"Hmong"', add
label define raced_sp_lbl 662 `"Laotian"', add
label define raced_sp_lbl 663 `"Thai"', add
label define raced_sp_lbl 664 `"Bangladeshi"', add
label define raced_sp_lbl 665 `"Burmese"', add
label define raced_sp_lbl 666 `"Indonesian"', add
label define raced_sp_lbl 667 `"Malaysian"', add
label define raced_sp_lbl 668 `"Okinawan"', add
label define raced_sp_lbl 669 `"Pakistani"', add
label define raced_sp_lbl 670 `"Sri Lankan"', add
label define raced_sp_lbl 671 `"Other Asian, n.e.c."', add
label define raced_sp_lbl 672 `"Asian, not specified"', add
label define raced_sp_lbl 673 `"Chinese and Japanese"', add
label define raced_sp_lbl 674 `"Chinese and Filipino"', add
label define raced_sp_lbl 675 `"Chinese and Vietnamese"', add
label define raced_sp_lbl 676 `"Chinese and Asian write_in"', add
label define raced_sp_lbl 677 `"Japanese and Filipino"', add
label define raced_sp_lbl 678 `"Asian Indian and Asian write_in"', add
label define raced_sp_lbl 679 `"Other Asian race combinations"', add
label define raced_sp_lbl 680 `"Samoan"', add
label define raced_sp_lbl 681 `"Tahitian"', add
label define raced_sp_lbl 682 `"Tongan"', add
label define raced_sp_lbl 683 `"Other Polynesian (1990)"', add
label define raced_sp_lbl 684 `"1+ other Polynesian races (2000,ACS)"', add
label define raced_sp_lbl 685 `"Chamorro"', add
label define raced_sp_lbl 686 `"Northern Mariana Islander"', add
label define raced_sp_lbl 687 `"Palauan"', add
label define raced_sp_lbl 688 `"Other Micronesian (1990)"', add
label define raced_sp_lbl 689 `"1+ other Micronesian races (2000,ACS)"', add
label define raced_sp_lbl 690 `"Fijian"', add
label define raced_sp_lbl 691 `"Other Melanesian (1990)"', add
label define raced_sp_lbl 692 `"1+ other Melanesian races (2000,ACS)"', add
label define raced_sp_lbl 698 `"2+ PI races from 2+ PI regions"', add
label define raced_sp_lbl 699 `"Pacific Islander, n.s."', add
label define raced_sp_lbl 700 `"Other race, n.e.c."', add
label define raced_sp_lbl 801 `"White and Black"', add
label define raced_sp_lbl 802 `"White and AIAN"', add
label define raced_sp_lbl 810 `"White and Asian"', add
label define raced_sp_lbl 811 `"White and Chinese"', add
label define raced_sp_lbl 812 `"White and Japanese"', add
label define raced_sp_lbl 813 `"White and Filipino"', add
label define raced_sp_lbl 814 `"White and Asian Indian"', add
label define raced_sp_lbl 815 `"White and Korean"', add
label define raced_sp_lbl 816 `"White and Vietnamese"', add
label define raced_sp_lbl 817 `"White and Asian write_in"', add
label define raced_sp_lbl 818 `"White and other Asian race(s)"', add
label define raced_sp_lbl 819 `"White and two or more Asian groups"', add
label define raced_sp_lbl 820 `"White and PI"', add
label define raced_sp_lbl 821 `"White and Native Hawaiian"', add
label define raced_sp_lbl 822 `"White and Samoan"', add
label define raced_sp_lbl 823 `"White and Chamorro"', add
label define raced_sp_lbl 824 `"White and PI write_in"', add
label define raced_sp_lbl 825 `"White and other PI race(s)"', add
label define raced_sp_lbl 826 `"White and other race write_in"', add
label define raced_sp_lbl 827 `"White and other race, n.e.c."', add
label define raced_sp_lbl 830 `"Black and AIAN"', add
label define raced_sp_lbl 831 `"Black and Asian"', add
label define raced_sp_lbl 832 `"Black and Chinese"', add
label define raced_sp_lbl 833 `"Black and Japanese"', add
label define raced_sp_lbl 834 `"Black and Filipino"', add
label define raced_sp_lbl 835 `"Black and Asian Indian"', add
label define raced_sp_lbl 836 `"Black and Korean"', add
label define raced_sp_lbl 837 `"Black and Asian write_in"', add
label define raced_sp_lbl 838 `"Black and other Asian race(s)"', add
label define raced_sp_lbl 840 `"Black and PI"', add
label define raced_sp_lbl 841 `"Black and PI write_in"', add
label define raced_sp_lbl 842 `"Black and other PI race(s)"', add
label define raced_sp_lbl 845 `"Black and other race write_in"', add
label define raced_sp_lbl 850 `"AIAN and Asian"', add
label define raced_sp_lbl 851 `"AIAN and Filipino (2000 1%)"', add
label define raced_sp_lbl 852 `"AIAN and Asian Indian"', add
label define raced_sp_lbl 853 `"AIAN and Asian write_in (2000 1%)"', add
label define raced_sp_lbl 854 `"AIAN and other Asian race(s)"', add
label define raced_sp_lbl 855 `"AIAN and PI"', add
label define raced_sp_lbl 856 `"AIAN and other race write_in"', add
label define raced_sp_lbl 860 `"Asian and PI"', add
label define raced_sp_lbl 861 `"Chinese and Hawaiian"', add
label define raced_sp_lbl 862 `"Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_sp_lbl 863 `"Japanese and Hawaiian (2000 1%)"', add
label define raced_sp_lbl 864 `"Filipino and Hawaiian"', add
label define raced_sp_lbl 865 `"Filipino and PI write_in"', add
label define raced_sp_lbl 866 `"Asian Indian and PI write_in (2000 1%)"', add
label define raced_sp_lbl 867 `"Asian write_in and PI write_in"', add
label define raced_sp_lbl 868 `"Other Asian race(s) and PI race(s)"', add
label define raced_sp_lbl 869 `"Japanese and Korean (ACS)"', add
label define raced_sp_lbl 880 `"Asian and other race write_in"', add
label define raced_sp_lbl 881 `"Chinese and other race write_in"', add
label define raced_sp_lbl 882 `"Japanese and other race write_in"', add
label define raced_sp_lbl 883 `"Filipino and other race write_in"', add
label define raced_sp_lbl 884 `"Asian Indian and other race write_in"', add
label define raced_sp_lbl 885 `"Asian write_in and other race write_in"', add
label define raced_sp_lbl 886 `"Other Asian race(s) and other race write_in"', add
label define raced_sp_lbl 887 `"Chinese and Korean"', add
label define raced_sp_lbl 890 `"PI and other race write_in:"', add
label define raced_sp_lbl 891 `"PI write_in and other race write_in"', add
label define raced_sp_lbl 892 `"Other PI race(s) and other race write_in"', add
label define raced_sp_lbl 893 `"Native Hawaiian or PI other race(s)"', add
label define raced_sp_lbl 899 `"API and other race write_in"', add
label define raced_sp_lbl 901 `"White, Black, AIAN"', add
label define raced_sp_lbl 902 `"White, Black, Asian"', add
label define raced_sp_lbl 903 `"White, Black, PI"', add
label define raced_sp_lbl 904 `"White, Black, other race write_in"', add
label define raced_sp_lbl 905 `"White, AIAN, Asian"', add
label define raced_sp_lbl 906 `"White, AIAN, PI"', add
label define raced_sp_lbl 907 `"White, AIAN, other race write_in"', add
label define raced_sp_lbl 910 `"White, Asian, PI"', add
label define raced_sp_lbl 911 `"White, Chinese, Hawaiian"', add
label define raced_sp_lbl 912 `"White, Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_sp_lbl 913 `"White, Japanese, Hawaiian (2000 1%)"', add
label define raced_sp_lbl 914 `"White, Filipino, Hawaiian"', add
label define raced_sp_lbl 915 `"Other White, Asian race(s), PI race(s)"', add
label define raced_sp_lbl 916 `"White, AIAN and Filipino"', add
label define raced_sp_lbl 917 `"White, Black, and Filipino"', add
label define raced_sp_lbl 920 `"White, Asian, other race write_in"', add
label define raced_sp_lbl 921 `"White, Filipino, other race write_in (2000 1%)"', add
label define raced_sp_lbl 922 `"White, Asian write_in, other race write_in (2000 1%)"', add
label define raced_sp_lbl 923 `"Other White, Asian race(s), other race write_in (2000 1%)"', add
label define raced_sp_lbl 925 `"White, PI, other race write_in"', add
label define raced_sp_lbl 930 `"Black, AIAN, Asian"', add
label define raced_sp_lbl 931 `"Black, AIAN, PI"', add
label define raced_sp_lbl 932 `"Black, AIAN, other race write_in"', add
label define raced_sp_lbl 933 `"Black, Asian, PI"', add
label define raced_sp_lbl 934 `"Black, Asian, other race write_in"', add
label define raced_sp_lbl 935 `"Black, PI, other race write_in"', add
label define raced_sp_lbl 940 `"AIAN, Asian, PI"', add
label define raced_sp_lbl 941 `"AIAN, Asian, other race write_in"', add
label define raced_sp_lbl 942 `"AIAN, PI, other race write_in"', add
label define raced_sp_lbl 943 `"Asian, PI, other race write_in"', add
label define raced_sp_lbl 944 `"Asian (Chinese, Japanese, Korean, Vietnamese); and Native Hawaiian or PI; and Other"', add
label define raced_sp_lbl 949 `"2 or 3 races (CPS)"', add
label define raced_sp_lbl 950 `"White, Black, AIAN, Asian"', add
label define raced_sp_lbl 951 `"White, Black, AIAN, PI"', add
label define raced_sp_lbl 952 `"White, Black, AIAN, other race write_in"', add
label define raced_sp_lbl 953 `"White, Black, Asian, PI"', add
label define raced_sp_lbl 954 `"White, Black, Asian, other race write_in"', add
label define raced_sp_lbl 955 `"White, Black, PI, other race write_in"', add
label define raced_sp_lbl 960 `"White, AIAN, Asian, PI"', add
label define raced_sp_lbl 961 `"White, AIAN, Asian, other race write_in"', add
label define raced_sp_lbl 962 `"White, AIAN, PI, other race write_in"', add
label define raced_sp_lbl 963 `"White, Asian, PI, other race write_in"', add
label define raced_sp_lbl 964 `"White, Chinese, Japanese, Native Hawaiian"', add
label define raced_sp_lbl 970 `"Black, AIAN, Asian, PI"', add
label define raced_sp_lbl 971 `"Black, AIAN, Asian, other race write_in"', add
label define raced_sp_lbl 972 `"Black, AIAN, PI, other race write_in"', add
label define raced_sp_lbl 973 `"Black, Asian, PI, other race write_in"', add
label define raced_sp_lbl 974 `"AIAN, Asian, PI, other race write_in"', add
label define raced_sp_lbl 975 `"AIAN, Asian, PI, Hawaiian other race write_in"', add
label define raced_sp_lbl 976 `"Two specified Asian  (Chinese and other Asian, Chinese and Japanese, Japanese and other Asian, Korean and other Asian); Native Hawaiian/PI; and Other Race"', add
label define raced_sp_lbl 980 `"White, Black, AIAN, Asian, PI"', add
label define raced_sp_lbl 981 `"White, Black, AIAN, Asian, other race write_in"', add
label define raced_sp_lbl 982 `"White, Black, AIAN, PI, other race write_in"', add
label define raced_sp_lbl 983 `"White, Black, Asian, PI, other race write_in"', add
label define raced_sp_lbl 984 `"White, AIAN, Asian, PI, other race write_in"', add
label define raced_sp_lbl 985 `"Black, AIAN, Asian, PI, other race write_in"', add
label define raced_sp_lbl 986 `"Black, AIAN, Asian, PI, Hawaiian, other race write_in"', add
label define raced_sp_lbl 989 `"4 or 5 races (CPS)"', add
label define raced_sp_lbl 990 `"White, Black, AIAN, Asian, PI, other race write_in"', add
label define raced_sp_lbl 991 `"White race; Some other race; Black or African American race and/or American Indian and Alaska Native race and/or Asian groups and/or Native Hawaiian and Other Pacific Islander groups"', add
label define raced_sp_lbl 996 `"2+ races, n.e.c. (CPS)"', add
label values raced_sp raced_sp_lbl

label define educ_sp_lbl 00 `"N/A or no schooling"'
label define educ_sp_lbl 01 `"Nursery school to grade 4"', add
label define educ_sp_lbl 02 `"Grade 5, 6, 7, or 8"', add
label define educ_sp_lbl 03 `"Grade 9"', add
label define educ_sp_lbl 04 `"Grade 10"', add
label define educ_sp_lbl 05 `"Grade 11"', add
label define educ_sp_lbl 06 `"Grade 12"', add
label define educ_sp_lbl 07 `"1 year of college"', add
label define educ_sp_lbl 08 `"2 years of college"', add
label define educ_sp_lbl 09 `"3 years of college"', add
label define educ_sp_lbl 10 `"4 years of college"', add
label define educ_sp_lbl 11 `"5+ years of college"', add
label values educ_sp educ_sp_lbl

label define educd_sp_lbl 000 `"N/A or no schooling"'
label define educd_sp_lbl 001 `"N/A"', add
label define educd_sp_lbl 002 `"No schooling completed"', add
label define educd_sp_lbl 010 `"Nursery school to grade 4"', add
label define educd_sp_lbl 011 `"Nursery school, preschool"', add
label define educd_sp_lbl 012 `"Kindergarten"', add
label define educd_sp_lbl 013 `"Grade 1, 2, 3, or 4"', add
label define educd_sp_lbl 014 `"Grade 1"', add
label define educd_sp_lbl 015 `"Grade 2"', add
label define educd_sp_lbl 016 `"Grade 3"', add
label define educd_sp_lbl 017 `"Grade 4"', add
label define educd_sp_lbl 020 `"Grade 5, 6, 7, or 8"', add
label define educd_sp_lbl 021 `"Grade 5 or 6"', add
label define educd_sp_lbl 022 `"Grade 5"', add
label define educd_sp_lbl 023 `"Grade 6"', add
label define educd_sp_lbl 024 `"Grade 7 or 8"', add
label define educd_sp_lbl 025 `"Grade 7"', add
label define educd_sp_lbl 026 `"Grade 8"', add
label define educd_sp_lbl 030 `"Grade 9"', add
label define educd_sp_lbl 040 `"Grade 10"', add
label define educd_sp_lbl 050 `"Grade 11"', add
label define educd_sp_lbl 060 `"Grade 12"', add
label define educd_sp_lbl 061 `"12th grade, no diploma"', add
label define educd_sp_lbl 062 `"High school graduate or GED"', add
label define educd_sp_lbl 063 `"Regular high school diploma"', add
label define educd_sp_lbl 064 `"GED or alternative credential"', add
label define educd_sp_lbl 065 `"Some college, but less than 1 year"', add
label define educd_sp_lbl 070 `"1 year of college"', add
label define educd_sp_lbl 071 `"1 or more years of college credit, no degree"', add
label define educd_sp_lbl 080 `"2 years of college"', add
label define educd_sp_lbl 081 `"Associate's degree, type not specified"', add
label define educd_sp_lbl 082 `"Associate's degree, occupational program"', add
label define educd_sp_lbl 083 `"Associate's degree, academic program"', add
label define educd_sp_lbl 090 `"3 years of college"', add
label define educd_sp_lbl 100 `"4 years of college"', add
label define educd_sp_lbl 101 `"Bachelor's degree"', add
label define educd_sp_lbl 110 `"5+ years of college"', add
label define educd_sp_lbl 111 `"6 years of college (6+ in 1960-1970)"', add
label define educd_sp_lbl 112 `"7 years of college"', add
label define educd_sp_lbl 113 `"8+ years of college"', add
label define educd_sp_lbl 114 `"Master's degree"', add
label define educd_sp_lbl 115 `"Professional degree beyond a bachelor's degree"', add
label define educd_sp_lbl 116 `"Doctoral degree"', add
label define educd_sp_lbl 999 `"Missing"', add
label values educd_sp educd_sp_lbl

label define empstat_sp_lbl 0 `"N/A"'
label define empstat_sp_lbl 1 `"Employed"', add
label define empstat_sp_lbl 2 `"Unemployed"', add
label define empstat_sp_lbl 3 `"Not in labor force"', add
label values empstat_sp empstat_sp_lbl

label define empstatd_sp_lbl 00 `"N/A"'
label define empstatd_sp_lbl 10 `"At work"', add
label define empstatd_sp_lbl 11 `"At work, public emerg"', add
label define empstatd_sp_lbl 12 `"Has job, not working"', add
label define empstatd_sp_lbl 13 `"Armed forces"', add
label define empstatd_sp_lbl 14 `"Armed forces--at work"', add
label define empstatd_sp_lbl 15 `"Armed forces--not at work but with job"', add
label define empstatd_sp_lbl 20 `"Unemployed"', add
label define empstatd_sp_lbl 21 `"Unemp, exper worker"', add
label define empstatd_sp_lbl 22 `"Unemp, new worker"', add
label define empstatd_sp_lbl 30 `"Not in Labor Force"', add
label define empstatd_sp_lbl 31 `"NILF, housework"', add
label define empstatd_sp_lbl 32 `"NILF, unable to work"', add
label define empstatd_sp_lbl 33 `"NILF, school"', add
label define empstatd_sp_lbl 34 `"NILF, other"', add
label values empstatd_sp empstatd_sp_lbl

label define wkswork2_sp_lbl 0 `"N/A"'
label define wkswork2_sp_lbl 1 `"1-13 weeks"', add
label define wkswork2_sp_lbl 2 `"14-26 weeks"', add
label define wkswork2_sp_lbl 3 `"27-39 weeks"', add
label define wkswork2_sp_lbl 4 `"40-47 weeks"', add
label define wkswork2_sp_lbl 5 `"48-49 weeks"', add
label define wkswork2_sp_lbl 6 `"50-52 weeks"', add
label values wkswork2_sp wkswork2_sp_lbl

label define uhrswork_sp_lbl 00 `"N/A"'
label define uhrswork_sp_lbl 01 `"1"', add
label define uhrswork_sp_lbl 02 `"2"', add
label define uhrswork_sp_lbl 03 `"3"', add
label define uhrswork_sp_lbl 04 `"4"', add
label define uhrswork_sp_lbl 05 `"5"', add
label define uhrswork_sp_lbl 06 `"6"', add
label define uhrswork_sp_lbl 07 `"7"', add
label define uhrswork_sp_lbl 08 `"8"', add
label define uhrswork_sp_lbl 09 `"9"', add
label define uhrswork_sp_lbl 10 `"10"', add
label define uhrswork_sp_lbl 11 `"11"', add
label define uhrswork_sp_lbl 12 `"12"', add
label define uhrswork_sp_lbl 13 `"13"', add
label define uhrswork_sp_lbl 14 `"14"', add
label define uhrswork_sp_lbl 15 `"15"', add
label define uhrswork_sp_lbl 16 `"16"', add
label define uhrswork_sp_lbl 17 `"17"', add
label define uhrswork_sp_lbl 18 `"18"', add
label define uhrswork_sp_lbl 19 `"19"', add
label define uhrswork_sp_lbl 20 `"20"', add
label define uhrswork_sp_lbl 21 `"21"', add
label define uhrswork_sp_lbl 22 `"22"', add
label define uhrswork_sp_lbl 23 `"23"', add
label define uhrswork_sp_lbl 24 `"24"', add
label define uhrswork_sp_lbl 25 `"25"', add
label define uhrswork_sp_lbl 26 `"26"', add
label define uhrswork_sp_lbl 27 `"27"', add
label define uhrswork_sp_lbl 28 `"28"', add
label define uhrswork_sp_lbl 29 `"29"', add
label define uhrswork_sp_lbl 30 `"30"', add
label define uhrswork_sp_lbl 31 `"31"', add
label define uhrswork_sp_lbl 32 `"32"', add
label define uhrswork_sp_lbl 33 `"33"', add
label define uhrswork_sp_lbl 34 `"34"', add
label define uhrswork_sp_lbl 35 `"35"', add
label define uhrswork_sp_lbl 36 `"36"', add
label define uhrswork_sp_lbl 37 `"37"', add
label define uhrswork_sp_lbl 38 `"38"', add
label define uhrswork_sp_lbl 39 `"39"', add
label define uhrswork_sp_lbl 40 `"40"', add
label define uhrswork_sp_lbl 41 `"41"', add
label define uhrswork_sp_lbl 42 `"42"', add
label define uhrswork_sp_lbl 43 `"43"', add
label define uhrswork_sp_lbl 44 `"44"', add
label define uhrswork_sp_lbl 45 `"45"', add
label define uhrswork_sp_lbl 46 `"46"', add
label define uhrswork_sp_lbl 47 `"47"', add
label define uhrswork_sp_lbl 48 `"48"', add
label define uhrswork_sp_lbl 49 `"49"', add
label define uhrswork_sp_lbl 50 `"50"', add
label define uhrswork_sp_lbl 51 `"51"', add
label define uhrswork_sp_lbl 52 `"52"', add
label define uhrswork_sp_lbl 53 `"53"', add
label define uhrswork_sp_lbl 54 `"54"', add
label define uhrswork_sp_lbl 55 `"55"', add
label define uhrswork_sp_lbl 56 `"56"', add
label define uhrswork_sp_lbl 57 `"57"', add
label define uhrswork_sp_lbl 58 `"58"', add
label define uhrswork_sp_lbl 59 `"59"', add
label define uhrswork_sp_lbl 60 `"60"', add
label define uhrswork_sp_lbl 61 `"61"', add
label define uhrswork_sp_lbl 62 `"62"', add
label define uhrswork_sp_lbl 63 `"63"', add
label define uhrswork_sp_lbl 64 `"64"', add
label define uhrswork_sp_lbl 65 `"65"', add
label define uhrswork_sp_lbl 66 `"66"', add
label define uhrswork_sp_lbl 67 `"67"', add
label define uhrswork_sp_lbl 68 `"68"', add
label define uhrswork_sp_lbl 69 `"69"', add
label define uhrswork_sp_lbl 70 `"70"', add
label define uhrswork_sp_lbl 71 `"71"', add
label define uhrswork_sp_lbl 72 `"72"', add
label define uhrswork_sp_lbl 73 `"73"', add
label define uhrswork_sp_lbl 74 `"74"', add
label define uhrswork_sp_lbl 75 `"75"', add
label define uhrswork_sp_lbl 76 `"76"', add
label define uhrswork_sp_lbl 77 `"77"', add
label define uhrswork_sp_lbl 78 `"78"', add
label define uhrswork_sp_lbl 79 `"79"', add
label define uhrswork_sp_lbl 80 `"80"', add
label define uhrswork_sp_lbl 81 `"81"', add
label define uhrswork_sp_lbl 82 `"82"', add
label define uhrswork_sp_lbl 83 `"83"', add
label define uhrswork_sp_lbl 84 `"84"', add
label define uhrswork_sp_lbl 85 `"85"', add
label define uhrswork_sp_lbl 86 `"86"', add
label define uhrswork_sp_lbl 87 `"87"', add
label define uhrswork_sp_lbl 88 `"88"', add
label define uhrswork_sp_lbl 89 `"89"', add
label define uhrswork_sp_lbl 90 `"90"', add
label define uhrswork_sp_lbl 91 `"91"', add
label define uhrswork_sp_lbl 92 `"92"', add
label define uhrswork_sp_lbl 93 `"93"', add
label define uhrswork_sp_lbl 94 `"94"', add
label define uhrswork_sp_lbl 95 `"95"', add
label define uhrswork_sp_lbl 96 `"96"', add
label define uhrswork_sp_lbl 97 `"97"', add
label define uhrswork_sp_lbl 98 `"98"', add
label define uhrswork_sp_lbl 99 `"99 (Topcode)"', add
label values uhrswork_sp uhrswork_sp_lbl

label define incwage_sp_lbl 999998 `"Missing"'
label define incwage_sp_lbl 999999 `"N/A"', add
label define incwage_sp_lbl 010000 `"010000"', add
label define incwage_sp_lbl 000000 `"000000"', add
label values incwage_sp incwage_sp_lbl

label define incwelfr_sp_lbl 99999 `"NIU"'
label define incwelfr_sp_lbl 99998 `"99998"', add
label define incwelfr_sp_lbl 00000 `"00000"', add
label values incwelfr_sp incwelfr_sp_lbl


*Dropping variables
**filters of the dataset
drop if sex != 2
drop if age < 15 | age > 65
drop if related == 9997 | related == 9998 | related == 9999
**missing from the observations
drop if educd == 001
drop if empstat == 0
drop if empstatd == 00
drop if wkswork2 == 0
drop if uhrswork == 00
**missing from the spouse
drop if educd_sp == 001
drop if wkswork2_sp == 0
drop if empstat_sp == 0
drop if empstatd_sp == 00
drop if uhrswork_sp == 00




*Correcting to Real values
g Price_Index = 0
replace Price_Index = 208.80556984677200 if year == 2005
replace Price_Index = 215.34214811426400 if year == 2006
replace Price_Index = 221.92392295918700 if year == 2007
replace Price_Index = 227.93273798574800 if year == 2008
replace Price_Index = 230.81423554946100 if year == 2009
replace Price_Index = 232.48710665007100 if year == 2010
replace Price_Index = 237.86484774264700 if year == 2011
replace Price_Index = 242.97195785139900 if year == 2012
replace Price_Index = 248.15000694380300 if year == 2013
replace Price_Index = 253.70029024799400 if year == 2014
replace Price_Index = 259.5563650712550  if year == 2015
replace Price_Index = 266.24186043556700 if year == 2016
replace Price_Index = 272.73297356975500 if year == 2017
replace Price_Index = 280.16524554597400 if year == 2018
replace Price_Index = 288.28592794627100 if year == 2019

*Correcting weeks worked
replace wkswork2 = 7 if wkswork2 == 1
replace wkswork2 = 20 if wkswork2 == 2
replace wkswork2 = 33 if wkswork2 == 3
replace wkswork2 = 43.5 if wkswork2 == 4
replace wkswork2 = 48.5 if wkswork2 == 5
replace wkswork2 = 51 if wkswork2 == 6

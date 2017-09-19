#!/bin/sh

if [ $label = 'fruitloop' ]
then
export CUTWIDTH="6"
else
export CUTWIDTH="1"
fi

if [ $label = 'fruitloop' ]
then
export CUTWIDTH2="5"
else
export CUTWIDTH2="1"
fi

case $GAPTARGET in
install)
/bin/echo '=========OUTPUT START: testinstall without packages========='
cat `ls dev/log/testinstall1_*|tail -1`
/bin/echo '=========OUTPUT END: testinstall without packages========='
/bin/echo '=========OUTPUT START: testinstall with packages========='
cat `ls dev/log/testinstall2_*|tail -1`
/bin/echo '=========OUTPUT END: testinstall with packages========='
/bin/echo -n "YVALUE=" > dev/log/plotinstall1_count.txt
wc -l `ls dev/log/testinstall1_*|tail -1` | cut -f $CUTWIDTH -d ' ' >> dev/log/plotinstall1_count.txt
/bin/echo -n "URL=" >> dev/log/plotinstall1_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotinstall1_count.txt
#
/bin/echo -n "YVALUE=" > dev/log/plotinstall2_count.txt
wc -l `ls dev/log/testinstall2_*|tail -1` | cut -f $CUTWIDTH -d ' ' >> dev/log/plotinstall2_count.txt
/bin/echo -n "URL=" >> dev/log/plotinstall2_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotinstall2_count.txt
#
cat `ls dev/log/testinstall1_*|tail -1` | tail -4 | head -1 | sed -e 's/  */ /g' | cut -f 1 -d ' ' > dev/log/plotinstall1_total.txt
export GAPTOTAL=`cat dev/log/plotinstall1_total.txt `
if [ $GAPTOTAL = 'total' ]
then
/bin/echo -n "YVALUE=" > dev/log/plotinstall1_time.txt
cat `ls dev/log/testinstall1_*|tail -1` | tail -4 | head -1 | sed -e 's/  */ /g' | cut -f 3 -d ' ' >> dev/log/plotinstall1_time.txt
/bin/echo -n "URL=" >> dev/log/plotinstall1_time.txt
/bin/echo -n $BUILD_URL >> dev/log/plotinstall1_time.txt
else
/bin/echo "test was not completed"
exit 1
fi
cat `ls dev/log/testinstall2_*|tail -1` | tail -4 | head -1 | sed -e 's/  */ /g' | cut -f 1 -d ' ' > dev/log/plotinstall2_total.txt
export GAPTOTAL=`cat dev/log/plotinstall2_total.txt`
if [ $GAPTOTAL = 'total' ]
then
/bin/echo -n "YVALUE=" > dev/log/plotinstall2_time.txt
cat `ls dev/log/testinstall2_*|tail -1` | tail -4 | head -1 | sed -e 's/  */ /g' | cut -f 3 -d ' ' >> dev/log/plotinstall2_time.txt
/bin/echo -n "URL=" >> dev/log/plotinstall2_time.txt
/bin/echo -n $BUILD_URL >> dev/log/plotinstall2_time.txt
else
/bin/echo "test was not completed"
exit 1
fi
#
export NUMFAILS=`cat dev/log/testinstall* | grep -c "########> Diff"`
/bin/echo %%% Number of diffs: $NUMFAILS
if [ $NUMFAILS = '0' ]
then
/bin/echo '=========No differences found========='
else
exit 1
fi
;;
bugfix)
/bin/echo '=========OUTPUT START: testbugfix without packages========='
cat `ls dev/log/testbugfix1_*|tail -1`
/bin/echo '=========OUTPUT END: testbugfix without packages========='
/bin/echo '=========OUTPUT START: testbugfix with packages========='
cat `ls dev/log/testbugfix2_*|tail -1`
/bin/echo '=========OUTPUT END: testbugfix with packages========='
cat `ls dev/log/testbugfix1_*|tail -1` | tail -4 | head -1 | sed -e 's/  */ /g' | cut -f 1 -d ' ' > dev/log/testbugfix1_pass.txt
export GAPTOTAL=`cat dev/log/testbugfix1_pass.txt `
if [ $GAPTOTAL != 'total' ]
then
/bin/echo "test was not completed"
exit 1
fi
cat `ls dev/log/testbugfix2_*|tail -1` | tail -4 | head -1 | sed -e 's/  */ /g' | cut -f 1 -d ' ' > dev/log/testbugfix2_pass.txt
export GAPTOTAL=`cat dev/log/testbugfix2_pass.txt`
if [ $GAPTOTAL != 'total' ]
then
/bin/echo "test was not completed"
exit 1
fi
#
export NUMFAILS=`cat dev/log/testbugfix* | grep -c "########> Diff"`
/bin/echo %%% Number of diffs: $NUMFAILS
if [ $NUMFAILS = '0' ]
then
/bin/echo '=========No differences found========='
else
exit 1
fi
;;
standard)
/bin/echo '=========OUTPUT START: teststandard without packages========='
cat `ls dev/log/teststandard1_*|tail -1`
/bin/echo '=========OUTPUT END: teststandard without packages========='
/bin/echo '=========OUTPUT START: teststandard with packages========='
cat `ls dev/log/teststandard2_*|tail -1`
/bin/echo '=========OUTPUT END: teststandard with packages========='
/bin/echo -n "YVALUE=" > dev/log/plotstandard1_count.txt
wc -l `ls dev/log/teststandard1_*|tail -1` | cut -f $CUTWIDTH -d ' ' >> dev/log/plotstandard1_count.txt
/bin/echo -n "URL=" >> dev/log/plotstandard1_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotstandard1_count.txt
#
/bin/echo -n "YVALUE=" > dev/log/plotstandard2_count.txt
wc -l `ls dev/log/teststandard2_*|tail -1` | cut -f $CUTWIDTH -d ' ' >> dev/log/plotstandard2_count.txt
/bin/echo -n "URL=" >> dev/log/plotstandard2_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotstandard2_count.txt
#
for GTEST in arithlst hash2 primsan xgap grppcnrm grpmat grpperm matrix grplatt bugfix grpprmcs grpconst 
do
/bin/echo -n "YVALUE=" > dev/log/plot${GTEST}1.txt
grep "^${GTEST}" `ls dev/log/teststandard1_*` | sed -e 's/  */ /g' | cut -f 3 -d ' ' >> dev/log/plot${GTEST}1.txt
/bin/echo -n "URL=" >> dev/log/plot${GTEST}1.txt
/bin/echo -n $BUILD_URL >> dev/log/plot${GTEST}1.txt
#
/bin/echo -n "YVALUE=" > dev/log/plot${GTEST}2.txt
grep "^${GTEST}" `ls dev/log/teststandard2_*` | sed -e 's/  */ /g' | cut -f 3 -d ' ' >> dev/log/plot${GTEST}2.txt
/bin/echo -n "URL=" >> dev/log/plot${GTEST}2.txt
/bin/echo -n $BUILD_URL >> dev/log/plot${GTEST}2.txt
#
done
#
cat `ls dev/log/teststandard1_*|tail -1` | tail -4 | head -1 | sed -e 's/  */ /g' | cut -f 1 -d ' ' > dev/log/plotstandard1_total.txt
export GAPTOTAL=`cat dev/log/plotstandard1_total.txt`
if [ $GAPTOTAL = 'total' ]
then
/bin/echo -n "YVALUE=" > dev/log/plotstandard1_time.txt
cat `ls dev/log/teststandard1_*|tail -1` | tail -4 | head -1 | sed -e 's/  */ /g' | cut -f 3 -d ' ' >> dev/log/plotstandard1_time.txt
/bin/echo -n "URL=" >> dev/log/plotstandard1_time.txt
/bin/echo -n $BUILD_URL >> dev/log/plotstandard1_time.txt
else
/bin/echo "test was not completed"
exit 1
fi
cat `ls dev/log/teststandard2_*|tail -1` | tail -4 | head -1 | sed -e 's/  */ /g' | cut -f 1 -d ' ' > dev/log/plotstandard2_total.txt
export GAPTOTAL=`cat dev/log/plotstandard2_total.txt`
if [ $GAPTOTAL = 'total' ]
then
/bin/echo -n "YVALUE=" > dev/log/plotstandard2_time.txt
cat `ls dev/log/teststandard2_*|tail -1` | tail -4 | head -1 | sed -e 's/  */ /g' | cut -f 3 -d ' ' >> dev/log/plotstandard2_time.txt
/bin/echo -n "URL=" >> dev/log/plotstandard2_time.txt
/bin/echo -n $BUILD_URL >> dev/log/plotstandard2_time.txt
else
/bin/echo "test was not completed"
exit 1
fi
#
export NUMFAILS=`cat dev/log/teststandard* | grep -c "########> Diff"`
/bin/echo %%% Number of diffs: $NUMFAILS
if [ $NUMFAILS = '0' ]
then
/bin/echo '=========No differences found========='
else
exit 1
fi
;;
manuals)
/bin/echo '=========OUTPUT START: making tutorial========='
cat doc/tut/make_manuals.out
/bin/echo '=========OUTPUT END: making tutorial========='
/bin/echo '=========OUTPUT START: making reference manual========='
cat doc/ref/make_manuals.out
/bin/echo '=========OUTPUT END: making reference manual========='
/bin/echo '=========OUTPUT START: testmanuals without packages========='
cat `ls dev/log/testmanuals1_*|tail -1`
/bin/echo '=========OUTPUT END: testmanuals without packages========='
/bin/echo '=========OUTPUT START: testmanuals with all packages========='
cat `ls dev/log/testmanuals2_*|tail -1`
/bin/echo '=========OUTPUT END: testmanuals with all packages========='
/bin/echo '=========OUTPUT START: testmanuals with autoloaded packages========='
cat `ls dev/log/testmanualsA_*|tail -1`
/bin/echo '=========OUTPUT END: testmanuals with autoloaded packages========='
/bin/echo -n "YVALUE=" > dev/log/plotmanuals1_count.txt
wc -l `ls dev/log/testmanuals1_*|tail -1` | cut -f $CUTWIDTH -d ' ' >> dev/log/plotmanuals1_count.txt
/bin/echo -n "URL=" >> dev/log/plotmanuals1_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotmanuals1_count.txt
#
/bin/echo -n "YVALUE=" > dev/log/plotmanualsA_count.txt
wc -l `ls dev/log/testmanualsA_*|tail -1` | cut -f $CUTWIDTH -d ' ' >> dev/log/plotmanualsA_count.txt
/bin/echo -n "URL=" >> dev/log/plotmanualsA_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotmanualsA_count.txt
#
/bin/echo -n "YVALUE=" > dev/log/plotmanuals2_count.txt
wc -l `ls dev/log/testmanuals2_*|tail -1` | cut -f $CUTWIDTH -d ' ' >> dev/log/plotmanuals2_count.txt
/bin/echo -n "URL=" >> dev/log/plotmanuals2_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotmanuals2_count.txt
#
export NUMFAILS=`cat dev/log/testmanualsA* | grep -c "########> Diff"`
/bin/echo %%% Number of diffs with default packages: $NUMFAILS
if [ $NUMFAILS = '0' ]
then
export NUMMANUALTESTS=`cat dev/log/testmanuals* | grep -c "Checking ref, Chapter 87"`
if [ $NUMMANUALTESTS = '3' ]
then
/bin/echo Manual tests were completed in $NUMMANUALTESTS configurations.
/bin/echo No new differences were found while running examples with default packages.
else
/bin/echo Manual tests failed: completed only in $NUMMANUALTESTS out of 3 configurations!
exit 1
fi
else
/bin/echo Manual tests were completed in $NUMMANUALTESTS configurations.
/bin/echo They failed because of $NUMFAILS differences running examples with default packages!
exit 1
fi
;;
packages)
/bin/echo '=========OUTPUT START: testpackages========='
if [ $label = 'fruitloop' ]
then
ls dev/log/testpackages*.*
else
for f in `ls -X dev/log/testpackages*.*`
do
        cat $f
done
fi
/bin/echo '=========OUTPUT END: testpackages========='
#
/bin/echo 'Package name | default | no packages | all packages'
for PKGNAME in `find dev/log -type f | sed 's|.*\.||' | sort -u`
do
    for TESTCASE in A 1 2
    do
        export TESTRESULT=`cat dev/log/testpackages${TESTCASE}*.$PKGNAME | grep -c "#I  No errors detected while testing"`
        if [ $TESTRESULT = '1' ]
        then
            # info message is there - this is a clear PASS
            export PASS$TESTCASE=PASS
        else
            export NUMFAILS=`cat dev/log/testpackages${TESTCASE}*.$PKGNAME | grep -c "########> Diff"`
            if [ $NUMFAILS = '0' ]
            then
                # zero diffs, but no info message - what could that mean?
                export TESTCOMPLETED=`cat dev/log/testpackages${TESTCASE}*.$PKGNAME | grep -c "#I  RunPackageTests"`
                if [ $TESTCOMPLETED = '2' ]
                then
                    # still there are two "RunPackageTests" (one at the beginning of the test, one at the end)
                    # This means that at least the test did not crash
                    export PASS$TESTCASE="UNCLEAR"
                elif [ $TESTCOMPLETED = '1' ]
                # only one "RunPackageTests": either a crash or LoadPackage returned 'fail'
                then
                    if [ `cat dev/log/testpackages${TESTCASE}*.$PKGNAME | grep "#I  RunPackageTests" | grep -c "not loadable"` = '1' ]
                    then
                        # if LoadPackage returned fail, this will be clearly indicated in the log
                        export PASS$TESTCASE="NOT LOADED"
                    else
                        # otherwise, log has initial RunPackageTests, package was loaded and then crashed
                        export PASS$TESTCASE="CRASH"
                    fi
                else
                    # The log does not contain "RunPackageTests" at all
                    export PASS$TESTCASE="NOT STARTED"
                fi
            else
                # one of more diffs - this is a clear FAIL
                export PASS$TESTCASE="${NUMFAILS} DIFFS"
            fi
        fi
    done
/bin/echo $PKGNAME '|' $PASSA '|' $PASS1 '|' $PASS2
done
#
/bin/echo -n "YVALUE=" > dev/log/plotpackages1_count.txt
wc -l dev/log/testpackages1_*| tail -1 | cut -f 1 -d 't' >> dev/log/plotpackages1_count.txt
/bin/echo -n "URL=" >> dev/log/plotpackages1_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotpackages1_count.txt
#
/bin/echo -n "YVALUE=" > dev/log/plotpackages2_count.txt
wc -l dev/log/testpackages2_*|tail -1 | cut -f 1 -d 't' >> dev/log/plotpackages2_count.txt
/bin/echo -n "URL=" >> dev/log/plotpackages2_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotpackages2_count.txt
#
/bin/echo -n "YVALUE=" > dev/log/plotpackagesA_count.txt
wc -l dev/log/testpackagesA_*|tail -1 | cut -f 1 -d 't' >> dev/log/plotpackagesA_count.txt
/bin/echo -n "URL=" >> dev/log/plotpackagesA_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotpackagesA_count.txt
;;
packagesload)
/bin/echo '======OUTPUT START: test packages loading (without autoloaded packages)======'
cat `ls dev/log/testpackagesload1_*`
/bin/echo '======OUTPUT END: test packages loading (without autoloaded packages)======'
/bin/echo '======OUTPUT START: test packages loading (with autoloaded packages)======'
cat `ls dev/log/testpackagesloadA_*`
/bin/echo '======OUTPUT END: test packages loading (with autoloaded packages)======'
/bin/echo '======OUTPUT START: test packages loading (with only needed; without autoloaded packages)======'
cat `ls dev/log/testpackagesloadN1_*`
/bin/echo '======OUTPUT END: test packages loading (with only needed; without autoloaded packages)======'
/bin/echo '======OUTPUT START: test packages loading (with only needed; with autoloaded packages)======'
cat `ls dev/log/testpackagesloadNA_*`
/bin/echo '======OUTPUT END: test packages loading (with only needed; with autoloaded packages)======'
/bin/echo -n "YVALUE=" > dev/log/plotpackagesload1_count.txt
wc -l `ls dev/log/testpackagesload1_*|tail -1` | cut -f $CUTWIDTH2 -d ' ' >> dev/log/plotpackagesload1_count.txt
/bin/echo -n "URL=" >> dev/log/plotpackagesload1_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotpackagesload1_count.txt
#
/bin/echo -n "YVALUE=" > dev/log/plotpackagesloadA_count.txt
wc -l `ls dev/log/testpackagesloadA_*|tail -1` | cut -f $CUTWIDTH2 -d ' ' >> dev/log/plotpackagesloadA_count.txt
/bin/echo -n "URL=" >> dev/log/plotpackagesloadA_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotpackagesloadA_count.txt
#
/bin/echo -n "YVALUE=" > dev/log/plotpackagesloadN1_count.txt
wc -l `ls dev/log/testpackagesloadN1_*|tail -1` | cut -f $CUTWIDTH2 -d ' ' >> dev/log/plotpackagesloadN1_count.txt
/bin/echo -n "URL=" >> dev/log/plotpackagesloadN1_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotpackagesloadN1_count.txt
#
/bin/echo -n "YVALUE=" > dev/log/plotpackagesloadNA_count.txt
wc -l `ls dev/log/testpackagesloadNA_*|tail -1` | cut -f $CUTWIDTH2 -d ' ' >> dev/log/plotpackagesloadNA_count.txt
/bin/echo -n "URL=" >> dev/log/plotpackagesloadNA_count.txt
/bin/echo -n $BUILD_URL >> dev/log/plotpackagesloadNA_count.txt
#
NUMPKGLOADSTART=`cat dev/log/testpackagesload* | grep -c "%%% Loading"`
NUMPKGLOADDONE=`cat dev/log/testpackagesload* | grep -c "### Loaded"`
NUMPKGLOADFAIL=`cat dev/log/testpackagesload* | grep -c "### Not loaded"`
export PKGSGONE=$(($NUMPKGLOADSTART-$NUMPKGLOADDONE-$NUMPKGLOADFAIL))
/bin/echo %%% Packages attempted to start: $NUMPKGLOADSTART
/bin/echo %%% Packages loaded: $NUMPKGLOADDONE
/bin/echo %%% Packages not loaded: $NUMPKGLOADFAIL
/bin/echo %%% Packages crashing while loading: $PKGSGONE
#
/bin/echo -n "YVALUE=" > dev/log/plotpackagesloadfail.txt
/bin/echo $NUMPKGLOADFAIL >> dev/log/plotpackagesloadfail.txt
/bin/echo -n "URL=" >> dev/log/plotpackagesloadfail.txt
/bin/echo -n $BUILD_URL >> dev/log/plotpackagesloadfail.txt
#
grep -h "### Not loaded" dev/log/testpackagesload* | sort
#
/bin/echo '==========Packages with warnings ================================'
grep -h "Do not" dev/log/testpackagesload* | sort
/bin/echo 'Total number of warnings during package loading :'
grep -h "Do not" dev/log/testpackagesload* | wc -l
#
/bin/echo '==========LoadAllPackages tests ================================='
grep -h "### all packages loaded" dev/log/testpackagesload* | sort
/bin/echo 'Number of successful LoadAllPackages tests :'
grep -h "### all packages loaded" dev/log/testpackagesload* | wc -l
export NUMALLPKGLOAD=`cat dev/log/testpackagesload* | grep -c "### all packages loaded"`
if [ $NUMALLPKGLOAD = '4' ]
then
/bin/echo 'LoadAllPackages: all tests passed successfully!!!'
else
/bin/echo  LoadAllPackages test failed: $NUMALLPKGLOAD configurations successful out of 4
/bin/echo  Additionally, $PKGSGONE packages crashed during loading
exit 1
fi
#
if [ $PKGSGONE = '0' ]
then
/bin/echo 'Loading individual packages: all tests completed!!!'
else
/bin/echo  Loading individual packages failed: $PKGSGONE packages crashed during loading
exit 1
fi
;;
packagesvars)
echo '=========OUTPUT START: testpackagesvars========='
cat `ls dev/log/testpackagesvars*|tail -1`
echo '=========OUTPUT END: testpackagesvars========='
;;
updates)
echo '=========OUTPUT START: testupdates========='
cat `ls dev/log/testupdates1*|tail -1`
echo '==========================================='
cat `ls dev/log/testupdates2*|tail -1`
echo '=========OUTPUT END: testupdates========='
export NUMFAILS=`cat dev/log/testupdates* | grep -c "########> Diff"`
/bin/echo %%% Number of diffs: $NUMFAILS
if [ $NUMFAILS = '0' ]
then
/bin/echo '=========No differences found========='
else
exit 1
fi
;;
obsoletes)
echo '=========OUTPUT START: testobsoletes========='
cat `ls dev/log/testobsoletes1*|tail -1`
echo '==========================================='
cat `ls dev/log/testobsoletesN1*|tail -1`
echo '=========OUTPUT END: testobsoletes========='
;;
esac
/bin/echo '=========OUTPUT FINISHED========='
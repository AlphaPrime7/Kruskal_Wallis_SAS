* author: Tingwei Adeck
* date: 2022-11-13
* purpose: Kruskal-Wallis analysis of how activity affects stress
* license: public domain
* Input: kw_test.sav
* Output: K-W_kwtest_SAS.pdf
* Description: Understand the impact of activity on stress
* Results: high activity leads to less stress;

%let path=/home/u40967678/sasuser.v94;


libname disney
    "&path/sas_umkc/input";
    
filename kwtest
    "&path/sas_umkc/input/kw_test.sav";   
    
ods pdf file=
    "&path/sas_umkc/output/K-W_kwtest_SAS.pdf";
    
options papersize=(8in 4in) nonumber nodate;

proc import file= kwtest
	out=disney.kwtest
	dbms=sav
	replace;
run;

title 'summary (first 10 obs) of Stress cope data';
proc print data=disney.kwtest (obs=10);

/*perform Kruskal-Wallis test*/
proc npar1way data=disney.kwtest wilcoxon dscf;
    class group;
    var coping_stress;
run;


ods pdf close;
* author: Tingwei Adeck
* date: 2022-11-13
* purpose: Kruskal-Wallis analysis of how work ethic drives customer satisfaction (proxy:assessment)
* license: public domain
* Input: jiminy.sav
* Output: K-W_Disney_SAS.pdf
* Description: Understand the impact of work ethic on customer satisfaction
* Results: category distributions are different and hardworking employees obtain better assessments from clients;

%let path=/home/u40967678/sasuser.v94;


libname disney
    "&path/sas_umkc/input";
    
filename jim
    "&path/sas_umkc/input/jiminy.sav";   
    
ods pdf file=
    "&path/sas_umkc/output/K-W_Disney_SAS.pdf";
    
options papersize=(8in 4in) nonumber nodate;

proc import file= jim
	out=disney.jim
	dbms=sav
	replace;
run;

title 'summary (first 10 obs) of disney employee type and assessment score';
proc print data=disney.jim (obs=10);

/*perform Kruskal-Wallis test*/
proc npar1way data=disney.jim wilcoxon dscf;
    class WorkerType;
    var Assessment;
run;


ods pdf close;
clear all

 use "C:\Users\aman2220\Desktop\canadiancollege.dta"
 
 . summarize
 
 histogram age_at_entry, ytitle(count) xtitle(Age of student entering college)
(bin=45, start=17, width=.08888889)


graph pie, over(sex) title(Male vs Female enrolled in college)

scatter GPA_year1 hsgrade_pct, ytitle(GPA: First Year of College) xtitle(High School Grade Percentage)


histogram suspended_ever, addlabel ytitle(Count) xtitle(Amount of people being suspended ever)
(bin=45, start=0, width=.02222222)


tab sex, gen(gender)
tab mtongue, gen(mothertongue)
tab birthplace, gen(birthplace1)
tab age_at_entry, gen(ageatentry)

rename gender1 female
rename gender2 male
rename mothertongue1 english
rename mothertongue2 french
rename mothertongue3 other_language
rename birthplace11 america
rename birthplace12 asia
rename birthplace13 canada
rename birthplace14 other_country
rename ageatentry1 age_at_17
rename ageatentry2 age_at_18
rename ageatentry3 age_at_19
rename ageatentry4 age_at_20
rename ageatentry5 age_at_21

regress GPA_year1 totcredits_year1 age_at_17 age_at_18 age_at_19 age_at_20 age_at_21 gradin4 gradin5 gradin6 probation_year1 suspended_year1 campus1 campus2 campus3 female male english french other_language america asia canada other_country hsgrade_pct

#taking out variables due to multicollinearity
regress GPA_year1 totcredits_year1 age_at_18 age_at_19 age_at_20 age_at_21 gradin4 gradin5 gradin6 probation_year1 suspended_year1 campus2 campus3 female english french asia canada other_country hsgrade_pct

drop birthplace mtongue sex



predict yhat
predict uhat, resid
twoway scatter uhat yhat
twoway scatter uhat totcredits_year1, xtitle(Total credits taken in the 1st year)
twoway scatter uhat age_at_17, xtitle(Age 17 when first enrolled in University)
twoway scatter uhat age_at_18, xtitle(Age 18 when first enrolled in University)
twoway scatter uhat age_at_19, xtitle(Age 19 when first enrolled in University)
twoway scatter uhat age_at_20, xtitle(Age 20 when first enrolled in University)
twoway scatter uhat age_at_21, xtitle(Age 21 when first enrolled in University)
twoway scatter uhat gradin4, xtitle(Whether they will graduate in 4 years)
twoway scatter uhat gradin5, xtitle(Whether they will graduate in 5 years)
twoway scatter uhat gradin6, xtitle(Whether they will graduate in 6 years)
twoway scatter uhat probation_year1, xtitle(Whether they will be on probation their 1st year)
twoway scatter uhat suspended_year1, xtitle(Whether they will be suspended on their 1st year)
twoway scatter uhat campus1, xtitle(Whether they are on the 1st campus)
twoway scatter uhat campus2, xtitle(Whether they are on the 2nd campus)
twoway scatter uhat campus3, xtitle(Whether they are on the 3rd campus)
twoway scatter uhat female, xtitle(Females on Campus)
twoway scatter uhat male, xtitle(Males on Campus)
twoway scatter uhat english, xtitle(English as the mothertongue of the students enrolled)
twoway scatter uhat french, xtitle(French as the mothertongue of the students enrolled)
twoway scatter uhat other_language, xtitle(other language as the mothertongue of the students enrolled)
twoway scatter uhat asia, xtitle(Asia as the birthplace of the students enrolled)
twoway scatter uhat canada, xtitle(Canada as the birthplace of the students enrolled)
twoway scatter uhat other_country, xtitle(Other country as the birthplace of the students enrolled)


regress GPA_year1 totcredits_year1 age_at_17 age_at_18 age_at_19 age_at_20 age_at_21 gradin4 gradin5 gradin6 probation_year1 suspended_year1 campus2 campus3 male female english french other_language america asia canada other_country hsgrade_pct gpacutoff suspended_ever,robust

test french other_country asia age_at_21 canada english america gradin6 age_at_17 other_language 

regress GPA_year1 totcredits_year1 age_at_18 age_at_19 age_at_20 gradin4 gradin5 probation_year1 suspended_year1 campus2 campus3 female hsgrade_pct suspended_ever,robust


lincom _cons + totcredits_year1*4.5 + age_at_20 + gradin5 + hsgrade_pct*35 + female

lincom _cons + totcredits_year1*4.5 + age_at_19 + gradin4 + gradin5 + hsgrade_pct*51 + female

lincom _cons + totcredits_year1*4 + age_at_19 + hsgrade_pct*42 + female



#stepwise regression
stepwise,pr(.05): regress GPA_year1 totcredits_year1 age_at_18 age_at_19 age_at_20 age_at_21 gradin4 gradin5 gradin6 probation_year1 suspended_year1 campus2 campus3 female english french america asia canada hsgrade_pct suspended_ever,robust

stepwise,pe(.05): regress GPA_year1 totcredits_year1 age_at_18 age_at_19 age_at_20 age_at_21 gradin4 gradin5 gradin6 probation_year1 suspended_year1 campus2 campus3 female english french america asia canada hsgrade_pct suspended_ever,robust





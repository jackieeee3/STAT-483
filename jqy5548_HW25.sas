/* Jackie Yang */
/* Homework #25 */
/* 11/10/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';
/* Problem 3.6 */

DATA leukemia;
	INPUT Disease $ Exposure $ Count;
DATALINES;
Case E 50
Case NE 500
Control E 40
Control NE 500
;
RUN;

PROC FREQ data = leukemia;
	TABLES Disease * Exposure / CHISQ RELRISK;
	WEIGHT Count;
	TITLE 'Odds Ratio and 95% Confidence Interval for Non-Ionizing Radiation Exposure and Leukemia';
RUN;
/* The 95% confidence interval for the odds ratio is (0.8100, 1.9290) so we expect the odds ratio to fall in between the interval 95% of the time.
	As the interval contians 1, the odds ratio of 1.25 is not significant at the 0.05 level */

/* Problem 3.7 */

DATA asthma;
	INPUT SES $ Asthma $ Count;
DATALINES;
Low Yes 40
Low No 100
High Yes 30
High No 130
;
RUN;

PROC FREQ data = asthma order = data;
	TABLES SES * Asthma / RELRISK;
	WEIGHT Count;
	TITLE 'Relative Risk and 95% Confidence Interval for Low SES and Asthma';
RUN;

/* The 95% confidence interval for the relative risk is (1.0057, 2.3088) so we expect the relative risk for low SES to fall between this interval
	95% of the time. As the interval does not contian 1, the risk ratio of 1.5238 is significant at the 0.05 level. */

/* Problem 3.10 */

DATA carotid;
	INPUT MethodOne $ MethodTwo $ Count;
DATALINES;
O O 15
O NO 8
NO O 10
NO NO 67
;
RUN;

PROC FREQ data = carotid;
	TABLES MethodOne * MethodTwo / AGREE;
	WEIGHT Count;
	TITLE 'Kappa Coefficient Between Carotid Stenosis Methods';
RUN;

/* The estimated coefficient Kappa indicates the strength of agreement and is 0.5068. This value suggests that there is moderate agreement between
	the two methods for determining carotid stenosis */

/* Problem  3.18 */

DATA magnesium_solfate;
	INPUT group $ study outcome $ count;
DATALINES;
MgSO4 1 Survived 20
MgSO4 1 Died 100
MgSO4 2 Survived 25
MgSO4 2 Died 150
MgSO4 3 Survived 30
MgSO4 3 Died 200
Placebo 1 Survived 25
Placebo 1 Died 155
Placebo 2 Survived 21
Placebo 2 Died 150
Placebo 3 Survived 28
Placebo 3 Died 240
;
RUN;

PROC FREQ data = magnesium_solfate order = data;
	TITLE 'Meta-Analysis of Magnesium Sulfate Effects';
	TABLES study * group * outcome / ALL;
	WEIGHT count;
RUN;

/* The Breslow-Day test checks if odds ratios are homogenous across studies. If its p-value is greater than 0.05,
	then it's appropriate to combine the data. The p-value for the Breslow-Day test is 0.9836 so it is appropriate to combine
	the datasets */


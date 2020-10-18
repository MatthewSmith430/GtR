README
================

# GtR

This package provides a set of functions to search for UK research
council funded projects from [Gateway to
Research.](https://gtr.ukri.org/)

The package can be installed using the following:

``` r
library(devtools)
devtools::install_github("MatthewSmith430/GtR")
library(GtR)
```

*Please note that the README is incomplete and will be updated soon*

## Project Search

You can search for projects associated with a search term- in the
following example I will search for prjects associated with `social
network analysis`

``` r
library(GtR)
library(kableExtra)

SNA_projects<-gtr_project_search("social network analysis")


kable(SNA_projects[1:3,])
```

<table>

<thead>

<tr>

<th style="text-align:left;">

project\_title

</th>

<th style="text-align:left;">

grant\_category

</th>

<th style="text-align:left;">

project\_id

</th>

<th style="text-align:left;">

project\_url

</th>

<th style="text-align:right;">

value

</th>

<th style="text-align:left;">

start\_date

</th>

<th style="text-align:left;">

end\_date

</th>

<th style="text-align:left;">

funder

</th>

<th style="text-align:left;">

lead\_org

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Social Media Analysis for Social Geography

</td>

<td style="text-align:left;">

Research Grant

</td>

<td style="text-align:left;">

A49CA721-687A-4D55-8FDF-9B60375B6EA8

</td>

<td style="text-align:left;">

<https://gtr.ukri.org:443/projects?ref=ES%2FM001636%2F1>

</td>

<td style="text-align:right;">

457888

</td>

<td style="text-align:left;">

2014-02-14

</td>

<td style="text-align:left;">

2016-05-31

</td>

<td style="text-align:left;">

ESRC

</td>

<td style="text-align:left;">

Newcastle University

</td>

</tr>

<tr>

<td style="text-align:left;">

Social Network Analysis in the field of Political Sociology Case: Brexit
and Online Social Networks

</td>

<td style="text-align:left;">

Studentship

</td>

<td style="text-align:left;">

2962E379-1BE9-4ED1-AF22-FC5C79B7DC1B

</td>

<td style="text-align:left;">

<https://gtr.ukri.org:443/projects?ref=studentship-2103467>

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:left;">

2018-10-01

</td>

<td style="text-align:left;">

2022-06-30

</td>

<td style="text-align:left;">

ESRC

</td>

<td style="text-align:left;">

University of Oxford

</td>

</tr>

<tr>

<td style="text-align:left;">

ISIS: Protecting children in online social networks

</td>

<td style="text-align:left;">

Research Grant

</td>

<td style="text-align:left;">

BB70AE6C-8416-44DD-81A4-EEB5508CCD86

</td>

<td style="text-align:left;">

<https://gtr.ukri.org:443/projects?ref=EP%2FF035454%2F1>

</td>

<td style="text-align:right;">

260325

</td>

<td style="text-align:left;">

2008-10-09

</td>

<td style="text-align:left;">

2011-10-08

</td>

<td style="text-align:left;">

EPSRC

</td>

<td style="text-align:left;">

Middlesex University

</td>

</tr>

</tbody>

</table>

## Extracting Project infromation

The following functions extract information for projects.

### Organisations

The first function extract information on the projects, and lists all of
the organisational collaborators, including both academic and non
academic organisations.

This is done for an example project: \`\`

``` r
library(GtR)
library(kableExtra)
##Example URL
url<-"https://gtr.ukri.org/projects?ref=G0501806"

PROJ<-gtr_project_extract(url)

kable(PROJ[1:3,])
```

<table>

<thead>

<tr>

<th style="text-align:left;">

org

</th>

<th style="text-align:left;">

project\_title

</th>

<th style="text-align:left;">

project\_ref

</th>

<th style="text-align:left;">

abstract\_text

</th>

<th style="text-align:right;">

project\_value

</th>

<th style="text-align:left;">

start\_date

</th>

<th style="text-align:left;">

end\_date

</th>

<th style="text-align:left;">

funder

</th>

<th style="text-align:left;">

topic

</th>

<th style="text-align:left;">

subject

</th>

<th style="text-align:right;">

num\_collaboration\_output

</th>

<th style="text-align:right;">

num\_intellectual\_property\_output

</th>

<th style="text-align:right;">

num\_policy\_influence\_output

</th>

<th style="text-align:right;">

num\_research\_material\_output

</th>

<th style="text-align:right;">

num\_artistic\_creative\_product\_output

</th>

<th style="text-align:right;">

num\_software\_technical\_product\_output

</th>

<th style="text-align:right;">

num\_research\_database\_model\_output

</th>

<th style="text-align:right;">

num\_spinout\_output

</th>

<th style="text-align:right;">

num\_impact\_summary\_output

</th>

<th style="text-align:right;">

num\_further\_funding\_output

</th>

<th style="text-align:right;">

num\_other\_research\_output

</th>

<th style="text-align:right;">

num\_exploitation\_output

</th>

<th style="text-align:right;">

num\_dissemination\_output

</th>

<th style="text-align:right;">

num\_publications

</th>

<th style="text-align:left;">

org\_role

</th>

<th style="text-align:right;">

start\_year

</th>

<th style="text-align:right;">

end\_year

</th>

<th style="text-align:right;">

duration\_weeks

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Cardiff University

</td>

<td style="text-align:left;">

Resubmission: Social network analysis of the dynamic relationship
between adolescent smoking behaviour and peer influence

</td>

<td style="text-align:left;">

G0501806

</td>

<td style="text-align:left;">

There is increasing concern regarding the health behaviours of
adolescents. Peer pressure is often cited as a key factor explaining
adolescents? uptake of risk behaviours, yet there has been surprisingly
little scrutiny of the process by which this occurs. It is most
obviously exerted through overt pressure to experiment with tobacco,
alcohol or illicit drugs, and interventions aim to develop adolescents?
skills to resist peer pressure. Peer influence also operates more
subtly, through the development of normative beliefs, in which, for
example, adolescents believe that the majority of the population smoke,
and that it is a normal part of teenage life to take up smoking.
Adolescents are keen to fit in with their peer group, and model their
own behaviour on those around them. However, there are other mechanisms
at play, including peer selection, in which those with similar
behaviours develop friendships. Adolescents wishing to become friends
with other smokers, may take up smoking as a gateway to joining that
friendship group. The combination of peer influence and peer selection
leads to the development of friendship groups in which the prevalence of
smoking and other risk behaviours is high. These processes contribute to
marked differences between schools in smoking prevalence.

This project will use an existing dataset, collected from a recent MRC
funded study of 10,000 students in 59 schools in South Wales and the
Bristol area. Students were asked on three occasions to name their six
best friends, and about their friendship. Using new statistical methods,
these data will allow the research team to disentangle the relative
importance of peer influence and peer selection. Those non-smokers most
at risk of smoking uptake will be identified, in terms of their own
characteristics, parental influence, and their current friendship
groups. The stability of these patterns across schools will be
identified. In the study, reported smoking was validated through the
collection of saliva samples, and combined with the friendship data,
this will allow the accuracy of students? reports of their friends?
smoking to be assessed. The results of this work will have important
implications for the design of future efforts to reduce adolescent
uptake of smoking and other risk behaviours. There is immense public and
media concern on this issue, and the study team will be sure to produce
press releases of the work, as well as featuring the study and its
results on the Cardiff University website.

</td>

<td style="text-align:right;">

316629

</td>

<td style="text-align:left;">

2006-09-01

</td>

<td style="text-align:left;">

2009-02-28

</td>

<td style="text-align:left;">

MRC

</td>

<td style="text-align:left;">

</td>

<td style="text-align:left;">

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

8

</td>

<td style="text-align:left;">

COLLABORATOR

</td>

<td style="text-align:right;">

2006

</td>

<td style="text-align:right;">

2009

</td>

<td style="text-align:right;">

130.1429

</td>

</tr>

<tr>

<td style="text-align:left;">

Maastricht University (UM)

</td>

<td style="text-align:left;">

Resubmission: Social network analysis of the dynamic relationship
between adolescent smoking behaviour and peer influence

</td>

<td style="text-align:left;">

G0501806

</td>

<td style="text-align:left;">

There is increasing concern regarding the health behaviours of
adolescents. Peer pressure is often cited as a key factor explaining
adolescents? uptake of risk behaviours, yet there has been surprisingly
little scrutiny of the process by which this occurs. It is most
obviously exerted through overt pressure to experiment with tobacco,
alcohol or illicit drugs, and interventions aim to develop adolescents?
skills to resist peer pressure. Peer influence also operates more
subtly, through the development of normative beliefs, in which, for
example, adolescents believe that the majority of the population smoke,
and that it is a normal part of teenage life to take up smoking.
Adolescents are keen to fit in with their peer group, and model their
own behaviour on those around them. However, there are other mechanisms
at play, including peer selection, in which those with similar
behaviours develop friendships. Adolescents wishing to become friends
with other smokers, may take up smoking as a gateway to joining that
friendship group. The combination of peer influence and peer selection
leads to the development of friendship groups in which the prevalence of
smoking and other risk behaviours is high. These processes contribute to
marked differences between schools in smoking prevalence.

This project will use an existing dataset, collected from a recent MRC
funded study of 10,000 students in 59 schools in South Wales and the
Bristol area. Students were asked on three occasions to name their six
best friends, and about their friendship. Using new statistical methods,
these data will allow the research team to disentangle the relative
importance of peer influence and peer selection. Those non-smokers most
at risk of smoking uptake will be identified, in terms of their own
characteristics, parental influence, and their current friendship
groups. The stability of these patterns across schools will be
identified. In the study, reported smoking was validated through the
collection of saliva samples, and combined with the friendship data,
this will allow the accuracy of students? reports of their friends?
smoking to be assessed. The results of this work will have important
implications for the design of future efforts to reduce adolescent
uptake of smoking and other risk behaviours. There is immense public and
media concern on this issue, and the study team will be sure to produce
press releases of the work, as well as featuring the study and its
results on the Cardiff University website.

</td>

<td style="text-align:right;">

316629

</td>

<td style="text-align:left;">

2006-09-01

</td>

<td style="text-align:left;">

2009-02-28

</td>

<td style="text-align:left;">

MRC

</td>

<td style="text-align:left;">

</td>

<td style="text-align:left;">

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

8

</td>

<td style="text-align:left;">

COLLABORATOR

</td>

<td style="text-align:right;">

2006

</td>

<td style="text-align:right;">

2009

</td>

<td style="text-align:right;">

130.1429

</td>

</tr>

<tr>

<td style="text-align:left;">

Pennsylvania State University

</td>

<td style="text-align:left;">

Resubmission: Social network analysis of the dynamic relationship
between adolescent smoking behaviour and peer influence

</td>

<td style="text-align:left;">

G0501806

</td>

<td style="text-align:left;">

There is increasing concern regarding the health behaviours of
adolescents. Peer pressure is often cited as a key factor explaining
adolescents? uptake of risk behaviours, yet there has been surprisingly
little scrutiny of the process by which this occurs. It is most
obviously exerted through overt pressure to experiment with tobacco,
alcohol or illicit drugs, and interventions aim to develop adolescents?
skills to resist peer pressure. Peer influence also operates more
subtly, through the development of normative beliefs, in which, for
example, adolescents believe that the majority of the population smoke,
and that it is a normal part of teenage life to take up smoking.
Adolescents are keen to fit in with their peer group, and model their
own behaviour on those around them. However, there are other mechanisms
at play, including peer selection, in which those with similar
behaviours develop friendships. Adolescents wishing to become friends
with other smokers, may take up smoking as a gateway to joining that
friendship group. The combination of peer influence and peer selection
leads to the development of friendship groups in which the prevalence of
smoking and other risk behaviours is high. These processes contribute to
marked differences between schools in smoking prevalence.

This project will use an existing dataset, collected from a recent MRC
funded study of 10,000 students in 59 schools in South Wales and the
Bristol area. Students were asked on three occasions to name their six
best friends, and about their friendship. Using new statistical methods,
these data will allow the research team to disentangle the relative
importance of peer influence and peer selection. Those non-smokers most
at risk of smoking uptake will be identified, in terms of their own
characteristics, parental influence, and their current friendship
groups. The stability of these patterns across schools will be
identified. In the study, reported smoking was validated through the
collection of saliva samples, and combined with the friendship data,
this will allow the accuracy of students? reports of their friends?
smoking to be assessed. The results of this work will have important
implications for the design of future efforts to reduce adolescent
uptake of smoking and other risk behaviours. There is immense public and
media concern on this issue, and the study team will be sure to produce
press releases of the work, as well as featuring the study and its
results on the Cardiff University website.

</td>

<td style="text-align:right;">

316629

</td>

<td style="text-align:left;">

2006-09-01

</td>

<td style="text-align:left;">

2009-02-28

</td>

<td style="text-align:left;">

MRC

</td>

<td style="text-align:left;">

</td>

<td style="text-align:left;">

</td>

<td style="text-align:right;">

7

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

6

</td>

<td style="text-align:right;">

8

</td>

<td style="text-align:left;">

COLLABORATOR

</td>

<td style="text-align:right;">

2006

</td>

<td style="text-align:right;">

2009

</td>

<td style="text-align:right;">

130.1429

</td>

</tr>

</tbody>

</table>

### Individuals

``` r
library(GtR)
library(kableExtra)
##Example URL
url<-"https://gtr.ukri.org/projects?ref=G0501806"
```

## Impact & Publications

``` r
library(GtR)
library(kableExtra)
##Example URL
url<-"https://gtr.ukri.org/projects?ref=G0501806"
```

## Project topic

# Networks

## Inter-organisational collaboration network

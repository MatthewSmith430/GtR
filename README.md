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
**Updates on the GtR API (such as whether it is down/unavailable) are posted [here](https://gtr.ukri.org/resources/api.html). Please check this page if you encounter isses.**

*Please note that the README is incomplete and will be updated soon*

## Project Search

You can search for projects associated with a search term- in the
following example I will search for projects associated with `social
network analysis`

``` r
library(GtR)
library(kableExtra)


SNA_projects<-gtr_project_search("social network analysis")


kable(SNA_projects[1:3,])%>%
  kable_styling() 
```

<table class="table" style="margin-left: auto; margin-right: auto;">

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

This is done for an example project:

``` r
library(GtR)
library(pander)
library(magrittr)
library(dplyr)
##Example URL
url<-"https://gtr.ukri.org/projects?ref=G0501806"

##Taking out the abstract text from the data - as this is quite long
##Therefore this means the table is easier to read
PROJ<-gtr_project_extract(url)%>%
  select(-abstract_text)

pander(PROJ[1:3,], split.cell = 80, split.table = Inf)
```

|              org              |                                                      project\_title                                                       | project\_ref | project\_value | start\_date | end\_date  | funder |  topic  | subject | num\_collaboration\_output | num\_intellectual\_property\_output | num\_policy\_influence\_output | num\_research\_material\_output | num\_artistic\_creative\_product\_output | num\_software\_technical\_product\_output | num\_research\_database\_model\_output | num\_spinout\_output | num\_impact\_summary\_output | num\_further\_funding\_output | num\_other\_research\_output | num\_exploitation\_output | num\_dissemination\_output | num\_publications |  org\_role   | org\_region | org\_postcode | start\_year | end\_year | duration\_weeks | russell\_group | uni | number\_org | number\_uni | prop\_org | prop\_uni | total\_players | lead\_org\_russell |
| :---------------------------: | :-----------------------------------------------------------------------------------------------------------------------: | :----------: | :------------: | :---------: | :--------: | :----: | :-----: | :-----: | :------------------------: | :---------------------------------: | :----------------------------: | :-----------------------------: | :--------------------------------------: | :---------------------------------------: | :------------------------------------: | :------------------: | :--------------------------: | :---------------------------: | :--------------------------: | :-----------------------: | :------------------------: | :---------------: | :----------: | :---------: | :-----------: | :---------: | :-------: | :-------------: | :------------: | :-: | :---------: | :---------: | :-------: | :-------: | :------------: | :----------------: |
|      Cardiff University       | Resubmission: Social network analysis of the dynamic relationship between adolescent smoking behaviour and peer influence |   G0501806   |     316629     | 2006-09-01  | 2009-02-28 |  MRC   | unknown |         |             7              |                  0                  |               0                |                2                |                    0                     |                     0                     |                   0                    |          0           |              0               |               0               |              0               |             0             |             6              |         8         | COLLABORATOR |    Wales    |   CF10 3TE    |    2006     |   2009    |      130.1      |       1        |  1  |      3      |      2      |    0.6    |    0.4    |       5        |         0          |
|  Maastricht University (UM)   | Resubmission: Social network analysis of the dynamic relationship between adolescent smoking behaviour and peer influence |   G0501806   |     316629     | 2006-09-01  | 2009-02-28 |  MRC   | unknown |         |             7              |                  0                  |               0                |                2                |                    0                     |                     0                     |                   0                    |          0           |              0               |               0               |              0               |             0             |             6              |         8         | COLLABORATOR |     NA      |      NA       |    2006     |   2009    |      130.1      |       0        |  0  |      3      |      2      |    0.6    |    0.4    |       5        |         0          |
| Pennsylvania State University | Resubmission: Social network analysis of the dynamic relationship between adolescent smoking behaviour and peer influence |   G0501806   |     316629     | 2006-09-01  | 2009-02-28 |  MRC   | unknown |         |             7              |                  0                  |               0                |                2                |                    0                     |                     0                     |                   0                    |          0           |              0               |               0               |              0               |             0             |             6              |         8         | COLLABORATOR | Outside UK  |      NA       |    2006     |   2009    |      130.1      |       0        |  0  |      3      |      2      |    0.6    |    0.4    |       5        |         0          |

### Individuals

``` r
library(GtR)
library(pander)
##Example URL
url<-"https://gtr.ukri.org/projects?ref=G0501806"
```

## Impact & Publications

``` r
library(GtR)
library(pander)
##Example URL
url<-"https://gtr.ukri.org/projects?ref=G0501806"
```

## Project topic

# Networks

## Inter-organisational collaboration network

# UKRI Links & Other Information

Details on the data and research council isn’t listed directly on the
Gateway to Research website, rather is located on other UKRI sites. Here
is a list of useful links and information:

  - [Diversity
    data](https://www.ukri.org/our-work/supporting-healthy-research-and-innovation-culture/equality-diversity-and-inclusion/diversity-data/)  
  - [Decisions on competitive
    funding 2019-20](https://www.ukri.org/about-us/what-we-do/funding-data/decisions-on-competitive-funding-2019-20/)  
  - [Regional distribution of
    funding](https://www.ukri.org/about-us/what-we-do/funding-data/regional-distribution-of-funding/)  
  - [UKRI Interactive
    dashboard](https://public.tableau.com/profile/uk.research.and.innovation.ukri.#!/vizhome/ResearchfishOutputs2020/Overview)  
  - [UKRI Description](https://www.ukri.org/about-us/what-we-do/)

README
================

# GtR

This package provides a set of functions to search for UK research
council funded projects from [Gateway to
Research.](https://gtr.ukri.org/)

## Project Search

You can search for projects associated with a search term- in the
following example I will search for prjects associated with `social
network analysis`

``` r
library(GtR)

SNA_projects<-gtr_project_search("social network analysis")

library(kableExtra)
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

2021-12-31

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

## Project Extract - Organisation

## Project - individuals

## Impact & Publications

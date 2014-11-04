(* ::Package:: *)

(* ::Input:: *)
(*Needs["ErrorBarPlots`"]*)
(*dataMg={{82,1.67},{247,1.10},{358,1.09},{548,1.05},{752,1.06}};*)
(*ErdataMg={{{82,1.67},ErrorBar[1.67*8.21/100]},{{247,1.10},ErrorBar[1.10*9.43/100]},{{358,1.09},ErrorBar[1.09*8.87/100]},{{548,1.05},ErrorBar[1.05*10.07/100]},{{752,1.06},ErrorBar[1.06*10.93/100]}};*)
(*dataAl={{82,91.32},{247,94.15},{358,93.38},{548,93.46},{752,93.55}};*)
(*ErdataAl={{{82,91.32},ErrorBar[91.32*0.89/100]},{{247,94.15},ErrorBar[94.15*0.79/100]},{{358,93.38},ErrorBar[93.38*0.73/100]},{{548,93.46},ErrorBar[93.46*0.82/100]},{{752,93.55},ErrorBar[93.55*0.90/100]}};*)
(*dataCu={{82,0.83},{247,0.30},{358,0.72},{548,0.81},{752,0.50}};*)
(*ErdataCu={{{82,0.83},ErrorBar[0.83*22.00/100]},{{247,0.30},ErrorBar[0.30*57.69/100]},{{358,0.72},ErrorBar[0.72*22.57/100]},{{548,0.81},ErrorBar[0.81*27.46/100]},{{752,0.50},ErrorBar[0.50*38.58/100]}};*)
(*dataZn={{82,6.18},{247,4.45},{358,4.80},{548,4.69},{752,4.89}};*)
(*ErdataZn={{{82,6.18},ErrorBar[6.18*5.66/100]},{{247,4.45},ErrorBar[4.45*7.65/100]},{{358,4.80},ErrorBar[4.80*5.91/100]},{{548,4.69},ErrorBar[4.69*8.64/100]},{{752,4.89},ErrorBar[4.89*7.42/100]}};*)
(**)
(*pMg[x_]=Fit[dataMg,{1,x,Log[x]},x];*)
(*pMgIfStat[x_]:=If[x>82&&x<752,pMg[x]];*)
(*pAl[x_]=Fit[dataAl,{1,x,Log[x]},x];*)
(*pAlIfStat[x_]:=If[x>82&&x<752,pAl[x]];*)
(*pCu[x_]=Fit[dataCu,{1,x,Log[x]},x];*)
(*pCuIfStat[x_]:=If[x>82&&x<752,pCu[x]];*)
(*pZn[x_]=Fit[dataZn,{1,x,Log[x]},x];*)
(*pZnIfStat[x_]:=If[x>82&&x<752,pZn[x]];*)
(*gMgIfStat=Plot[pMgIfStat[x],{x,0,dataMg[[Length[dataMg],1]]},PlotRange->All,PlotStyle->{Red,Thickness[0.01]},PlotLegends->{"Mg"}];*)
(*gAlIfStat=Plot[pAlIfStat[x],{x,0,dataAl[[Length[dataAl],1]]},PlotRange->All,PlotStyle->{Brown,Thickness[0.01]},PlotLegends->{"Al"}];*)
(*gCuIfStat=Plot[pCuIfStat[x],{x,0,dataCu[[Length[dataCu],1]]},PlotRange->All,PlotStyle->{Green,Thickness[0.01]},PlotLegends->{"Cu"}];*)
(*gZnIfStat=Plot[pZnIfStat[x],{x,0,dataZn[[Length[dataZn],1]]},PlotRange->All,PlotStyle->{Black,Thickness[0.01]},PlotLegends->{"Zn"}];*)
(**)
(*ErdotsMg=ErrorListPlot[ErdataMg,PlotStyle->{PointSize[0.02]},PlotRange->All,AxesOrigin->{0,0},PlotLabel->Style["Mg",23],AxesLabel->{Style["depth, \[Micro]m",18],Style["C, %",18]},AxesStyle->Directive[12,Arrowheads[{0,0.05}]]];*)
(**)
(*ErdotsAl=ErrorListPlot[ErdataAl,PlotStyle->{PointSize[0.02]},PlotRange->All,AxesOrigin->{0,0},PlotLabel->Style["Al",23],AxesLabel->{Style["depth, \[Micro]m",18],Style["C, %",18]},AxesStyle->Directive[12,Arrowheads[{0,0.05}]]];*)
(*ErdotsCu=ErrorListPlot[ErdataCu,PlotStyle->{PointSize[0.02]},PlotRange->All,AxesOrigin->{0,0},PlotLabel->Style["Cu",23],AxesLabel->{Style["depth, \[Micro]m",18],Style["C, %",18]},AxesStyle->Directive[12,Arrowheads[{0,0.05}]]];*)
(*ErdotsZn=ErrorListPlot[ErdataZn,PlotStyle->{PointSize[0.02]},PlotRange->All,AxesOrigin->{0,0},PlotLabel->Style["Zn",23],AxesLabel->{Style["depth, \[Micro]m",18],Style["C, %",18]},AxesStyle->Directive[12,Arrowheads[{0,0.05}]]];*)
(**)
(*ErdotsMg2=ErrorListPlot[ErdataMg,PlotStyle->{PointSize[0.02]},PlotRange->All,AxesOrigin->{0,0},AxesLabel->{Style["depth, \[Micro]m",18],Style["C, %",18]},AxesStyle->Directive[12,Arrowheads[{0,0.05}]]];*)
(**)
(*ErdotsAl2=ErrorListPlot[ErdataAl,PlotStyle->{PointSize[0.02]},PlotRange->All,ColorFunction->Black,AxesOrigin->{0,0},AxesLabel->{Style["depth, \[Micro]m",18],Style["C, %",18]},AxesStyle->Directive[12,Arrowheads[{0,0.05}]]];*)
(*ErdotsCu2=ErrorListPlot[ErdataCu,PlotStyle->{PointSize[0.02]},PlotRange->All,AxesOrigin->{0,0},AxesLabel->{Style["depth, \[Micro]m",18],Style["C, %",18]},AxesStyle->Directive[12,Arrowheads[{0,0.05}]]];*)
(*ErdotsZn2=ErrorListPlot[ErdataZn,PlotStyle->{PointSize[0.02]},PlotRange->All,AxesOrigin->{0,0},AxesLabel->{Style["depth, \[Micro]m",18],Style["C, %",18]},AxesStyle->Directive[12,Arrowheads[{0,0.05}]]];*)
(**)
(*(*Show[dotsMg,gMgIfStat]*)*)
(*Show[ErdotsMg,gMgIfStat]*)
(**)
(*(*Show[dotsAl,gAlIfStat]*)*)
(*(*Show[ErdotsAl,gAlIfStat]*)*)
(**)
(*(*Show[dotsCu,gCuIfStat]*)*)
(*Show[ErdotsCu,gCuIfStat]*)
(**)
(*(*Show[dotsZn,gZnIfStat]*)*)
(*Show[ErdotsZn,gZnIfStat]*)
(*Show[ErdotsMg2,gMgIfStat,ErdotsCu2,gCuIfStat,ErdotsZn2,gZnIfStat]*)
(**)


(* ::PageBreak:: *)
(**)


ImageAssemble[{Image[CompressedData["
1:eJzt101KAzEYxvFBXXgNt95Ct5lVPUELdRmhCtJD5CS5SO6Rg7wmMxPmM/3y
qcXw/CFiJwXhRzKJT5uP1ftdVVWfj+HHav39stut928P4cPr/mu7uQ+/PMeZ
MOJDYb+uoiMkOmKiIyY6YqIjJjpioiMmOmKiIyY6YqIjpuIcvRVdK6lzQxlx
V/izxTk6I8rMpbzVjePCFKTSHL01Yv3sYbNGlbYynUJVnqOd7FsvVgdDpee+
wEpznBX2edzPS3u9ne6N096/5B1atqMTo3Iu3VzdOhqjRTcLtn2ec89VsmNa
X/rAho7rcfyd7j1w5ru0WMcTz5ZoPX53Xt8xfvUvx+W1Fqfcc27h+G86crYM
o2Ou7pzI3XPCfrdu+JGOSx07W6b3dDoulP63zt7/4lodz9FxWn+2HBpDn3Tn
ScO4/k557n28HMfbRkdMdMRER0x0xERHTHTEREdMdMRER0x0xERHTHTEREdM
dMRUMVg/dc6w8A==
"], "Byte", ColorSpace -> "RGB", Interleaving -> True],Image[CompressedData["
1:eJztmE1OwzAQRiNgwTXYcgvYJquyYN1KZWmkgoR6CJ/EF8k9fBBjK3b+6rhx
4EPI+p7kqnUmXbyMZ+w8HN53bzdVVX3c24/d/uvpdNqfX+7sj+fz5/Fwa788
2vFqh5s0BEJFtzDoFgfd4qBbHHSLg25x0C0OusVBtzjoFgfd4ijDrTZK1KZp
hlELZWfX33M9Pp8y3AZaI2vvqhZGpWS1cl3cDyjOrRBG+FwUCWmttHGiMU0t
7V0YynOrTKtEep1rZb0qo2RNt6vp3GrnzueujIjT1r2bb6+41f4Zba3HRbo1
3ptzciHX1eTOZ9KtrcdDLd7W90p1G3rVhTvnzPtedtu5nDj0/xdbB0sU63aU
a4MPNzfsC5bddvuNSc77OpPqj3Oy3LrQvxqbGLs1wz4rzPkepvvLGXmLdvvv
mbkN+efrZuhh/dVUvfUuQ7y7N3cvXLbbodcLpfoe1kdf2SeEfrj1jFG6WzPa
j83Xc8qteyY56z9GcW4jrpzDWN4tzYd6S7eOyLuaeY+fFtpJbGzPOj43TEbG
Oa4Mt7+PVjJeX+1zkivzmW4juPNF4l0E3W4n1IPLM1ikVyag2wUiNTn3nRnd
4qBbHHSLg25x0C0OusVBtzjoFgfd4qBbHHSLoyJQvgGthKhG
"], "Byte", ColorSpace -> "RGB", Interleaving -> True],Image[CompressedData["
1:eJzt1sFNwzAYhmELOLAGV7aAq3MqE7QSHF2pIKEO8U/iRbxHBjGOY9O4TUJT
PgEy31ulShufHtmx7zbb1cuVUur1Nnyt1u8Pu916/3QTfjzu35431+HmvnsS
ru5Pz76doiMkOmKiIyY6YqIjJjpioiMmOmKiIyY6YqIjpqodnfim0cUlLj7w
0t/AqtOx9dYM3Q456f/XxoZRuOpz7A21Nt5OQHWWdJyvtaafb7PrNqxrOs40
vZ6Py+s7Xlp8HN5ab5rL1n1Vjtkhu5xR9CzGh7mq/7lj3p8XOMb3QDE+vV/p
+Ocd1Q9/FnfBuuZ8HCu922bOPMfRcby8D5svIFsr0ZqOU50xJ8P6l/Tw1JH7
9WeDc+DJvAx7UWGU9qZ83nRivDHN4v2qSsdUcdbO5+uRA/pwnDiu69+Mjpjo
iImOmOiIiY6Y6IiJjpjoiImOmOiIiY6Y6IiJjpjoiEkxWB9pddau
"], "Byte", ColorSpace -> "RGB", Interleaving -> True]}]




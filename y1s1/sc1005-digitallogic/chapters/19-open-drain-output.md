Uses external pull-up resistor to make output = 1.

Open-drain outputs pull the line to logic low when the internal logic = 0, but they do not actively drive the line high when internal logic = 1.

Multiple open-drain outputs can be connected together as there will not be conflicting signals.

CMOS open-drain:

![](images/open-drain-output-01.png)

**if A=B=1, Q1 and Q2 on, Z=0, LED ON. If A=0 or B=0, LED OFF.

![](images/open-drain-output-02.png)

![](images/open-drain-output-03.png)

**Z = UVW.

Logic gates open-drain:

If any gate is logic low, it pulls the whole line to 0, then X = 0.

If all gates logic high, X = 1

![](images/open-drain-output-04.png)

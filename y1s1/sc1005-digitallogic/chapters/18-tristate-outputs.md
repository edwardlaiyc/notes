Tristate devices must have an enable input.

3 output states: 0, 1, High impedance (Hi-Z, when device is disabled).

Two or more tristate outputs can be connected together.

**If more than one output is enabled at a time, it can lead to bus contention (undefined outcome) and excessive voltage may damage the device.

Logic gates Tristate

![](images/tristate-outputs-01.png)

CMOS Tristate inverter

![](images/tristate-outputs-02.png)

CMOS Tristate buffer

![](images/tristate-outputs-03.png)

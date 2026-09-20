Odd parity

- Sender: creates extra MSB of ‘1’ or ‘0’ to make total number of ‘1’s in the data odd.
- Receiver: counts number of ‘1’s. If even, flags an error. If odd number of ‘1’s, assumes no error.

Parity method can only detect single bit error.

The underlying data transmitted might still be wrong.

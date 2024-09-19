## Hamming Decoder using Verilog Programming

This project implements a **Hamming (7, 4) Decoder** using Verilog HDL, designed to detect and correct single-bit errors in a 7-bit codeword. The Hamming code is an error-correcting code widely used in data transmission to ensure reliable communication.

#### **Overview:**
The Hamming (7,4) code encodes 4 bits of data into 7 bits by adding 3 parity bits. These parity bits are used to detect and correct single-bit errors. The decoder calculates the parity bits from the received 7-bit code and compares them with the original parity bits to identify and correct any errors.

#### **Inputs:**
- `code[6:0]`: A 7-bit codeword that contains 4 data bits (`d3, d2, d1, d0`) and 3 parity bits (`p1, p2, p4`).

#### **Outputs:**
- `data_out[3:0]`: The corrected 4-bit data output.
- `syndrome[2:0]`: A 3-bit syndrome that represents the position of an error if one exists.
- `error_detected`: A flag that indicates if an error was detected.
- `error_corrected`: A flag that indicates if an error was detected and successfully corrected.

---

### **Functions and Calculations:**

#### **1. Parity Bit Calculation:**
The Hamming code adds three parity bits (`p1`, `p2`, `p4`) to the data bits in positions 1, 2, and 4 respectively. The following equations are used to compute the parity bits:

- `p1 = d0 ^ d1 ^ d3`  
- `p2 = d0 ^ d2 ^ d3`  
- `p4 = d1 ^ d2 ^ d3`

#### **2. Syndrome Calculation:**
The syndrome helps detect the location of an error by recalculating the parity bits and comparing them with the received codeword's parity bits. The syndrome is generated using XOR operations, as shown below:

- `syndrome[0] = code[0] ^ code[2] ^ code[4] ^ code[6]` (checks parity for `p1`)
- `syndrome[1] = code[1] ^ code[2] ^ code[5] ^ code[6]` (checks parity for `p2`)
- `syndrome[2] = code[3] ^ code[4] ^ code[5] ^ code[6]` (checks parity for `p4`)

The syndrome forms a 3-bit binary number that indicates the position of the erroneous bit:
- If `syndrome = 000`, no error is detected.
- If `syndrome ≠ 000`, the binary value of the syndrome represents the position of the erroneous bit in the received codeword.

#### **3. Error Detection:**
- The decoder checks whether the syndrome is non-zero (`syndrome != 000`).
- If an error is detected (`error_detected = 1`), the bit in the position indicated by the syndrome is corrected.

#### **4. Error Correction:**
Once an error is detected, the decoder corrects the erroneous bit by flipping its value using the syndrome. The corrected data is then output.

Here is how the syndrome corresponds to bit correction:
- `syndrome = 001` → Correct `code[0]`
- `syndrome = 010` → Correct `code[1]`
- `syndrome = 011` → Correct `code[2]`
- `syndrome = 100` → Correct `code[3]`
- `syndrome = 101` → Correct `code[4]`
- `syndrome = 110` → Correct `code[5]`
- `syndrome = 111` → Correct `code[6]`

#### **5. Data Output:**
If no error is detected, the data bits are extracted directly from the codeword (`data_out = {code[6], code[5], code[4], code[0]}`). If an error is detected and corrected, the corrected bits are output.

---

### **Example:**

Let's say the original data is `1011`, and the Hamming encoder generates a codeword of `1011010` (including parity bits).

Now, suppose a transmission error flips the third bit, changing the codeword to `1001010`. The decoder would perform the following steps:
1. **Calculate Syndrome:**
   - `p1 = 0`, `p2 = 1`, `p4 = 1` → `syndrome = 011`
2. **Detect Error:**
   - Since `syndrome ≠ 000`, an error is detected at position 3 (`syndrome = 011`).
3. **Correct Error:**
   - The third bit is flipped from `0` to `1`, correcting the codeword back to `1011010`.
4. **Output Data:**
   - The corrected 4-bit data is extracted as `1011`.

---

### **Applications:**
- **Digital Communication Systems**: To correct transmission errors.
- **Memory Systems**: For error detection and correction in data storage.
- **Data Transmission**: To improve reliability in noisy communication channels.

#### **Simulation and Testing:**
This Verilog module was developed and simulated using **Xilinx Vivado 2024.1**. The testbench verifies the design by injecting errors into the codeword and observing whether the module detects and corrects them properly.

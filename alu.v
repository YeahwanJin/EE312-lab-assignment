`timescale 1ns / 100ps

module ALU(A,B,OP,C,Cout);

	input [15:0]A;
	input [15:0]B;
	input [3:0]OP;
	output [15:0]C;
	output Cout;

	//TODO
	//use condition operation
	assign C = (OP == 4'b0000) ? A + B :   // add
           (OP == 4'b0001) ? A - B :   // sub
           (OP == 4'b0010) ? A & B :   // and
           (OP == 4'b0011) ? A | B :   // or
           (OP == 4'b0100) ? ~(A & B) :   // nand
           (OP == 4'b0101) ? ~(A | B) :   // nor
           (OP == 4'b0110) ? A ^ B :   // xor
           (OP == 4'b0111) ? A ~^ B :   // xnor
           (OP == 4'b1000) ? A :   // identity
           (OP == 4'b1001) ? ~A :   // not
           (OP == 4'b1010) ? (A>>1) :   // logical right shift
           (OP == 4'b1011) ? {A[15], A[15:1]} :   // arithmetic right shift
           (OP == 4'b1100) ? {A[0], A[15:1]} :   // rotate right
           (OP == 4'b1101) ? (A<<1) :   // logical left shift
           (OP == 4'b1110) ? (A<<<1) :   // arithmetic left shift
           (OP == 4'b1111) ? {A[14:0], A[15]} :   // rotate left

		// 	(OP == 4'b1010) ? {0, A[15:1]} :   // logical right shift
        //    (OP == 4'b1011) ? {A[15], A[15:1]} :   // arithmetic right shift
        //    (OP == 4'b1100) ? {A[0], A[15:1]} :   // rotate right
        //    (OP == 4'b1101) ? {A[14:0], 0} :   // logical left shift
        //    (OP == 4'b1110) ? {A[14:0], 0} :   // arithmetic left shift
        //    (OP == 4'b1111) ? {A[14:0], A[15]} :   // rotate left
           16'd0;  // Default case

	assign Cout = (OP == 4'b0000) ? ((A[15] == B[15]) && (C[15] != A[15])) :   // add overflow: A>0, B>0 but C<0 or A<0, B<0 but C>0
                  (OP == 4'b0001) ? ((A[15] != B[15]) && (C[15] != A[15])) :   // sub overflow: A>0, B<0 but C<0 or A<0, B>0 but C>0
                  1'b0;  // default case
	
endmodule

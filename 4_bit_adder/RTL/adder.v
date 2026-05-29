module adder(
    input [3:0] a,
    input [3:0] b,
    output [3:0] s,
    output cout,
    input cin
);

wire n1,n2,n3;

fadder uut1(.a(a[0]),.b(b[0]),.s(s[0]),.cin(cin),.cout(n1));
fadder uut2(.a(a[1]),.b(b[1]),.s(s[1]),.cin(n1),.cout(n2));
fadder uut3(.a(a[2]),.b(b[2]),.s(s[2]),.cin(n2),.cout(n3));
fadder uut4(.a(a[3]),.b(b[3]),.s(s[3]),.cin(n3),.cout(cout));
endmodule


`timescale 1ns / 1ps


`define invalid 2'b00
`define sasso 2'b01
`define carta 2'b10
`define forbice 2'b11

module MorraCinese_tb();
// inputs
  reg [1:0] PRIMO;
  reg [1:0] SECONDO;
  reg INIZIA;
  reg clk;

// outputs
  wire [1:0] MANCHE;
  wire [1:0] PARTITA;

// file descriptor
  integer outputVerilog;
  integer scriptSis; 
  
  MorraCinese morracinese (
    .PRIMO(PRIMO),
    .SECONDO(SECONDO),
    .INIZIA(INIZIA),
    .clk(clk),
    .MANCHE(MANCHE),
    .PARTITA(PARTITA)
  );
  
// clock
  always #10 clk = ~clk;

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(1);
    
    // apertura file 
    outputVerilog = $fopen("output_verilog.txt", "w");
    scriptSis = $fopen("testbench.script", "w");
    
    $fdisplay(scriptSis, "read_blif FSMD.blif");
    
	clk = 1'b0; 		// inizializzazione clock
    
// PARTITA 1 // 5 MANCHE MASSIME // PAREGGIO MANCHE MASSIME RAGGIUNTE
    $display("PARTITA 1");
    INIZIA = 1'b1;
    PRIMO = 2'b00;
    SECONDO = 2'b01;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
   	#30;
        
    INIZIA = 1'b0;
    
    // vince g2 sasso carta
	PRIMO = `sasso;
    SECONDO = `carta;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
	$fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    // vince g1 sasso forbice
    PRIMO = `sasso;
    SECONDO = `forbice;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    // vince g1 forbice carta
    PRIMO = `forbice;
    SECONDO = `carta;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    // vince g2 carta forbice
    PRIMO = `carta;
    SECONDO = `forbice;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    // pareggio sasso
    PRIMO = `sasso;
    SECONDO = `sasso;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    #30;
    
// PARTITA 2 // MANCHE MASSIME 4 // VANTAGGIO DI 3
    $display("PARTITA 2");
    INIZIA = 1'b1;
    PRIMO = 2'b00;
    SECONDO = 2'b00;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);

    #30;
    
    INIZIA = 1'b0;

    //vince giocatore 2 con vantaggio di 3
    
    //vince giocatore 2 sasso carta
    PRIMO = `sasso;
    SECONDO = `carta;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
	$fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    // vince g2 carta forbice
    PRIMO = `carta;
    SECONDO = `forbice;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    // pareggio sasso
    PRIMO = `sasso;
    SECONDO = `sasso;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    // vince g2 carta forbice
    PRIMO = `carta;
    SECONDO = `forbice;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    #30;
        
// PARTITA 3 // MANCHE MASSIME 6 // VINCE G2 MANCHE MINIME RAGGIUNTE
    $display("PARTITA 3");
    INIZIA = 1'b1;
    PRIMO = 2'b00;
    SECONDO = 2'b10;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);

    #30;
    
    INIZIA = 1'b0;

    //vince g2 carta forbice
    PRIMO = `carta;
    SECONDO = `forbice;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
	$fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    // vince g1 carta sasso
    PRIMO = `carta;
    SECONDO = `sasso;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    // vince g2 sasso carta
    PRIMO = `sasso;
    SECONDO = `carta;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    // vince g2 forbice sasso
    PRIMO = `forbice;
    SECONDO = `sasso;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    

    #30;

// PARTITA 4 // MANCHE MASSIME 7 // MOSSE INVALIDE E MOSSE RIPETUTE
    $display("PARTITA 4");
    INIZIA = 1'b1;
    PRIMO = 2'b00;
    SECONDO = 2'b11;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    #30;
    
    INIZIA = 1'b0;

    //vince g1 forbica carta
    PRIMO = `forbice;
    SECONDO = `carta;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);

    //vince g2 sasso carta
    PRIMO = `sasso;
    SECONDO = `carta;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
     
    //mossa ripetuta g2 sasso carta
    PRIMO = `sasso;
    SECONDO = `carta;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);

    // vince g1 carta sasso
    PRIMO = `carta;
    SECONDO = `sasso;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);

    // mossa invalida 
    PRIMO = `invalid;
    SECONDO = `sasso;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);

    //vince g2 sasso carta
    PRIMO = `sasso;
    SECONDO = `carta;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
	$fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);

    // vince g2 carta forbice
    PRIMO = `carta;
    SECONDO = `forbice;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);

    //vince g2 sasso carta
    PRIMO = `sasso;
    SECONDO = `carta;
    #20;
    $display("PRIMO: %b SECONDO: %b MANCHE: %b PARTITA: %b\n",PRIMO,SECONDO,MANCHE,PARTITA);
    $fdisplay(scriptSis, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    $fdisplay(outputVerilog, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);



    // Fine simulazione
    #20;
    
    $fdisplay(scriptSis, "quit");

    $fclose(scriptSis);
    $fclose(outputVerilog);
	$finish;
    
    $stop;
  end

endmodule
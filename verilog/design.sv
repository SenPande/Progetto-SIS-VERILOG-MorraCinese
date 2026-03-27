module MorraCinese(
  input [1:0] PRIMO,
  input [1:0] SECONDO,
  input INIZIA,
  input clk,
  output reg [1:0] MANCHE,
  output reg [1:0] PARTITA
);
  
// dichiarazione registri del datapath
  reg [4:0] manche_max = 5'b00000;
  reg [1:0] ultima_manche = 2'b00;
  reg [1:0] ultima_mossa = 2'b00;
  reg [4:0] manche_count = 5'b00000;
  
// dichiarazione variabili
  parameter invalid = 2'b00;
  parameter sasso = 2'b01;
  parameter carta = 2'b10;
  parameter forbice = 2'b11;
  
// stati FSM
  parameter INIZIO = 3'b000;
  parameter V1P1 = 3'b001;
  parameter V1P2 = 3'b010;
  parameter V2P1 = 3'b011;
  parameter V2P2 = 3'b100;
  parameter V3P1 = 3'b101;
  parameter V3P2 = 3'b110;
  parameter FINE = 3'b111;
  
// input FSM
  reg [1:0] FLAG_MANCHE = 2'b00;			
  reg manche_minime = 1'b0;			
  reg manche_massime = 1'b0;
  
  reg [2:0] stato = 3'b000;
  reg [2:0] stato_prossimo = 3'b000;

// FSM
  always @(clk) begin : UPDATE_STATE
  	stato = stato_prossimo;
end
  
  always @(posedge clk) begin: FSM
  	if(INIZIA) begin
      	stato_prossimo = INIZIO;
      	PARTITA = 2'b00;
    end else begin
      	case (stato)
          INIZIO: begin			// stato di inizio
            case (MANCHE) 		
              
              2'b00: begin		// manche non valida
                stato_prossimo = INIZIO;
              end
              
              2'b01: begin		// vince giocatore 1
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = V1P1;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = V1P1;
                  PARTITA = 2'b00;
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b01;						// vince g1
                end
              end
                
              2'b10: begin  	// vince giocatore 2
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = V1P2;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = V1P2;
                  PARTITA = 2'b00;
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b10;						// vince g2
                end
              end
                
              2'b11: begin  	// pareggio
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = INIZIO;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = INIZIO;
                  PARTITA = 2'b00;
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b11;						// pareggio
                end
              end
            endcase
          end
          
          V1P1: begin			// vantaggio 1 g1
            case (MANCHE) 		
              
              2'b00: begin		// manche non valida
                stato_prossimo = V1P1;
              end
              
              2'b01: begin		// vince giocatore 1
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = V2P1;
                  PARTITA = 2'b00;
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = FINE;				
                  PARTITA = 2'b01;						// vince g1
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b01;						// vince g1
                end
              end
             
              2'b10: begin  	// vince giocatore 2
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = INIZIO;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = INIZIO;
                  PARTITA = 2'b00;
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b11;						// pareggio
                end
              end
               
              2'b11: begin  	// pareggio
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = V1P1;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = V1P1;
                  PARTITA = 2'b00;
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b01;						// vince g1
                end
              end
            endcase
          end
          
          V1P2: begin			// vantaggio 1 g2
            case (MANCHE) 		
              
              2'b00: begin		// manche non valida
                stato_prossimo = V1P2;
              end
         
              2'b01: begin		// vince giocatore 1
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = INIZIO;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = INIZIO;				
                  PARTITA = 2'b00;						
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b11;						// pareggio
                end
              end
              
              2'b10: begin  	// vince giocatore 2
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = V2P2;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b10;						// vince g2
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b10;						// vince g2
                end
              end
         
              2'b11: begin  	// pareggio
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = V1P2;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = V1P2;
                  PARTITA = 2'b00;
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b10;						// vince g2
                end
              end
            endcase
          end
                
          V2P1: begin			// vantaggio 2 g1
            case (MANCHE) 		
              
              2'b00: begin		// manche non valida
                stato_prossimo = V2P1;
              end
            
              2'b01: begin		// vince giocatore 1
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = V3P1;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = FINE;				
                  PARTITA = 2'b01;						// vince g1
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b01;						// vince g1
                end
              end
      	
              2'b10: begin  	// vince giocatore 2
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = V1P1;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = V1P1;
                  PARTITA = 2'b00;
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b01;						// vince g1
                end
              end
          
              2'b11: begin  	// pareggio
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = V2P1;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b01;						// vince g1
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b01;						// vince g1
                end
              end
            endcase
          end   
          
          V2P2: begin			// vantaggio 2 g1
            case (MANCHE) 		
              
              2'b00: begin		// manche non valida
                stato_prossimo = V2P2;
              end
            
              2'b01: begin		// vince giocatore 1
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = V1P2;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = V1P2;				
                  PARTITA = 2'b01;						// vince g1
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b10;						// vince g2
                end
              end

              2'b10: begin  	// vince giocatore 2
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = V3P2;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b10;						// vince g2
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b10;						// vince g2
                end
              end
  
              2'b11: begin  	// pareggio
                if(FLAG_MANCHE == 2'b00) begin			// partite minime non raggiunte
                  stato_prossimo = V2P2;
                  PARTITA = 2'b00;			
                end else if(FLAG_MANCHE == 2'b10) begin		// partite minime raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b10;						// vince g2
                end else if(FLAG_MANCHE == 2'b11) begin		// partite massima raggiunte
                  stato_prossimo = FINE;
                  PARTITA = 2'b10;						// vince g2
                end
              end
            endcase
          end   
          
          V3P1: begin			// vantaggio 3 g1
            if(MANCHE == 2'b00) begin				// manche non valida			
              stato_prossimo = V3P1;
              PARTITA = 2'b00;
            end else begin
              stato_prossimo = FINE;				
              PARTITA = 2'b01;							// vittoria g1
            end
          end
          
          V3P2: begin			// vantaggio 3 g2
            if(MANCHE == 2'b00) begin				// manche non valida			
              stato_prossimo = V3P1;
              PARTITA = 2'b00;
            end else begin
              stato_prossimo = FINE;				
              PARTITA = 2'b10;							// vittoria g2
            end
          end
        endcase
    end
  end
                                	  
// DATAPATH
  always @(posedge clk) begin: DATAPATH
    if(INIZIA) begin							// reset
      	MANCHE = 2'b00;
      	FLAG_MANCHE = 2'b00;
      	manche_max = {PRIMO, SECONDO} + 5'b00100; // numero massimo di manche
  		ultima_manche = 2'b00;					// ultima manche valida
    	ultima_mossa = 2'b00;					// ultima mossa vincente
    	manche_count = 5'b00000;						// contatore mancche giocate
      	manche_minime = 1'b0;					// flag manche minime raggiunte
      	manche_massime = 1'b0;					// flag manche massime raggiunte
    
    end else begin			
      // mossa non valida
      if(PRIMO == 2'b00 || SECONDO == 2'b00) begin
        	MANCHE = 2'b00;
      end
      
      // pareggio
      else if(PRIMO == SECONDO) begin
        	if({ultima_mossa,ultima_manche} == {PRIMO,2'b01} || {ultima_mossa,ultima_manche} == {SECONDO,2'b10}) begin
          		MANCHE = 2'b00;		// ultimo giocatore vincente ha ripetuto l'ultima mossa usata
            end
         	else begin
              	MANCHE = 2'b11;
              	ultima_manche = 2'b11;
              	ultima_mossa = 2'b00;
              	manche_count++;
            end
      end
      
      // vince giocatore 1(PRIMO)
      else if((PRIMO == sasso && SECONDO == forbice) || (PRIMO == carta && SECONDO == sasso) || (PRIMO == forbice && SECONDO == carta)) begin
        	if({ultima_mossa,ultima_manche} == {PRIMO,2'b01} || {ultima_mossa,ultima_manche} == {SECONDO,2'b10}) begin
          		MANCHE = 2'b00;		// ultimo giocatore vincente ha ripetuto l'ultima mossa usata
            end
        	else begin
              	MANCHE = 2'b01;
              	ultima_manche = 2'b01;
              	ultima_mossa = PRIMO;
              	manche_count++;
            end
      end
        	
      // vince giocatore 2(SECONDO)
      else if((PRIMO == sasso && SECONDO == carta) || (PRIMO == carta && SECONDO == forbice) || (PRIMO == forbice && SECONDO == sasso)) begin
        	if({ultima_mossa,ultima_manche} == {PRIMO,2'b01} || {ultima_mossa,ultima_manche} == {SECONDO,2'b10}) begin
          		MANCHE = 2'b00;		// ultimo giocatore vincente ha ripetuto l'ultima mossa usata
            end
        	else begin
              	MANCHE = 2'b10;
              	ultima_manche = 2'b10;
              	ultima_mossa = SECONDO;
              	manche_count++;
            end
      end
      // flag raggiungimento manche minime/massime
      if (manche_count > 3) begin
        	manche_minime = 1'b1;			// manche minime raggiunte (4)
      end
      if (manche_count == manche_max) begin
        	manche_massime = 1'b1;		// manche massime raggiunte
      end   
      FLAG_MANCHE = {manche_minime, manche_massime};		// flag che verrà data come input alla FSM
    end
    #10;
end
  
endmodule
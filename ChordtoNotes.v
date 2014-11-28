/*
* ChordtoNotes
*	chord: numerical value of chord 
*	key: numerical value of key (see note value below)
*	notes_for_chord: value of chords;
*/

module ChordtoNotes(
    input reg [3:0] chord,
    input wire [3:0] key,
    output wire [15:0] notes_for_chord);
	
	reg [3:0] note1;
	reg [3:0] note2;
	reg [3:0] note3;
	reg [3:0] note4;
	
	wire [3:0] C = 0;
	wire [3:0] CS = 1;
	wire [3:0] D = 2;
	wire [3:0] DS = 3;
	wire [3:0] E = 4; 
	wire [3:0] F = 5; 
	wire [3:0] FS = 6;
	wire [3:0] G = 7;
	wire [3:0] GS = 8;
	wire [3:0] A = 9; 
	wire [3:0] AS = 10;
	wire [3:0] B = 11;
	
	always @ (*) begin
		case (chord)
			0: begin
				note1 = 0;
				note2 = 0;
				note3 = 0;
				note4 = 0;
			end
			1: begin
				note1 = key;
				note2 = (key + 4) % 12;
				note3 = (key + 7) % 12;
				note4 = (key + 11) % 12;
			end
			2: begin 
				note1 = key + 1;
				note2 = (key + 1 + 3) % 12;
				note3 = (key + 1+ 7) % 12;
				note4 = (key + 1+ 11) % 12;
			end
			3: begin
				note1 = key + 2;
				note2 = (key + 2 + 3) % 12;
				note3 = (key + 2+ 7) % 12;
				note4 = (key + 2+ 11) % 12;
			end
			4: begin
				note1 = key + 4;
				note2 = (key + 4 + 4) % 12;
				note3 = (key + 4 + 7) % 12;
				note4 = (key + 4 + 11) % 12;
			end
			5: begin
				note1 = key + 5;
				note2 = (key + 5 + 4) % 12;
				note3 = (key + 5 + 7) % 12;
				note4 = (key + 5 + 11) % 12;
			end
			6: begin
				note1 = key + 6;
				note2 = (key + 6 + 3) % 12;
				note3 = (key + 6 + 7) % 12;
				note4 = (key + 6 + 11) % 12;
			end
			7: begin
				note1 = key + 6;
				note2 = (key + 6 + 3) % 12;
				note3 = (key + 6 + 6) % 12;
				note4 = (key + 6 + 9) % 12;				
			end
		end
	end

	notes_for_chord = note1,note2,note3,note4;
	 
endmodule

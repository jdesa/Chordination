`timescale 1ns / 1ps

/*
* Structure of Module:
* - Calculate note from frequency.
* - Calculate the four possible chords that the note can be a part of. 
* - Check which of these chords are valid.
* - Output the chords to the Voicing Module. 
*
* To Calculate Note from Frequency:
* - Find nearest match. Make sure to indicate sharp or flat depending on key. 
*
*/

/*
* Chord Suggestor
* Calculates feasible chord transitions
*
* Inputs:
* recalculate -- 1/0 indicating whether it is time to recalculate a chord or not
* key -- 12 possible keys 
*	 reg C = 0;
	 reg CS = 1;
	 reg D = 2;
	 reg DS = 3;
	 reg E = 4; 
	 reg F = 5; 
	 reg FS = 6;
	 reg G = 7;
	 reg GS = 8;
	 reg A = 9; 
	 reg AS = 10;
	 reg B = 11;
* note: One of the chords above
* 
* Outputs:
* chords: four possible chords per note, each chord has 4 notes, four bits per note = 64 bits total.
* If a chord is not valid, its spot is filled with 15's.
*/

module ChordSuggestor(
    input recalculate,
    input [3:0]key, 
	input [3:0] note,
    output[63:0] chords);

	//Chord Calculator State Machine
	reg [2:0]state; //holds the state of the chord (I, ii, iii, IV, V, vi, vii).
	
	reg [2:0]root_chord = (note - key) % 7 + 1; 
	reg [2:0]third_chord = (note - key + 5) % 7 + 1;
	reg [2:0]fifth_chord = (note - key + 3) % 7 + 1;
	reg [2:0]seventh_chord = (note - key + 1) % 7 + 1;
	
	always @ (posedge clock) begin
		//offset_passengerdoor <= passengerdoor;
		//offset_driverdoor <= driverdoor;		
		case (state)
			1: begin
			
			end
			
			2: begin
			end
			
			3: begin
			end
			
			4: begin
			end
			
			5: begin
			end
			
			6: begin
			end
			
			7: begin
			end
			
		end
	end
	 
endmodule

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

module ChordFSM(
    input recalculate,
    input reg [2:0]state; //holds the state of the chord (I, ii, iii, IV, V, vi, vii).
    input [3:0]key, 
	input [3:0] note,
    output [63:0] chords);
	/////////////////////////////////////
	/// Calculate Chords 
	/* There are four possible chords coming from one note:
	* Chord as Root 
	* Chord as Third
	* Chord as Fifth
	* Chord as Seventh
	*/
	/////////////////////////////////////
	wire [2:0]chord_as_root = (note - key) % 7 + 1; 
	wire [2:0]chord_as_third = (note - key + 5) % 7 + 1;
	wire [2:0]chord_as_fifth = (note - key + 3) % 7 + 1;
	wire [2:0]chord_as_seventh = (note - key + 1) % 7 + 1;

	//number of possible chords
	reg [2:0]chord1;
	reg [2:0]chord2;
	reg [2:0]chord3;
	reg [2:0]chord4;

	//values of chords
	reg [15:0]notes_chord1;
	reg [15:0]notes_chord2;
	reg [15:0]notes_chord3;
	reg [15:0]notes_chord4;
	
	 //Chord Calculator State Machine
	always @ (recalculate) begin
		case (state)
			1: begin
				chord1 <= chord_as_root;
				chord2 <= chord_as_third;
				chord3 <= chord_as_fifth;
				chord4 <= chord_as_seventh;
			end
			2: begin //possible transitions: 2, vii, V
				chord1 <= (chord_as_root == 2 || chord_as_root == 7 || chord_as_root == 5) ? chord_as_root: 0;
				chord2 <= (chord_as_third == 2 || chord_as_third == 7 || chord_as_third == 5) ? chord_as_third: 0;
				chord3 <= (chord_as_fifth == 2 || chord_as_fifth == 7 || chord_as_fifth == 5) ? chord_as_fifth: 0;
				chord4 <= (chord_as_seventh == 2 || chord_as_seventh == 7 || chord_as_seventh == 5) ? chord_as_seventh: 0;
			end
			3: begin
				chord1 <= (chord_as_root == 4 || chord_as_root == 3 || chord_as_root == 6 || chord_as_root == 2) ? chord_as_root: 0;
				chord2 <= (chord_as_third == 4 || chord_as_third == 3 || chord_as_third == 6 || chord_as_third == 2) ? chord_as_third: 0;
				chord3 <= (chord_as_fifth == 4 || chord_as_fifth == 3 || chord_as_fifth == 6 || chord_as_fifth == 2) ? chord_as_fifth: 0;
				chord4 <= (chord_as_seventh == 4 || chord_as_seventh == 3 || chord_as_seventh == 6 || chord_as_seventh == 2) ? chord_as_seventh: 0;
			end
			4: begin
				chord1 <= (chord_as_root == 4 || chord_as_root == 7 || chord_as_root == 5 || chord_as_root == 2) ? chord_as_root: 0;
				chord2 <= (chord_as_third == 4 || chord_as_third == 7 || chord_as_third == 5 || chord_as_third == 2) ? chord_as_third: 0;
				chord3 <= (chord_as_fifth == 4 || chord_as_fifth == 7 || chord_as_fifth == 5 || chord_as_fifth == 2) ? chord_as_fifth: 0;
				chord4 <= (chord_as_seventh == 4 || chord_as_seventh == 7 || chord_as_seventh == 5 || chord_as_seventh == 2) ? chord_as_seventh: 0;
			end
			5: begin
				chord1 <= (chord_as_root == 5 || chord_as_root == 1 || chord_as_root == 6) ? chord_as_root: 0;
				chord2 <= (chord_as_third == 5 || chord_as_third == 1 || chord_as_root == 6) ? chord_as_third: 0;
				chord3 <= (chord_as_fifth == 5 || chord_as_fifth == 1 || chord_as_root == 6) ? chord_as_fifth: 0;
				chord4 <= (chord_as_seventh == 5 || chord_as_seventh == 1 || chord_as_root == 6) ? chord_as_seventh: 0;
			end
			6: begin
				chord1 <= (chord_as_root == 2 || chord_as_root == 4 || chord_as_root == 6) ? chord_as_root: 0;
				chord2 <= (chord_as_third == 2 || chord_as_third == 4 || chord_as_third == 6) ? chord_as_third: 0;
				chord3 <= (chord_as_fifth == 2 || chord_as_fifth == 4 || chord_as_fifth == 6) ? chord_as_fifth: 0;
				chord4 <= (chord_as_seventh == 2 || chord_as_seventh == 4 || chord_as_seventh == 6) ? chord_as_seventh: 0;
			end
			7: begin
				chord1 <= (chord_as_root == 2 || chord_as_root == 4 || chord_as_root == 6) ? chord_as_root: 0;
				chord2 <= (chord_as_third == 2 || chord_as_third == 4 || chord_as_third == 6) ? chord_as_third: 0;
				chord3 <= (chord_as_fifth == 2 || chord_as_fifth == 4 || chord_as_fifth == 6) ? chord_as_fifth: 0;
				chord4 <= (chord_as_seventh == 2 || chord_as_seventh == 4 || chord_as_seventh == 6) ? chord_as_seventh: 0;
			end
			default: begin
				chord1 <= 0;
				chord2 <= 0;
				chord3 <= 0;
				chord4 <= 0;
			end
		end
	
	ChordtoNotes(chord1, key, notes_chord1);
	ChordtoNotes(chord2, key, notes_chord2);
	ChordtoNotes(chord3, key, notes_chord3);
	ChordtoNotes(chord4, key, notes_chord4);
	
	end

	chords = notes_chord1, notes_chord2, notes_chord3, notes_chord4; 

endmodule


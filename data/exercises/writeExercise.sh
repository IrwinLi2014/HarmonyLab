#!/bin/bash

echo ""
echo "*** HarmonyLab Exercise-Authoring Tool ***"
echo ""
echo "First write a PROMPT."
echo "Escape any instance of \" thus: \\\"."
echo ""
read introText
echo ""

echo "Specify the KEY. Enter as illustrated or hit return for no key:"
echo "\"bf\" for B-flat major"
echo "\"gm\" for G minor"
echo "\"a\" for A major"
echo "\"fsm\" for F-sharp minor"
echo ""
read keyInput
echo ""

key=$(echo ${keyInput} | sed -E 's/^afm$/iAb/;s/^efm$/iEb/;s/^bfm$/iBb/;s/^fm$/iF_/;s/^cm$/iC_/;s/^gm$/iG_/;s/^dm$/iD_/;s/^am$/iA_/;s/^em$/iE_/;s/^bm$/iB_/;s/^fsm$/iF#/;s/^csm$/iC#/;s/^gsm$/iG#/;s/^dsm$/iD#/;s/^asm$/iA#/;s/^cf$/jCb/;s/^gf$/jGb/;s/^df$/jDb/;s/^af$/jAb/;s/^ef$/jEb/;s/^bf$/jBb/;s/^f$/jF_/;s/^c$/jC_/;s/^g$/jG_/;s/^d$/jD_/;s/^a$/jA_/;s/^e$/jE_/;s/^b$/jB_/;s/^fs$/jF#/;s/^csm$/jC#/;s/^$/h/;')

echo "Specify the KEY SIGNATURE. (Enter \"=\" to match the key named above or, for a non-matching key signature, enter the desired number of \"#\" or \"b\".)"
echo ""
read keySignatureInput
echo ""

if [[ ${keySignatureInput} == "=" ]]; then
	keySignature=$(echo ${keyInput} | sed -E 's/^afm$/bbbbbbb/;s/^efm$/bbbbbb/;s/^bfm$/bbbbb/;s/^fm$/bbbb/;s/^cm$/bbb/;s/^gm$/bb/;s/^am$//;s/^em$/#/;s/^bm$/##/;s/^fsm$/###/;s/^csm$/####/;s/^gsm$/#####/;s/^dsm$/######/;s/^asm$/#######/;s/^cf$/bbbbbbb/;s/^gf$/bbbbbb/;s/^df$/bbbbb/;s/^af$/bbbb/;s/^ef$/bbb/;s/^bf$/bb/;s/^c$//;s/^g$/#/;s/^d$/##/;s/^a$/###/;s/^e$/####/;s/^b$/#####/;s/^fs$/######/;s/^csm$/#######/;s/^dm$/b/;s/^f$/b/;s/^h$//;')
else
	keySignature=$(echo ${keySignatureInput})
fi

echo "Enter CHORDS. Use the format illustrated, with \"x\" prefixed to notes"
echo "that the student will be expected to match without seeing them notated."
echo "(This encoding of pitch and register follows Lilypond English-language format.)"
echo ""
echo "\"<>\" to enclose each sonority (including single melodic notes)"
echo "\"c'\" for C4 (middle C), \"c''\" for C5, etc."
echo "\"c\" for C3, \"c,\" for C2, \"c,,\" for C1 etc."
echo "\"f\" for flat, \"s\" for sharp, \"ff\" for double-flat, \"ss\" for double-sharp"
echo "Example: <a, a' c'' e''> <e xgs' xb' xe''>"
echo ""
echo "N.B. As of April 2016, HarmonyLab ignores enharmonic spelling here."
echo "Authors must respect the way HarmonyLab spells pitch content in the chosen mode."
echo ""
read chordInput
echo ""

chord=$(echo "${chordInput}" | sed -E 's/x ([a-g])/x\1/g' | sed -E -f ./chordInputToChord_1.sed | sed -e ':loop' -E -f ./chordInputToChord_2.sed -e 't loop' | sed -E 's/,\]/]/g')

echo "Write some REVIEW text to show after the exercise is completed."
echo ""
read reviewText
echo ""

echo "Specify the DIRECTORY (exercise group)."
echo "To write output to current directory, enter \"x\"."
echo ""
read directory
echo ""

echo "Specify the FILENAME (exercise number)."
echo ""
read filename
echo ""

if [[ "$directory" = "x" ]]; then
	txtPath="./${filename}_archive.txt"
	jsonPath="./${filename}.json"
else
	mkdir -p ./txt/${directory}
	mkdir -p ./json/all/${directory}
	txtPath="./txt/${directory}/${filename}.txt"
	jsonPath="./json/all/${directory}/${filename}.json"
fi

echo "Choose what note names to display:"
echo "  [1] note names"
echo "  [2] scientific pitch notation"
echo "  [3] neither"
read opt1
echo ""

if [[ "$opt1" = "1" ]]; then
	note_names="true"
	scientific_pitch="false"
elif [[ "$opt1" = "2" ]]; then
	note_names="false"
	scientific_pitch="true"
elif [[ "$opt1" = "3" ]]; then
	note_names="false"
	scientific_pitch="false"
else
	echo "Failed to set note-name analysis options."
fi

echo "Choose what melodic analysis to display:"
echo "  [1] scale degrees"
echo "  [2] solfege"
echo "  [3] neither"
read opt2
echo ""

if [[ "$opt2" = "1" ]]; then
	scale_degrees="true"
	solfege="false"
elif [[ "$opt2" = "2" ]]; then
	scale_degrees="false"
	solfege="true"
elif [[ "$opt2" = "3" ]]; then
	scale_degrees="false"
	solfege="false"
else
	echo "Failed to set melodic analysis options."
fi

echo "Choose what harmonic analysis to display:"
echo "  [1] Roman numerals"
echo "  [2] intervals"
echo "  [3] neither"
echo "  [4] both"
read opt3
echo ""

if [[ "$opt3" = "1" ]]; then
	roman_numerals="true"
	intervals="false"
elif [[ "$opt3" = "2" ]]; then
	roman_numerals="false"
	intervals="true"
elif [[ "$opt3" = "3" ]]; then
	roman_numerals="false"
	intervals="false"
elif [[ "$opt3" = "4" ]]; then
	roman_numerals="true"
	intervals="true"
else
	echo "Failed to set harmonic analysis options."
fi

echo "Choose what highlights to display:"
echo "  [1] roots"
echo "  [2] tritones"
echo "  [3] neither"
echo "  [4] both"
read opt4
echo ""

if [[ "$opt4" = "1" ]]; then
	roothighlight="true"
	tritonehighlight="false"
elif [[ "$opt4" = "2" ]]; then
	roothighlight="false"
	tritonehighlight="true"
elif [[ "$opt4" = "3" ]]; then
	roothighlight="false"
	tritonehighlight="false"
elif [[ "$opt4" = "4" ]]; then
	roothighlight="true"
	tritonehighlight="true"
else
	echo "Failed to set highlight options."
fi

cat >${txtPath} <<- _EOF_
	${introText}
	${keyInput}
	${keySignatureInput}
	${chordInput}
	${reviewText}
	${directory}
	${filename}
	${opt1}
	${opt2}
	${opt3}
	${opt4}
	_EOF_

cat >${jsonPath} <<- _EOF_
	{
	  "type": "matching",
	  "introText": "$introText",
	  "keySignature": "$keySignature",
	  "key": "$key",
	  "chord": [
	$chord
	  ],
	  "reviewText": "$reviewText",
	  "analysis": {
	    "enabled": true,
	    "mode": {
	      "note_names": $note_names,
	      "scientific_pitch": $scientific_pitch,
	      "scale_degrees": $scale_degrees,
	      "solfege": $solfege,
	      "roman_numerals": $roman_numerals,
	      "intervals": $intervals
	    }
	  },
	  "highlight": {
	    "enabled": true,
	    "mode": {
	      "roothighlight": $roothighlight,
	      "tritonehighlight": $tritonehighlight
	    }
	  }
	}
	_EOF_

echo "The following json exercise file was written to"
echo "${jsonPath}"
echo ""

cat ${jsonPath}


# CREATES LILYPOND FILE FOR PROOFING AND PRINTING EXERCISES

lyKeySignature=$(echo ${keySignature} | sed -E 's/^bbbbbbb$/cf \\major/;s/^bbbbbb$/gf \\major/;s/^bbbbb$/des \\major/;s/^bbbb$/af \\major/;s/^bbb$/ef \\major/;s/^bb$/bf \\major/;s/^b$/f \\major/;s/^$/c \\major/;s/^#$/g \\major/;s/^##$/d \\major/;s/^###$/a \\major/;s/^####$/e \\major/;s/^#####$/b \\major/;s/^######$/fs \\major/;s/^#######$/cs \\major/;')

# expands x prefix to \xNote for unwritten-but-to-be-played notes
# specifies duration of whole note when unspecified in input
lyChord=$(echo ${chordInput} | sed -E 's/x/\\xNote /g;s/> *</>1 </g;s/>$/>1/g')

if [[ "$directory" = "x" ]]; then
	lyPath="./${filename}.ly"
else
	mkdir -p ./ly/${directory}
	lyPath="./ly/${directory}/${filename}.ly"
fi

cat >${lyPath} <<- _EOF_
	\version "2.18.2" \language "english" #(set-global-staff-size 18)

	\paper { paper-height = 4.25\in paper-width = 5.5\in indent = 0 system-count = 1 page-count = 1 oddFooterMarkup = \markup \tiny { Exercise preview in Lilypond for HarmonyLab json file. } }

	\markup \small \left-column { \line { ${directory} } \line { ${filename} } }

	\markup \pad-around #3 \box \pad-markup #1 \wordwrap {
	  ${introText}\strut
	}

	theKey = { \key
	  ${lyKeySignature}
	}

	lyCommands = { \clef "alto" \override Staff.StaffSymbol.line-count = #11 \override Staff.StaffSymbol.line-positions = #'(10 8 6 4 2 -2 -2 -4 -6 -8 -10) \override Staff.TimeSignature #'stencil = ##f \override Staff.BarLine #'stencil = ##f }

	\absolute { \theKey \lyCommands

	  ${lyChord}

	}

	\markup \italic \pad-around #3 \box \pad-markup #1 \wordwrap {
	  ${reviewText}\strut
	}

	\markup \small \left-column { \line \tiny { analysis options per writeExercise.sh } \line { ${key} : ${opt1}.${opt2}.${opt3}.${opt4} } }

	_EOF_

\version "2.18.2" \language "english" #(set-global-staff-size 18)

\paper { paper-height = 4.25\in paper-width = 5.5\in indent = 0 system-count = 1 page-count = 1 oddFooterMarkup = \markup \tiny { Exercise preview in Lilypond for HarmonyLab json file. } }

\markup \small \left-column { \line { x } \line { SAMPLE } }

\markup \pad-around #3 \box \pad-markup #1 \wordwrap {
  Complete the four-part progression with the simplest correct voice leading, according to the Roman-numeral analysis.\strut
}

theKey = { \key
  c \major
}

lyCommands = { \clef "alto" \override Staff.StaffSymbol.line-count = #11 \override Staff.StaffSymbol.line-positions = #'(10 8 6 4 2 -2 -2 -4 -6 -8 -10) \override Staff.TimeSignature #'stencil = ##f \override Staff.BarLine #'stencil = ##f }

\absolute { \theKey \lyCommands

  <c g' c'' e''>1 <a, \xNote a' \xNote c'' \xNote e''>1 <f, \xNote a' \xNote c'' \xNote f''>1 <g, \xNote g' \xNote b' \xNote d''>1 <c, g' c'' e''>1

}

\markup \italic \pad-around #3 \box \pad-markup #1 \wordwrap {
  Well done! Take a moment to memorize this.\strut
}

\markup \small \left-column { \line \tiny { analysis options per writeExercise.sh } \line { jC_ : 3.3.1.1 } }


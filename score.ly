% ad lib
\version "2.18.2"
#(load "swing.scm")
\include "articulate.ly"
#(set-global-staff-size 16)
% \tripletFeel 8 {

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  http://lsr.di.unimi.it/LSR/Item?id=445

%LSR by Jay Anderson.
%modyfied by Simon Albrecht on March 2014.
%=> http://lilypond.1069038.n5.nabble.com/LSR-445-error-td160662.html

#(define (octave-up m t)
 (let* ((octave (1- t))
      (new-note (ly:music-deep-copy m))
      (new-pitch (ly:make-pitch
        octave
        (ly:pitch-notename (ly:music-property m 'pitch))
        (ly:pitch-alteration (ly:music-property m 'pitch)))))
  (set! (ly:music-property new-note 'pitch) new-pitch)
  new-note))

#(define (octavize-chord elements t)
 (cond ((null? elements) elements)
     ((eq? (ly:music-property (car elements) 'name) 'NoteEvent)
       (cons (car elements)
             (cons (octave-up (car elements) t)
                   (octavize-chord (cdr elements) t))))
     (else (cons (car elements) (octavize-chord (cdr elements ) t)))))

#(define (octavize music t)
 (if (eq? (ly:music-property music 'name) 'EventChord)
       (ly:music-set-property! music 'elements (octavize-chord
(ly:music-property music 'elements) t)))
 music)

makeOctaves = #(define-music-function (parser location arg mus) (integer? ly:music?)
 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cr = \change Staff = "right"
cl = \change Staff = "left"
rhMark = \markup { 
  \path #0.1 #'((moveto -1 0)(rlineto 0 -1.5)(rlineto 0.5 0))
}

\header {
  title = "徐佳瑩 - 突然好想你"
  subtitle = "For female vocal and piano accompaniment"
  arranger = "Arranged by Benson"
}

melody-intro = \relative c {
}

melody-verse-one = \relative c' {
  \tripletFeel 8 {
    r2 r4 r8 ees\(
    c'4 c8 aes bes aes g4
    aes\) r r r8 aes\(
    des4 des8 c des c des4
    ees8 bes\) r4 r8 aes\( g aes
    f'4 f8 g bes aes~
  }
  \tuplet 3/2 { aes8 g f } ees4 \tuplet 3/2 { ees8 f4 }
  \tripletFeel 8 {
    c8\) aes\( g aes ees4 r8 ees ees des f,4 g8 aes\) r4 r4 r8
  }
}

melody-bridge-two = \relative c' {
}

melody-bridge-one = \relative c' {
}

melody-chorus-one = \relative c'' {
}

melody-episode = \relative c' {
}

melody-outro = \relative c {
}

melody = \relative c' {
  \phrasingSlurUp
	\key aes \major
	\time 4/4
  \tempo 4 = 60
  \melody-intro
  \melody-verse-one
  \melody-bridge-one
  \melody-chorus-one
  \melody-episode
  \melody-bridge-two
  \melody-chorus-one
  \melody-outro
  % \bar "|."
}

upper-intro = \relative c''' {
  R1
}

lower-intro = \relative c' {
  R1
}

upper-verse-one = \relative c' {
  \tripletFeel 8 {
    r8 g <c ees>4 <d f>8 <cis e>4.
    <c? ees?>8 g <bes ees>4 <d aes'>4 <des g>
    <aes f'>4
  }
}

upper-verse-one-b = \relative c'' {
}

lower-verse-one = \relative c {
  aes2 g4 fis
  f2 e4 ees8 a,
  bes2 a aes g4 c
}

lower-verse-one-b = \relative c' {
}

upper-bridge-one = \relative c''' {
}

lower-bridge-one = \relative c {
}

upper-chorus-one = \relative c' {
}

lower-chorus-one = \relative c' {
}

upper-episode = \relative c''' {
}

lower-episode = \relative c' {
}

upper-bridge-two = \relative c'''' {
}

lower-bridge-two = \relative c {
}

upper-chorus-two = \relative c' {
}

lower-chorus-two = \relative c' {
}

upper-outro = \relative c''' {
}

lower-outro = \relative c {
}

upper = \relative c' {
  \clef treble
  \tempo 4 = 60
  \time 4/4
  \key aes \major
  \upper-intro
  \upper-verse-one
  \upper-verse-one-b
  \upper-bridge-one
  \upper-chorus-one
  \upper-episode
  \upper-bridge-two
  \upper-chorus-two
  \upper-outro
  % \bar "|."
}

lower = \relative c {
  \clef bass
  \time 4/4
  \key aes \major
  \lower-intro
  \lower-verse-one
  \lower-verse-one-b
  \lower-bridge-one
  \lower-chorus-one
  \lower-episode
  \lower-bridge-two
  \lower-chorus-two
  \lower-outro
  % \bar "|."
}

pedals = {
  % verse one
  s2..
}

dynamics = {
}

lyricsmain = \lyricmode {
  最 怕 空 氣 突 然 安 靜
  最 怕 朋 友 突 然 的 關 心
  最 怕 回 憶 突 然 翻 滾 絞 痛 著 不 平 息
  最 怕 突 然 聽 到 你 的 消 息
}

\paper {
  page-breaking = #ly:page-turn-breaking
}
\score {
  <<
    \new Staff = "melodystaff" <<
      \set Staff.instrumentName = #"Vocal"
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \upper
        % \articulate << \upper \pedals >>
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \lower
        % \articulate << \lower \pedals >>
      }
    >>
  >>
  \layout {
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Staff \RemoveEmptyStaves
    }
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      % \Dynamics \RemoveEmptyStaves
    }
    \context {
      \Score
      % Remove all-rest staves also in the first system
      \override VerticalAxisGroup.remove-first = ##t
      % If only one non-empty staff in a system exists, still print the starting bar
      \override SystemStartBar.collapse-height = #1
    }
    \context {
      \ChordNames
      \override ChordName #'font-size = #-3
    }
  }
}

\score {
  <<
    \new Staff = "melodystaff" <<
      \set Staff.midiInstrument = #"electric guitar (clean)"
      \set Staff.instrumentName = #"Vocal"
      \set Staff.midiMinimumVolume = #0.6
      \set Staff.midiMaximumVolume = #0.7
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        % \upper
        \articulate << \upper \pedals >>
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        % \lower
        \articulate << \lower \pedals >>
      }
    >>
  >>
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}

\book {
\bookOutputSuffix "no-vocal"
\score {
  <<
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.3
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \upper \pedals >>
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.3
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \lower \pedals >>
      }
    >>
  >>
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}
}

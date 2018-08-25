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
    des4 des8 c des c~ c des
    ees8 bes\) r4 r8 aes\( g aes
    f'4 f8 g bes aes~
  }
  \tuplet 3/2 { aes8 g f } ees4
  \tripletFeel 8 {
    ees8 f c8\) aes\( g aes ees'4 r8 ees ees des f,4 g8 aes\) r4 r4
  }
}

melody-verse-two = \relative c' {
  \tripletFeel 8 {
    r8 ees8\(
    c'4 c8 aes bes aes g4
    aes\) r r r8 aes\(
    des4 des8 c des c~ c des
    ees8 bes\) r4 r8 aes\( g aes
    f'4 f8 g bes aes g f ees4
  }
  \tuplet 3/2 { ees8 f4 }
  \tripletFeel 8 {
    c8\) aes\( g aes ees'4 r8 ees ees des f,4 g8 aes\) r4 r4
  }
}

melody-verse-three = \relative c' {
  \tripletFeel 8 {
    r8 ees8\(
    c'8 b c aes
  }
  \tuplet 3/2 4 { bes8 c des }
  \tripletFeel 8 {
    c4 g8 aes\) r4 r r8 aes\(
    des4 des8 c des c~ c des
    ees8 bes\) r4 r8 aes\( g aes
    f'4 f8 g bes aes~
  }
  \tuplet 3/2 { aes8 g f }
  \tripletFeel 8 {
    ees8 ees f c8\) r aes\( g aes ees'4 r8 ees ees des
  }
  \tuplet 3/2 4 { r8 c' c bes( aes4)\) }
  r4 r4
}

melody-verse-four = \relative c' {
  \tripletFeel 8 {
    r8 ees8\(
    c'4 c8 aes bes aes g4
    aes\) r r r8 aes\(
    des4 des8 c des c~ c des
    ees8 bes\) r4 r8 aes\( g aes
    f'4 f8 g bes aes~
  }
  \tuplet 3/2 { aes8 g f } ees4
  \tripletFeel 8 {
    ees8 f c8\) aes\( g aes ees'4 r8 ees ees des f,4 g8 aes\) r4
  }

  \tripletFeel 8 {
    r8 aes\( g aes
    f'4 f8 g bes aes~
  }
  \tuplet 3/2 { aes8 g f } ees4 \tuplet 3/2 4 { ees8 f c\) }
  \tripletFeel 8 {
     r8 aes\( g aes ees'4 r8 ees ees des f,4 g8 aes\) r4 r4
  }
}
melody-bridge = \relative c''' {
  r2 aes4 bes
  \tuplet 3/2 4 {
    r4 c16 c c8 r aes16 aes aes8 r f16 f f4 c'8
    r4 bes16 bes bes8 r bes16 bes
    bes4 des8 c4 g8
  }
  aes4
  \tuplet 3/2 4 {
    f8 f g
  }
  \tripletFeel 8 {
    aes f g aes c bes
  }
  \tuplet 3/2 4 { bes8 aes c~ }
  \tripletFeel 8 {
    c bes bes aes c bes bes aes bes4
  }
}

melody-chorus-one = \relative c'' {
  \tripletFeel 8 {
    f8 g aes4 c8 bes r4
    aes8 bes ees,4 bes'8 aes r4
    f8 g aes4 c bes4. aes8 c4 r r
    f,8 g aes4 c8 bes r4
    ees8 bes des c~
  }
  \tuplet 3/2 4 { c8 bes c bes( aes) r }
  \tripletFeel 8 {
    f8 g aes4 c bes4 aes8 aes
  }
  r2 r4
}
melody-chorus-two = \relative c'' {
  \tripletFeel 8 {
    f8 g aes4 c8 bes r4
    aes8 bes ees,4 bes'8 aes r4
    f8 g aes4 c bes4. aes8 c4 r r
    f,8 g aes4 c8 bes r4
    ees8 bes des c~
  }
  \tuplet 3/2 4 { c8 bes c bes( aes) r }
  \tripletFeel 8 {
    f8 g aes4 c bes4 aes8 aes
  }
  r1
}
melody-chorus-three = \relative c'' {
  \tripletFeel 8 {
    f8 g aes4 c8 bes r4
    aes8 bes ees,4 bes'8 aes r4
    f8 g aes4 c bes4. aes8 c4 r r
    f,8 g aes4 c8 bes r4
    ees8 bes des c~
  }
  \tuplet 3/2 4 { c8 bes c bes( aes) r }
  \tripletFeel 8 {
    f8 g aes4 c bes4 aes8 aes
  }
  r2 r4
}
melody-outro = \relative c {
}

melody = \relative c' {
  \phrasingSlurUp
	\key aes \major
	\time 4/4
  \tempo 4 = 72
  \melody-intro
  \melody-verse-one
  \melody-verse-two
  \melody-chorus-one
  \melody-verse-three
  \melody-chorus-two
  \melody-bridge
  \melody-chorus-three
  \melody-verse-four
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
    <aes f'>2 <f des' ees>
  }
  \tuplet 3/2 4 { r8 des' ees f aes ces } <bes fes des>4 <aes ges>
  <f c>4 \tuplet 3/2 4 { aes8 g ees } <fes ces>4~ <g fes ces>
  <ees bes>4 \tuplet 3/2 4 { c'8 bes aes } <a ees>2
  \tuplet 3/2 4 { ees'8 des c bes aes f } <aes fes>2
  \tuplet 3/2 4 { aes8 bes c des bes ges }
  \tripletFeel 8 { <bes c>8 fes } <aes bes>4
}

upper-verse-one-b = \relative c' {
  \tripletFeel 8 {
    r8 g <c ees>4 <d f>8 <cis e>4.
    <d ees?>8 f <c' ees,>8 b16 bes <d, aes'>4 <des g>
    <aes f'>2 <f des' ees>
  }
  \tuplet 3/2 4 { r8 f' c' des ees f } <bes, fes des>4 <aes ges>
  <f c>4 \tuplet 3/2 4 { c'8 des f } <fes ces>4~ <g fes ces>
  <ees bes>4 \tuplet 3/2 4 { c8 des ees } <a, ees>2
  \tuplet 3/2 4 { r8 g aes bes c des } <des aes fes>4 <c g ees>
  \tripletFeel 8 {
    r8 ees 
  }
  \tuplet 3/2 4 { <g c,>8 ees c }
  << { \tuplet 3/2 4 { des8 ees f } } \\ { fes,4 } >>
  <ees a c>4
}

lower-verse-one = \relative c {
  aes2 \tripletFeel 8 { g8 fis~ } fis4
  f2 e4 ees
  bes'2 a aes g4 d'
  des?2 des c f,
  bes2 ees, aes2 d,4 ees
}

lower-verse-one-b = \relative c {
  aes2 \tripletFeel 8 { g8 fis~ } fis4
  f2 e4 ees
  bes'2 a aes g4 d'
  des?2 des c f,
  bes2 ees, aes2 ges4 c
}

upper-chorus-one = \relative c'' {
  << {
    \tuplet 3/2 4 {
      \repeat unfold 4 { c8 bes c }
      \repeat unfold 4 { bes8 aes bes }
      \repeat unfold 3 { aes8 g aes } ces8 bes aes
      aes8 g aes aes g aes
    }
  } \\ {
    f2 fes ees ees des d c
  } >>
  \tuplet 3/2 4 { aes'8 bes c des ges e }
  << {
    \tuplet 3/2 4 {
      \repeat unfold 4 { f8 g f }
      \stemNeutral
      ees8 f ees des ees des c des c c des c
    }
    \stemUp
    r4 \ottava #1
    \tuplet 3/2 4 { ges''8 bes des }
    \ottava #0
    r4 \ottava #1
    \tuplet 3/2 4 { b8 g ees }
    \ottava #0
  } \\ {
    c,2 ces s1 c2 c
  } >>
  s1
}

lower-chorus-one = \relative c {
  des4 \tuplet 3/2 4 { aes'8 c f }
  des,4 \tuplet 3/2 4 { aes'8 bes fes' }
  c,4 \tuplet 3/2 4 { aes'8 bes ees
  ces, ees ges ces des ees }
  bes,4 \tuplet 3/2 4 { des'8 aes f }
  e4 ges,
  aes4 \tuplet 3/2 4 { d8 ees aes } ges2
  \set fingeringOrientations = #'(left)
  << { r4 \tuplet 3/2 4 { aes8 c <f \finger \rhMark> } fes2 } \\ { des,1 } >>
  \clef treble \tuplet 3/2 4 { g8 f' bes fis, e' aes f,4 ees'8 } aes4
  \clef bass
  <e, d'>2 <ees des'>
  \stemDown 
  \tuplet 3/2 4 { aes8 ees' \cr g \stemNeutral aes bes c } aes'2 \cl
}

upper-chorus-two = \relative c' {
}
upper-chorus-two = \upper-chorus-one

lower-chorus-two = \relative c' {
}
lower-chorus-two = \lower-chorus-one

upper-bridge = \relative c'' {
  r2 <c d ges aes>4 <ees ges bes>
  \tuplet 3/2 4 { r8 c des f4 a8 aes4 c,8 f e ees }
  \tuplet 3/2 4 { r8 c des f4 a8 f des ces } <c aes e>4
  << { \tuplet 3/2 4 { r4 e'8 c4 aes8 } } \\ { <aes, f c>2 } >>
  \tuplet 3/2 4 { \acciaccatura g'16 <bes des>4 f8 des4 ces8 }
  \tuplet 3/2 4 {
    <f bes,>4 fes,8
    <ees' ces>4 f,8
    <f' bes,>4 ges,8
    <ees' ces>4 g,8
    <f' bes,>4 aes,8
    <ees' ces>4 beses8
  }
  <fes' bes,>4 r
}

lower-bridge = \relative c {
  r2 c4 ces
  \clef treble
  << {
    \tuplet 3/2 4 { r4 a''8~ } a4
    \tuplet 3/2 4 { r4 g8~ } g4
    r4
    \tuplet 3/2 4 { f4 des8 }
  } \\ {
    bes2 a aes
  } >>
  g4 \clef bass << { bes4 } \\ { \tuplet 3/2 4 { c,4 c,8 } } >>
  des2 d ees1~ ees2. r4
}

upper-chorus-three = \upper-chorus-one
lower-chorus-three = \lower-chorus-one
upper-verse-three = \upper-verse-one-b
upper-verse-four = \upper-verse-one-b
lower-verse-three = \lower-verse-one-b
lower-verse-four = \lower-verse-one-b
upper-outro = \relative c''' {
}

lower-outro = \relative c {
}

upper = \relative c' {
  \clef treble
  \tempo 4 = 72
  \time 4/4
  \key aes \major
  \upper-intro
  \upper-verse-one
  \upper-verse-one-b
  \upper-chorus-one
  \upper-verse-three
  \upper-chorus-two
  \upper-bridge
  \upper-chorus-three
  \upper-verse-four
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
  \lower-chorus-one
  \lower-verse-three
  \lower-chorus-two
  \lower-bridge
  \lower-chorus-three
  \lower-verse-four
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
  想 念 如 果 會 有 聲 音
  不 願 那 是 悲 傷 的 哭 泣
  事 到 如 今 終 於 讓 自 己 屬 於 我 自 己
  只 剩 眼 淚 還 騙 不 過 自 己

  突 然 好 想 你
  你 會 在 哪 裡 過 得 快 樂 或 委 屈
  突 然 好 想 你
  突 然 鋒 利 的 回 憶
  突 然 模 糊 的 眼 睛

  我 們 像 一 首 最 美 麗 的 歌 曲
  變 成 兩 部 悲 傷 的 電 影
  為 什 麼 你 帶 我 走 過 最 難 忘 的 旅 行
  然 後 留 下 最 痛 的 紀 念 品

  突 然 好 想 你
  你 會 在 哪 裡 過 得 快 樂 或 委 屈
  突 然 好 想 你
  突 然 鋒 利 的 回 憶
  突 然 模 糊 的 眼 睛

  我 們 那 麼 甜 那 麼 美 那 麼 相 信
  那 麼 瘋 那 麼 熱 烈 的 曾 經
  為 何 我 們 還 是 要 奔 向
  各 自 的 幸 福 和 遺 憾 中 老 去

  突 然 好 想 你
  你 會 在 哪 裡 過 得 快 樂 或 委 屈

  突 然 好 想 你
  突 然 鋒 利 的 回 憶
  突 然 模 糊 的 眼 睛

  最 怕 空 氣 突 然 安 靜
  最 怕 朋 友 突 然 的 關 心
  最 怕 回 憶 突 然 翻 滾 絞 痛 著 不 平 息
  最 怕 突 然 聽 到 你 的 消 息

  最 怕 此 生 已 經 決 心 自 己 過 沒 有 你
  卻 又 突 然 聽 到 你 的 消 息
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
% This file is part of openLilyLib,                                           %
%                      ===========                                            %
% the community library project for GNU LilyPond                              %
% (https://github.com/openlilylib)                                            %
%              -----------                                                    %
%                                                                             %
% Package: grob-tools                                                         %
%          ==========                                                         %
%                                                                             %
% openLilyLib is free software: you can redistribute it and/or modify         %
% it under the terms of the GNU General Public License as published by        %
% the Free Software Foundation, either version 3 of the License, or           %
% (at your option) any later version.                                         %
%                                                                             %
% openLilyLib is distributed in the hope that it will be useful,              %
% but WITHOUT ANY WARRANTY; without even the implied warranty of              %
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               %
% GNU General Public License for more details.                                %
%                                                                             %
% You should have received a copy of the GNU General Public License           %
% along with openLilyLib. If not, see <http://www.gnu.org/licenses/>.         %
%                                                                             %
% openLilyLib is maintained by Urs Liska, ul@openlilylib.org                  %
% and others.                                                                 %
%       Copyright Urs Liska, 2019                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\include "../grob/module.ily"

% Determine the position of a grob relative to the system,
% either in direction X or Y.
% NOTE: This gan only be used in an after-line-breaking or stencil callback
#(define (oll:grob-system-position grob direction)
   (let ((sys (ly:grob-system grob)))
     (ly:grob-relative-coordinate grob sys direction)))

#(define (oll:grob-system-elements grob)
   "Return a list with all elements belonging to the grob's system."
   (ly:grob-array->list
    (ly:grob-object
     (ly:grob-system grob)
     'elements)))

#(define (oll:grob-system-elements-by-type grob type)
   (let ((elts (oll:grob-system-elements grob)))
     (filter (lambda (obj) (not (null? obj)))
             (map (lambda (elt)
                    (if (grob-type? elt type)
                        elt '()))
               elts))))

#(define (oll:system-starters-width grob)
   "Return the width of the items starting the staff (clef, key, time).
    Used for generating siblings of broken curves       (objs (grob::all-objects sys))
       (elts (ly:grob-array->list (ly:grob-object sys 'elements)))"
   (let*
    ((sys (ly:grob-system grob))
     (elts (oll:grob-system-elements grob))
     (col (first (oll:grob-system-elements-by-type grob 'NonMusicalPaperColumn)))
     (col-ext (ly:grob-property col 'X-extent))
     )
    ;; The first NonMusicalPaperColumn alway starts at 0.0
    ;; so we can simply take the cdr
    (cdr col-ext)))


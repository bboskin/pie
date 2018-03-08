#lang scribble/manual

@(require (for-label (only-meta-in 0 pie-a-let-mode))
          racket/sandbox scribble/example
          (for-syntax racket/base syntax/parse))

@(define ev
   (parameterize ([sandbox-output 'string]
                  [sandbox-error-output 'string])
     (make-evaluator 'pie-a-let-mode)))

@(define-syntax (pie stx)
   (syntax-parse stx
     [(_ e ...)
      (syntax/loc stx
        (racket e ...))]))

@title{The Pie à-let-mode Reference}
@author{Andrew M. Kent}



@defmodule[pie-a-let-mode #:lang]{Pie à-let-mode is a
 little fork of
 @link["https://docs.racket-lang.org/pie/index.html?q=pie"]{
  Pie}--the little language with dependent types that
 accompanies @hyperlink["http://thelittletyper.com"]{@emph{
   The Little Typer}}--which adds the @pie[let] and
 @pie[equal] forms. All other forms are identical to Pie;
 consult the documentation for Pie for more information on
 the rest of the language. }

@table-of-contents[]

@section{Pie à-let-mode Specific Expressions}

@defform[#:kind "local bindings"
         (let ([id id-expr] ...) expr)]{
 Binds @pie[id-expr] to @pie[id] for any proceeding bindings
 and for the body @pie[expr]. i.e. acts like Racket's
 @pie[let*]. This form is checked in synthesis mode.}

@defform[#:kind "equational rewriting"
         (equal type term clause ...+)
         #:grammar
         [(clause (code:line #:by proof term))]]{
 Allows for simple equational rewriting.

 @tt{(equal X term1 #:by proof term2)} is equivalent to
 @tt{(the (= X term1 term2) proof)}.
 
 @tt{(equal X term1 #:by proof term2 clause ...+)}
 is equivalent to @tt{(trans (the (= X term1 term2) proof)
                             (equal X term2 clause ...))}}
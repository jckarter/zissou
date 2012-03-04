USING: assocs audio.gadget audio.loader fry gpu.demos.raytrace
images.viewer io io.directories io.styles kernel math sequences
ui ui.gadgets.worlds ui.tools.listener wolfram-alpha namespaces ;
IN: zissou

CONSTANT: title-style
    H{ { font-name "Futura" } { font-size 86 } }

CONSTANT: header-style
    H{ { font-name "Futura" } { font-size 48 } }

CONSTANT: bullet-style
    H{ { font-name "Palatino" } { font-size 27 } }

: zoom ( n -- )
    [ listener-gadget? ] find-window set-world-scale ;

: header. ( header -- )
    header-style format nl ;

: bullet. ( bullet -- )
    bullet-style format nl ;

: title. ( -- )
    nl
    nl
    "FACTOR" title-style format nl
    "POSTMORTEM" header. nl
    "github.com/jckarter/zissou" bullet.
    nl
    nl ;

: (slide.) ( header bullets -- )
    [ header. nl ]
    [ [ "• " prepend bullet. nl ] each ] bi* ;

: load-dir ( dir loader: ( filename -- resource ) -- resources )
    '[ [ @ ] map ] with-directory-files ; inline

CONSTANT: slides {
    "Background" {
        "begun by Slava Pestov in 2004"
        "postfix syntax, static dataflow"
        "native code compiler"
        "interactive, reflective environment"
    }
    "What's good" {
        "interactivity"
        "native integration"
        "performance"
        "explorable internals"
        "batteries included"
    }
        "Interactivity" {
            "perfect code reloading"
            "developer tools"
            "rich UI"
        }
        "Native integration" {
            "standalone deployment"
            "foreign function interface"
            "process library"
            "advanced OS features"
        }
        "Performance" {
            "ffi + compiler support for C types"
            "\"special style\"—use C semantics, get C performance"
            "specialized container types for packed data"
            "support GC- and manual-managed buffers"
        }
        "Explorable internals" {
            "mostly implemented in factor"
            "lots of metadata"
            "UI code navigation"
            "query functions"
            "compiler test functions"
        }
    "What sucks" {
        "concatenative syntax"
        "reader macros"
        "reinvented wheels"
        "concurrency-ignorant"
        "change without migration"
        "too many batteries"
    }
        "Concatenative" {
            "concise sometimes, but..."
            "hard to write, harder to read"
            "point-free is brittle"
            "named variables can be more concise"
        }
        "Reader macros" {
            "conceptually simple and flexible, but..."
            "forgetful"
            "not composable"
            "difficult to make new syntax first-class"
            "there are better approaches"
        }
        "Reinvented wheels" {
            "custom UI could be WebKit"
            "custom compiler could be LLVM, JVM"
            "custom mux could be libuv"
        }
        "Concurrency issues" {
            "parallelism can't be retrofitted"
            "fundamental protocols are too eager, imperative"
            "shared-everything"
        }
        "Change without migration" {
            "change is good, you aren't java..."
            "but too much change chases away users"
            "change things, but make it easy to migrate"
            "see gofix, clang -Wc++11-compat, etc."
        }
        "Too many batteries" {
            "including the world binds a small community"
            "also limits the size of the community"
            "too much code intimidates new users"
            "uneven code quality gives bad impressions"
            "package management is a necessity"
        }
    "The End" {
        "jckarter/zissou@master:references.md"
    }
}

: slide. ( n -- )
    2 * dup 1 + [ slides nth ] bi@ (slide.) ;

SYMBOL: slide-number
slide-number [ -1 ] initialize

: reset. ( -- )
    -1 slide-number set-global ;

: next. ( -- )
    slide-number [ 1 + dup slide. ] change-global ;

: repeat. ( -- )
    slide-number get-global slide. ;

: back. ( -- )
    slide-number [ 1 - dup slide. ] change-global ;

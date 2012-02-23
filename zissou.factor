USING: assocs audio.gadget audio.loader fry images.viewer io
io.directories io.styles kernel sequences ;
IN: zissou

CONSTANT: title-style
    H{ { font-name "Futura" } { font-size 96 } }

CONSTANT: header-style
    H{ { font-name "Futura" } { font-size 48 } }

CONSTANT: bullet-style
    H{ { font-name "Palatino" } { font-size 28 } }

: title ( -- )
    "FACTOR" title-style format nl ;

: slide ( header bullets -- )
    [ header-style format nl nl ]
    [ [ "• " prepend bullet-style format nl nl ] each ] bi* ;

: load-dir ( dir loader: ( filename -- resource ) -- resources )
    '[ [ dup @ ] H{ } map>assoc ] with-directory-files ; inline

# Do not edit this file - Generated by Perlito 7.0
use v5;
use utf8;
use strict;
use warnings;
no warnings ('redefine', 'once', 'void', 'uninitialized', 'misc', 'recursion');
use Perlito::Perl5::Runtime;
use Perlito::Perl5::Prelude;
our $MATCH = Perlito::Match->new();
{
package GLOBAL;
    sub new { shift; bless { @_ }, "GLOBAL" }

    # use v6 
;
    {
    package Perlito::Lisp::LexicalBlock;
        sub new { shift; bless { @_ }, "Perlito::Lisp::LexicalBlock" }
        sub block { $_[0]->{block} };
        sub emit_lisp {
            my $self = $_[0];
            (my  $List_block = bless [], 'ARRAY');
            for ( @{(defined $self->{block} ? $self->{block} : ($self->{block} ||= bless([], 'ARRAY')))} ) {
                if (defined($_)) {
                    push( @{$List_block}, $_ )
                }
            };
            if (!(((defined $self->{block} ? $self->{block} : ($self->{block} ||= bless([], 'ARRAY')))))) {
                return scalar ('nil')
            };
            ((my  $str) = '');
            ((my  $has_my_decl) = 0);
            ((my  $my_decl) = '');
            ((my  $my_ignore) = '');
            (my  $Hash_decl_seen = bless {}, 'HASH');
            for my $decl ( @{(defined $self->{block} ? $self->{block} : ($self->{block} ||= bless([], 'ARRAY')))} ) {
                if ((Main::isa($decl, 'Decl') && (($decl->decl() eq 'my')))) {
                    ((my  $var_name) = ($decl->var())->emit_lisp());
                    if (!(($Hash_decl_seen->{$var_name}))) {
                        ($has_my_decl = 1);
                        ($my_decl = ($my_decl . Decl::emit_lisp_initializer($decl->var())));
                        ($my_ignore = ($my_ignore . '(declare (ignorable ' . $var_name . ('))' . chr(10))));
                        ($Hash_decl_seen->{$var_name} = 1)
                    }
                };
                if (((Main::isa($decl, 'Bind') && Main::isa(($decl->parameters()), 'Decl')) && ((($decl->parameters())->decl() eq 'my')))) {
                    ((my  $var_name) = (($decl->parameters())->var())->emit_lisp());
                    if (!(($Hash_decl_seen->{$var_name}))) {
                        ($has_my_decl = 1);
                        ($my_decl = ($my_decl . Decl::emit_lisp_initializer(($decl->parameters())->var())));
                        ($my_ignore = ($my_ignore . '(declare (ignorable ' . $var_name . ('))' . chr(10))));
                        ($Hash_decl_seen->{$var_name} = 1)
                    }
                }
            };
            if ($has_my_decl) {
                ($str = ($str . '(let (' . $my_decl . (')' . chr(10)) . $my_ignore))
            }
            else {
                ($str = ($str . '(progn '))
            };
            for my $decl ( @{(defined $self->{block} ? $self->{block} : ($self->{block} ||= bless([], 'ARRAY')))} ) {
                if ((!(((Main::isa($decl, 'Decl') && (($decl->decl() eq 'my'))))))) {
                    ($str = ($str . ($decl)->emit_lisp()))
                }
            };
            return scalar (($str . ')'))
        }
    }

;
    {
    package CompUnit;
        sub new { shift; bless { @_ }, "CompUnit" }
        sub attributes { $_[0]->{attributes} };
        sub methods { $_[0]->{methods} };
        sub emit_lisp {
            my $self = $_[0];
            ((my  $class_name) = Main::to_lisp_namespace($self->{name}));
            ((my  $str) = (chr(59) . chr(59) . ' class ' . $self->{name} . (chr(10))));
            ((my  $has_my_decl) = 0);
            ((my  $my_decl) = '');
            ((my  $my_ignore) = '');
            (my  $Hash_decl_seen = bless {}, 'HASH');
            for my $decl ( @{(defined $self->{body} ? $self->{body} : ($self->{body} ||= bless([], 'ARRAY')))} ) {
                if ((Main::isa($decl, 'Decl') && (($decl->decl() eq 'my')))) {
                    ((my  $var_name) = ($decl->var())->emit_lisp());
                    if (!(($Hash_decl_seen->{$var_name}))) {
                        ($has_my_decl = 1);
                        ($my_decl = ($my_decl . Decl::emit_lisp_initializer($decl->var())));
                        ($my_ignore = ($my_ignore . '(declare (ignorable ' . $var_name . ('))' . chr(10))));
                        ($Hash_decl_seen->{$var_name} = 1)
                    }
                };
                if (((Main::isa($decl, 'Bind') && Main::isa(($decl->parameters()), 'Decl')) && ((($decl->parameters())->decl() eq 'my')))) {
                    ((my  $var_name) = (($decl->parameters())->var())->emit_lisp());
                    if (!(($Hash_decl_seen->{$var_name}))) {
                        ($has_my_decl = 1);
                        ($my_decl = ($my_decl . Decl::emit_lisp_initializer(($decl->parameters())->var())));
                        ($my_ignore = ($my_ignore . '(declare (ignorable ' . $var_name . ('))' . chr(10))));
                        ($Hash_decl_seen->{$var_name} = 1)
                    }
                }
            };
            if ($has_my_decl) {
                ($str = ($str . '(let (' . $my_decl . (')' . chr(10)) . $my_ignore))
            };
            ((my  $dumper) = '');
            for my $decl ( @{(defined $self->{body} ? $self->{body} : ($self->{body} ||= bless([], 'ARRAY')))} ) {
                if ((Main::isa($decl, 'Decl') && (($decl->decl() eq 'has')))) {
                    ((my  $accessor_name) = ($decl->var())->name());
                    ($dumper = ($dumper . '(let ((m (make-instance ' . chr(39) . 'mp-Pair))) ' . '(setf (sv-key m) ' . chr(34) . Main::lisp_escape_string($accessor_name) . chr(34) . ') ' . '(setf (sv-value m) (' . Main::to_lisp_identifier($accessor_name) . ' self)) m) '))
                };
                if (Main::isa($decl, 'Method')) {
                    ((my  $sig) = $decl->sig());
                    ((my  $invocant) = $sig->invocant());
                    ((my  $pos) = $sig->positional());
                    ((my  $str_specific) = ('(' . $invocant->emit_lisp() . ' ' . $class_name . ')'));
                    ((my  $str_optionals) = '');
                    ((my  $ignorable) = '');
                    for my $field ( @{($pos)} ) {
                        ($str_optionals = ($str_optionals . ' ' . $field->emit_lisp()));
                        ($ignorable = ($ignorable . (chr(10)) . '  (declare (ignorable ' . $field->emit_lisp() . ('))')))
                    };
                    if (($str_optionals)) {
                        ($str_specific = ($str_specific . ' ' . chr(38) . 'optional' . $str_optionals))
                    };
                    ((my  $block) = Perlito::Lisp::LexicalBlock->new(('block' => $decl->block())));
                    ($str = ($str . chr(59) . chr(59) . ' method ' . $decl->name() . (chr(10)) . '(defmethod ' . Main::to_lisp_identifier($decl->name()) . ' (' . $str_specific . ')' . $ignorable . (chr(10)) . '  (block mp6-function' . (chr(10)) . '    ' . $block->emit_lisp() . ('))' . chr(10))))
                };
                if (Main::isa($decl, 'Sub')) {
                    ((my  $pos) = ($decl->sig())->positional());
                    (my  $param);
                    ((my  $ignorable) = '');
                    if (($pos)) {
                        for my $field ( @{($pos)} ) {
                            ($param = ($param . $field->emit_lisp() . ' '));
                            ($ignorable = ($ignorable . (chr(10)) . '  (declare (ignorable ' . $field->emit_lisp() . ('))')))
                        }
                    };
                    ((my  $sig) = '');
                    if ($param) {
                        ($sig = (chr(38) . 'optional ' . $param))
                    };
                    ((my  $block) = Perlito::Lisp::LexicalBlock->new(('block' => $decl->block())));
                    ($str = ($str . '(defmethod ' . $class_name . '-' . Main::to_lisp_identifier($decl->name()) . ' (' . $sig . ')' . $ignorable . (chr(10)) . '  (block mp6-function ' . $block->emit_lisp() . '))' . (chr(10)) . '(in-package ' . $class_name . ')' . (chr(10)) . '  (defun ' . Main::to_lisp_identifier($decl->name()) . ' (' . $sig . ')' . (chr(10)) . '    (mp-Main::' . $class_name . '-' . Main::to_lisp_identifier($decl->name()) . ' ' . $param . '))' . (chr(10)) . '(in-package mp-Main)' . (chr(10))))
                }
            };
            if (($self->{name} ne 'Pair')) {
                ($str = ($str . '(defmethod sv-perl ((self ' . $class_name . '))' . (chr(10)) . '  (mp-Main-sv-lisp_dump_object ' . chr(34) . Main::lisp_escape_string($self->{name}) . chr(34) . ' (list ' . $dumper . ')))' . (chr(10)) . (chr(10))))
            };
            ($str = ($str . '(defun run-' . $class_name . ' ()' . (chr(10))));
            for my $decl ( @{(defined $self->{body} ? $self->{body} : ($self->{body} ||= bless([], 'ARRAY')))} ) {
                if ((((!(((Main::isa($decl, 'Decl') && (((($decl->decl() eq 'has')) || (($decl->decl() eq 'my')))))))) && (!((Main::isa($decl, 'Method'))))) && (!((Main::isa($decl, 'Sub')))))) {
                    ($str = ($str . ($decl)->emit_lisp() . (chr(10))))
                }
            };
            ($str = ($str . ')' . (chr(10))));
            if ($has_my_decl) {
                ($str = ($str . ')'))
            };
            ($str = ($str . (chr(10)) . (chr(10))))
        };
        sub emit_lisp_program {
            my $comp_units = $_[0];
            ((my  $str) = '');
            (my  $Hash_unit_seen = bless {}, 'HASH');
            (my  $List_tmp_comp_unit = bless [], 'ARRAY');
            for my $comp_unit ( @{(($comp_units))} ) {
                ((my  $name) = $comp_unit->name());
                if ($Hash_unit_seen->{$name}) {
                    for my $stmt ( @{(($comp_unit->body()))} ) {
                        push( @{($Hash_unit_seen->{$name})->body()}, $stmt )
                    }
                }
                else {
                    ($Hash_unit_seen->{$name} = $comp_unit);
                    push( @{$List_tmp_comp_unit}, $comp_unit )
                }
            };
            ($comp_units = $List_tmp_comp_unit);
            for my $comp_unit ( @{(($comp_units))} ) {
                for my $stmt ( @{(($comp_unit->body()))} ) {
                    if (Main::isa($stmt, 'Method')) {
                        (($comp_unit->methods())->{$stmt->name()} = $stmt)
                    };
                    if ((Main::isa($stmt, 'Decl') && (($stmt->decl() eq 'has')))) {
                        (($comp_unit->attributes())->{($stmt->var())->name()} = $stmt)
                    }
                }
            };
            for my $comp_unit ( @{(($comp_units))} ) {
                ((my  $class_name) = Main::to_lisp_namespace($comp_unit->name()));
                if (($class_name ne 'mp-Main')) {
                    ($str = ($str . '(defpackage ' . $class_name . (chr(10)) . '  (:use common-lisp mp-Main))' . (chr(10))))
                };
                ($str = ($str . '(if (not (ignore-errors (find-class ' . chr(39) . $class_name . ')))' . (chr(10)) . '  (defclass ' . $class_name . ' () ()))' . (chr(10))));
                ($str = ($str . '(let (x)' . (chr(10)) . '  (setq x (make-instance ' . chr(39) . $class_name . ('))' . chr(10)) . '  (defun proto-' . $class_name . ' () x))' . (chr(10))));
                for my $decl ( @{(($comp_unit->body()))} ) {
                    if ((Main::isa($decl, 'Decl') && (($decl->decl() eq 'has')))) {
                        ((my  $accessor_name) = ($decl->var())->name());
                        ($str = ($str . chr(59) . chr(59) . ' has ' . chr(36) . '.' . $accessor_name . (chr(10)) . '(let ((new-slots (list (list :name ' . chr(39) . Main::to_lisp_identifier($accessor_name) . chr(10) . '  :readers ' . chr(39) . '(' . Main::to_lisp_identifier($accessor_name) . ')' . chr(10) . '  :writers ' . chr(39) . '((setf ' . Main::to_lisp_identifier($accessor_name) . '))' . chr(10) . '  :initform ' . chr(39) . '(sv-undef)' . chr(10) . '  :initfunction (constantly (sv-undef))))))' . chr(10) . '(dolist (slot-defn (sb-mop:class-direct-slots (find-class ' . chr(39) . $class_name . ')))' . chr(10) . '(push (list :name (sb-mop:slot-definition-name slot-defn)' . chr(10) . '  :readers (sb-mop:slot-definition-readers slot-defn)' . chr(10) . '  :writers (sb-mop:slot-definition-writers slot-defn)' . chr(10) . '  :initform (sb-mop:slot-definition-initform slot-defn)' . chr(10) . '  :initfunction (sb-mop:slot-definition-initfunction slot-defn))' . chr(10) . 'new-slots))' . chr(10) . '(sb-mop:ensure-class ' . chr(39) . $class_name . ' :direct-slots new-slots))' . (chr(10) . chr(10))))
                    };
                    if (Main::isa($decl, 'Method')) {
                        ((my  $sig) = $decl->sig());
                        ((my  $invocant) = $sig->invocant());
                        ((my  $pos) = $sig->positional());
                        ((my  $str_generic) = $invocant->emit_lisp());
                        ((my  $str_optionals) = '');
                        for my $field ( @{($pos)} ) {
                            ($str_optionals = ($str_optionals . ' ' . $field->emit_lisp()))
                        };
                        if (($str_optionals)) {
                            ($str_generic = ($str_generic . ' ' . chr(38) . 'optional' . $str_optionals))
                        };
                        ($str = ($str . chr(59) . chr(59) . ' method ' . $decl->name() . (chr(10)) . '(if (not (ignore-errors (find-method ' . chr(39) . Main::to_lisp_identifier($decl->name()) . ' () ())))' . chr(10) . '  (defgeneric ' . Main::to_lisp_identifier($decl->name()) . ' (' . $str_generic . ')' . (chr(10)) . '      (:documentation ' . chr(34) . 'a method' . chr(34) . ')))' . (chr(10))))
                    };
                    if (Main::isa($decl, 'Sub')) {
                        ((my  $pos) = ($decl->sig())->positional());
                        (my  $param);
                        if (($pos)) {
                            for my $field ( @{($pos)} ) {
                                ($param = ($param . $field->emit_lisp() . ' '))
                            }
                        };
                        ((my  $sig) = '');
                        if ($param) {
                            ($sig = (chr(38) . 'optional ' . $param))
                        };
                        ($str = ($str . chr(59) . chr(59) . ' sub ' . $decl->name() . (chr(10)) . '(if (not (ignore-errors (find-method ' . chr(39) . $class_name . '-' . Main::to_lisp_identifier($decl->name()) . ' () ())))' . chr(10) . '  (defgeneric ' . $class_name . '-' . Main::to_lisp_identifier($decl->name()) . ' (' . $sig . ')' . (chr(10)) . '      (:documentation ' . chr(34) . 'a method' . chr(34) . ')))' . (chr(10))))
                    }
                }
            };
            for my $comp_unit ( @{(($comp_units))} ) {
                ($str = ($str . $comp_unit->emit_lisp() . (chr(10))))
            };
            ($str = ($str . ('(defun compiler-main ()' . chr(10)) . ('  (progn' . chr(10)) . ('    (init-argv)')));
            for my $comp_unit ( @{(($comp_units))} ) {
                ($str = ($str . (chr(10) . '    (run-') . Main::to_lisp_namespace($comp_unit->name()) . (')')))
            };
            ($str = ($str . ('))' . chr(10))));
            return scalar ($str)
        }
    }

;
    {
    package Val::Int;
        sub new { shift; bless { @_ }, "Val::Int" }
        sub emit_lisp {
            my $self = $_[0];
            $self->{int}
        }
    }

;
    {
    package Val::Bit;
        sub new { shift; bless { @_ }, "Val::Bit" }
        sub emit_lisp {
            my $self = $_[0];
            ($self->{bit} ? 'T' : 'nil')
        }
    }

;
    {
    package Val::Num;
        sub new { shift; bless { @_ }, "Val::Num" }
        sub emit_lisp {
            my $self = $_[0];
            $self->{num}
        }
    }

;
    {
    package Val::Buf;
        sub new { shift; bless { @_ }, "Val::Buf" }
        sub emit_lisp {
            my $self = $_[0];
            (chr(34) . Main::lisp_escape_string($self->{buf}) . chr(34))
        }
    }

;
    {
    package Val::Undef;
        sub new { shift; bless { @_ }, "Val::Undef" }
        sub emit_lisp {
            my $self = $_[0];
            '(sv-undef)'
        }
    }

;
    {
    package Lit::Array;
        sub new { shift; bless { @_ }, "Lit::Array" }
        sub emit_lisp {
            my $self = $_[0];
            ((my  $ast) = $self->expand_interpolation());
            return scalar ($ast->emit_lisp())
        }
    }

;
    {
    package Lit::Hash;
        sub new { shift; bless { @_ }, "Lit::Hash" }
        sub emit_lisp {
            my $self = $_[0];
            ((my  $ast) = $self->expand_interpolation());
            return scalar ($ast->emit_lisp())
        }
    }

;
    {
    package Index;
        sub new { shift; bless { @_ }, "Index" }
        sub emit_lisp {
            my $self = $_[0];
            return scalar (('(mp-Main::sv-array-index ' . $self->{obj}->emit_lisp() . ' ' . $self->{index_exp}->emit_lisp() . ')'))
        }
    }

;
    {
    package Lookup;
        sub new { shift; bless { @_ }, "Lookup" }
        sub emit_lisp {
            my $self = $_[0];
            return scalar (('(mp-Main::sv-hash-lookup ' . $self->{index_exp}->emit_lisp() . ' ' . $self->{obj}->emit_lisp() . ')'))
        }
    }

;
    {
    package Var;
        sub new { shift; bless { @_ }, "Var" }
        sub emit_lisp {
            my $self = $_[0];
            ((my  $ns) = '');
            if ($self->{namespace}) {
                ($ns = (Main::to_lisp_namespace($self->{namespace}) . '-'))
            }
            else {
                if ((((($self->{sigil} eq chr(64))) && (($self->{twigil} eq '*'))) && (($self->{name} eq 'ARGS')))) {
                    return scalar ('*mp6-args*')
                }
            };
            ((($self->{twigil} eq '.')) ? (('(' . Main::to_lisp_identifier($self->{name}) . ' sv-self)')) : (((($self->{name} eq chr(47))) ? (Main::to_lisp_identifier('MATCH')) : (($ns . Main::to_lisp_identifier($self->{name}))))))
        }
    }

;
    {
    package Bind;
        sub new { shift; bless { @_ }, "Bind" }
        sub parameters { $_[0]->{parameters} };
        sub arguments { $_[0]->{arguments} };
        sub emit_lisp {
            my $self = $_[0];
            if ((Main::isa($self->{parameters}, 'Decl') && (($self->{parameters}->decl() eq 'my')))) {
                return scalar (('(setf ' . ($self->{parameters}->var())->emit_lisp() . ' ' . $self->{arguments}->emit_lisp() . ')'))
            };
            ('(setf ' . $self->{parameters}->emit_lisp() . ' ' . $self->{arguments}->emit_lisp() . ')')
        }
    }

;
    {
    package Proto;
        sub new { shift; bless { @_ }, "Proto" }
        sub emit_lisp {
            my $self = $_[0];
            ('(proto-' . Main::to_lisp_namespace($self->{name}) . ')')
        }
    }

;
    {
    package Call;
        sub new { shift; bless { @_ }, "Call" }
        sub emit_lisp {
            my $self = $_[0];
            ((my  $arguments) = Main::join(([ map { $_->emit_lisp() } @{( (defined $self->{arguments} ? $self->{arguments} : ($self->{arguments} ||= bless([], 'ARRAY'))) )} ]), ' '));
            ((my  $invocant) = $self->{invocant}->emit_lisp());
            if (($invocant eq '(proto-mp-self)')) {
                ($invocant = 'sv-self')
            };
            if (($self->{method} eq 'isa')) {
                if (((((defined $self->{arguments} ? $self->{arguments} : ($self->{arguments} ||= bless([], 'ARRAY')))->[0])->buf()) eq 'Str')) {
                    return scalar (('(typep ' . $invocant . ' ' . chr(39) . 'string)'))
                };
                return scalar (('(typep ' . $invocant . ' ' . chr(39) . Main::to_lisp_namespace(((defined $self->{arguments} ? $self->{arguments} : ($self->{arguments} ||= bless([], 'ARRAY')))->[0])->buf()) . ')'))
            };
            if (($self->{method} eq 'chars')) {
                if (($self->{hyper})) {
                    die(('not implemented'))
                }
                else {
                    return scalar (('(length ' . $invocant . ')'))
                }
            };
            if (((($self->{method} eq 'yaml')) || (($self->{method} eq 'say')))) {
                if (($self->{hyper})) {
                    return scalar (('[ map ' . chr(123) . ' ' . $self->{method} . '( ' . chr(36) . '_, ' . ', ' . $arguments . ')' . ' ' . chr(125) . ' ' . chr(64) . chr(123) . ' ' . $invocant . ' ' . chr(125) . ' ]'))
                }
                else {
                    return scalar (('(' . $self->{method} . ' ' . $invocant . ' ' . $arguments . ')'))
                }
            };
            ((my  $meth) = (Main::to_lisp_identifier($self->{method}) . ' '));
            if (($self->{method} eq 'postcircumfix:<( )>')) {
                return scalar (('(funcall ' . $invocant . ' ' . $arguments . ')'))
            };
            if (($self->{hyper})) {
                return scalar (('(map ' . chr(39) . 'vector ' . chr(35) . chr(39) . '(lambda (c) (' . $meth . ' c)) ' . $invocant . ')'))
            }
            else {
                return scalar (('(' . $meth . $invocant . ' ' . $arguments . ')'))
            }
        }
    }

;
    {
    package Apply;
        sub new { shift; bless { @_ }, "Apply" }
        sub emit_lisp {
            my $self = $_[0];
            ((my  $ns) = '');
            if ($self->{namespace}) {
                ($ns = (Main::to_lisp_namespace($self->{namespace}) . '-'))
            };
            ((my  $code) = ($ns . $self->{code}));
            if (($code eq 'infix:<' . chr(126) . '>')) {
                return scalar (('(concatenate ' . chr(39) . 'string (sv-string ' . ((defined $self->{arguments} ? $self->{arguments} : ($self->{arguments} ||= bless([], 'ARRAY')))->[0])->emit_lisp() . ') (sv-string ' . ((defined $self->{arguments} ? $self->{arguments} : ($self->{arguments} ||= bless([], 'ARRAY')))->[1])->emit_lisp() . '))'))
            };
            if (($code eq 'ternary:<' . chr(63) . chr(63) . ' ' . chr(33) . chr(33) . '>')) {
                return scalar (('(if (sv-bool ' . ((defined $self->{arguments} ? $self->{arguments} : ($self->{arguments} ||= bless([], 'ARRAY')))->[0])->emit_lisp() . ') ' . ((defined $self->{arguments} ? $self->{arguments} : ($self->{arguments} ||= bless([], 'ARRAY')))->[1])->emit_lisp() . ' ' . ((defined $self->{arguments} ? $self->{arguments} : ($self->{arguments} ||= bless([], 'ARRAY')))->[2])->emit_lisp() . ')'))
            };
            ((my  $args) = '');
            if ((defined $self->{arguments} ? $self->{arguments} : ($self->{arguments} ||= bless([], 'ARRAY')))) {
                ($args = Main::join(([ map { $_->emit_lisp() } @{( (defined $self->{arguments} ? $self->{arguments} : ($self->{arguments} ||= bless([], 'ARRAY'))) )} ]), ' '))
            };
            if (($code eq 'self')) {
                return scalar ('sv-self')
            };
            if (($code eq 'False')) {
                return scalar ('nil')
            };
            if (($code eq 'True')) {
                return scalar ('T')
            };
            if (($code eq 'make')) {
                return scalar (('(setf (sv-capture sv-MATCH) ' . $args . ')'))
            };
            if (($code eq 'substr')) {
                return scalar (('(sv-substr ' . $args . ')'))
            };
            if (($code eq 'say')) {
                return scalar (('(mp-Main::sv-say (list ' . $args . '))'))
            };
            if (($code eq 'print')) {
                return scalar (('(mp-Main::sv-print (list ' . $args . '))'))
            };
            if (($code eq 'warn')) {
                return scalar (('(write-line (format nil ' . chr(34) . chr(126) . chr(123) . chr(126) . 'a' . chr(126) . chr(125) . chr(34) . ' (list ' . $args . ')) *error-output*)'))
            };
            if (($code eq 'die')) {
                return scalar (('(progn (write-line (format nil ' . chr(34) . chr(126) . chr(123) . chr(126) . 'a' . chr(126) . chr(125) . chr(34) . ' (list ' . $args . ')) *error-output*) (sb-ext:quit))'))
            };
            if (($code eq 'array')) {
                return scalar ($args)
            };
            if (($code eq 'exists')) {
                ((my  $arg) = (defined $self->{arguments} ? $self->{arguments} : ($self->{arguments} ||= bless([], 'ARRAY')))->[0]);
                if (Main::isa($arg, 'Lookup')) {
                    return scalar (('(nth-value 1 ' . $arg->emit_lisp() . ')'))
                }
            };
            if (($code eq 'list:<' . chr(126) . '>')) {
                return scalar (('(sv-string ' . $args . ')'))
            };
            if (($code eq 'prefix:<' . chr(33) . '>')) {
                return scalar (('(not (sv-bool ' . $args . '))'))
            };
            if (($code eq 'prefix:<' . chr(63) . '>')) {
                return scalar (('(sv-bool ' . $args . ')'))
            };
            if (($code eq 'prefix:<' . chr(36) . '>')) {
                return scalar (('(sv-scalar ' . $args . ')'))
            };
            if (($code eq 'prefix:<' . chr(64) . '>')) {
                return scalar ($args)
            };
            if (($code eq 'prefix:<' . chr(37) . '>')) {
                return scalar ($args)
            };
            if (($code eq 'infix:<+>')) {
                return scalar (('(sv-add ' . $args . ')'))
            };
            if (($code eq 'infix:<->')) {
                return scalar (('(sv-sub ' . $args . ')'))
            };
            if (($code eq 'infix:<*>')) {
                return scalar (('(sv-mul ' . $args . ')'))
            };
            if (($code eq 'infix:<' . chr(47) . '>')) {
                return scalar (('(sv-div ' . $args . ')'))
            };
            if (($code eq 'infix:<>>')) {
                return scalar (('(sv-numeric-bigger ' . $args . ')'))
            };
            if (($code eq 'infix:<<>')) {
                return scalar (('(sv-numeric-smaller ' . $args . ')'))
            };
            if (($code eq 'infix:<>' . chr(61) . '>')) {
                return scalar (('(sv-numeric-bigger-equal ' . $args . ')'))
            };
            if (($code eq 'infix:<<' . chr(61) . '>')) {
                return scalar (('(sv-numeric-smaller-equal ' . $args . ')'))
            };
            if (($code eq 'infix:<' . chr(61) . chr(61) . '>')) {
                return scalar (('(sv-numeric-equal ' . $args . ')'))
            };
            if (($code eq 'infix:<' . chr(33) . chr(61) . '>')) {
                return scalar (('(not (sv-numeric-equal ' . $args . '))'))
            };
            if (($code eq 'infix:<' . chr(38) . chr(38) . '>')) {
                return scalar (('(sv-and ' . $args . ')'))
            };
            if (($code eq 'infix:<' . chr(124) . chr(124) . '>')) {
                return scalar (('(sv-or ' . $args . ')'))
            };
            if (($code eq 'infix:<eq>')) {
                return scalar (('(sv-eq ' . $args . ')'))
            };
            if (($code eq 'infix:<ne>')) {
                return scalar (('(not (sv-eq ' . $args . '))'))
            };
            if (($code eq 'circumfix:<( )>')) {
                return scalar ($args)
            };
            return scalar (('(' . $ns . Main::to_lisp_identifier($self->{code}) . ' ' . $args . ')'))
        }
    }

;
    {
    package Return;
        sub new { shift; bless { @_ }, "Return" }
        sub emit_lisp {
            my $self = $_[0];
            return scalar (('(return-from mp6-function ' . $self->{result}->emit_lisp() . ')'))
        }
    }

;
    {
    package If;
        sub new { shift; bless { @_ }, "If" }
        sub emit_lisp {
            my $self = $_[0];
            ((my  $block1) = Perlito::Lisp::LexicalBlock->new(('block' => $self->{body}->stmts())));
            if ($self->{otherwise}) {
                ((my  $block2) = Perlito::Lisp::LexicalBlock->new(('block' => $self->{otherwise}->stmts())));
                return scalar (('(if (sv-bool ' . $self->{cond}->emit_lisp() . ') ' . $block1->emit_lisp() . ' ' . $block2->emit_lisp() . ')'))
            }
            else {
                return scalar (('(if (sv-bool ' . $self->{cond}->emit_lisp() . ') ' . $block1->emit_lisp() . ')'))
            }
        }
    }

;
    {
    package For;
        sub new { shift; bless { @_ }, "For" }
        sub emit_lisp {
            my $self = $_[0];
            ((my  $cond) = $self->{cond});
            ((my  $block) = Perlito::Lisp::LexicalBlock->new(('block' => (defined $self->{body} ? $self->{body} : ($self->{body} ||= bless([], 'ARRAY'))))));
            if ((Main::isa($cond, 'Var') && ($cond->sigil() eq chr(64)))) {
                ($cond = Apply->new(('code' => 'prefix:<' . chr(64) . '>'), ('arguments' => do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, $cond );
    $List_a
})))
            };
            ('(loop for ' . $self->{topic}->emit_lisp() . ' across ' . $cond->emit_lisp() . ' do ' . $block->emit_lisp() . ')')
        }
    }

;
    {
    package While;
        sub new { shift; bless { @_ }, "While" }
        sub emit_lisp {
            my $self = $_[0];
            ((my  $List_body = bless [], 'ARRAY') = (defined $self->{body} ? $self->{body} : ($self->{body} ||= bless([], 'ARRAY'))));
            if ($self->{continue}) {
                push( @{$List_body}, $self->{continue} )
            };
            ('(progn ' . (($self->{init} ? ($self->{init}->emit_lisp() . ' ') : '')) . '(loop while (sv-bool ' . $self->{cond}->emit_lisp() . ') do ' . (Perlito::Lisp::LexicalBlock->new(('block' => $List_body)))->emit_lisp() . '))')
        }
    }

;
    {
    package Decl;
        sub new { shift; bless { @_ }, "Decl" }
        sub emit_lisp {
            my $self = $_[0];
            ((my  $decl) = $self->{decl});
            ((my  $name) = $self->{var}->name());
            ((($decl eq 'has')) ? (('sub ' . $name . ' ' . chr(123) . ' ' . chr(64) . '_ ' . chr(61) . chr(61) . ' 1 ' . chr(63) . ' ( ' . chr(36) . '_[0]->' . chr(123) . $name . chr(125) . ' ) ' . ': ( ' . chr(36) . '_[0]->' . chr(123) . $name . chr(125) . ' ' . chr(61) . ' ' . chr(36) . '_[1] ) ' . chr(125))) : ($self->{decl} . ' ' . $self->{type} . ' ' . $self->{var}->emit_lisp()))
        };
        sub emit_lisp_initializer {
            my $decl = $_[0];
            if (($decl->sigil() eq chr(37))) {
                return scalar (('(' . $decl->emit_lisp() . ' (make-hash-table :test ' . chr(39) . 'equal))'))
            }
            else {
                if (($decl->sigil() eq chr(64))) {
                    return scalar (('(' . $decl->emit_lisp() . ' (make-array 0 :fill-pointer t :adjustable t))'))
                }
                else {
                    return scalar (('(' . $decl->emit_lisp() . ' (sv-undef))'))
                }
            }
        }
    }

;
    {
    package Sig;
        sub new { shift; bless { @_ }, "Sig" }
        sub emit_lisp {
            my $self = $_[0];
            ' print ' . chr(39) . 'Signature - TODO' . chr(39) . chr(59) . ' die ' . chr(39) . 'Signature - TODO' . chr(39) . chr(59) . ' '
        }
    }

;
    {
    package Method;
        sub new { shift; bless { @_ }, "Method" }
        sub emit_lisp {
            my $self = $_[0];

        }
    }

;
    {
    package Sub;
        sub new { shift; bless { @_ }, "Sub" }
        sub emit_lisp {
            my $self = $_[0];
            ((my  $sig) = $self->{sig});
            ((my  $pos) = $sig->positional());
            ((my  $block) = Perlito::Lisp::LexicalBlock->new(('block' => (defined $self->{block} ? $self->{block} : ($self->{block} ||= bless([], 'ARRAY'))))));
            (my  $str);
            if (($pos)) {
                for my $field ( @{($pos)} ) {
                    ($str = ($str . $field->emit_lisp() . ' '))
                }
            };
            if ($str) {
                ($str = (chr(38) . 'optional ' . $str))
            };
            if ($self->{name}) {
                ('(defun ' . Main::to_lisp_identifier($self->{name}) . ' (' . $str . ')' . (chr(10)) . '  (block mp6-function ' . $block->emit_lisp() . '))' . (chr(10)))
            }
            else {
                ('(lambda ' . $self->{name} . ' (' . $str . ')' . (chr(10)) . '  (block mp6-function ' . $block->emit_lisp() . '))' . (chr(10)))
            }
        }
    }

;
    {
    package Do;
        sub new { shift; bless { @_ }, "Do" }
        sub emit_lisp {
            my $self = $_[0];
            ((my  $block) = Perlito::Lisp::LexicalBlock->new(('block' => (defined $self->{block} ? $self->{block} : ($self->{block} ||= bless([], 'ARRAY'))))));
            return scalar ($block->emit_lisp())
        }
    }

;
    {
    package Use;
        sub new { shift; bless { @_ }, "Use" }
        sub emit_lisp {
            my $self = $_[0];
            (chr(10) . chr(59) . chr(59) . ' use ' . Main::to_lisp_namespace($self->{mod}) . (chr(10)))
        }
    }


}

1;

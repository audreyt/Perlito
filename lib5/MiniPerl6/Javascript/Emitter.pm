# Do not edit this file - Generated by MiniPerl6 4.1
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
our $MATCH = MiniPerl6::Match->new();
{
package MiniPerl6::Javascript::LexicalBlock;
sub new { shift; bless { @_ }, "MiniPerl6::Javascript::LexicalBlock" }
sub block { $_[0]->{block} };
sub needs_return { $_[0]->{needs_return} };
sub top_level { $_[0]->{top_level} };
sub emit_javascript { my $self = $_[0]; if (@{$self->{block}}) {  } else { return('null') }; (my  $str = ''); for my $decl ( @{$self->{block}} ) { if ((Main::isa($decl, 'Decl') && ($decl->decl() eq 'my'))) { ($str = $str . $decl->emit_javascript_init()) } else {  };if ((Main::isa($decl, 'Bind') && (Main::isa($decl->parameters(), 'Decl') && ($decl->parameters()->decl() eq 'my')))) { ($str = $str . 'var ' . $decl->parameters()->var()->emit_javascript() . ';') } else {  } }; my  $last_statement; if ($self->{needs_return}) { ($last_statement = pop( @{$self->{block}} )) } else {  }; for my $decl ( @{$self->{block}} ) { if ((Main::isa($decl, 'Decl') && ($decl->decl() eq 'my'))) {  } else { ($str = $str . $decl->emit_javascript() . ';') } }; if (($self->{needs_return} && $last_statement)) { if (Main::isa($last_statement, 'If')) { (my  $cond = $last_statement->cond());(my  $body = $last_statement->body());(my  $otherwise = $last_statement->otherwise());if ((Main::isa($cond, 'Apply') && ($cond->code() eq 'prefix:<!>'))) { ($cond = $cond->arguments()->[0]);($body = $last_statement->otherwise());($otherwise = $last_statement->body()) } else {  };if ((Main::isa($cond, 'Var') && ($cond->sigil() eq '@'))) { ($cond = Apply->new( 'code' => 'prefix:<@>','arguments' => [$cond], )) } else {  };($body = MiniPerl6::Javascript::LexicalBlock->new( 'block' => $body,'needs_return' => 1, ));($otherwise = MiniPerl6::Javascript::LexicalBlock->new( 'block' => $otherwise,'needs_return' => 1, ));($str = $str . 'if ( f_bool(' . $cond->emit_javascript() . ') ) { ' . $body->emit_javascript() . ' } else { ' . $otherwise->emit_javascript() . ' }') } else { if ((Main::isa($last_statement, 'Return') || Main::isa($last_statement, 'For'))) { ($str = $str . $last_statement->emit_javascript()) } else { ($str = $str . 'return(' . $last_statement->emit_javascript() . ')') } } } else {  }; if ($self->{top_level}) { ($str = 'try { ' . $str . ' } catch(err) { ' . 'if ( err instanceof Error ) { ' . 'throw(err) ' . '} ' . 'else { ' . 'return(err) ' . '} ' . '} ') } else {  }; return($str) }
}

{
package CompUnit;
sub new { shift; bless { @_ }, "CompUnit" }
sub name { $_[0]->{name} };
sub attributes { $_[0]->{attributes} };
sub methods { $_[0]->{methods} };
sub body { $_[0]->{body} };
sub emit_javascript { my $self = $_[0]; (my  $class_name = Main::to_javascript_namespace($self->{name})); (my  $str = '// class ' . $self->{name} . Main->newline() . 'if (typeof ' . $class_name . ' != \'object\') {' . Main->newline()); ($str = $str . '  ' . $class_name . ' = function() {};' . Main->newline() . '  ' . $class_name . ' = new ' . $class_name . ';' . Main->newline()); ($str = $str . '  ' . $class_name . '.f_isa = function (s) { return s == \'' . $self->{name} . '\' };' . Main->newline() . '  ' . $class_name . '.f_perl = function () { return \'' . $self->{name} . '.new(\' + Main._dump(this) + \')\' };' . Main->newline()); ($str = $str . '}' . Main->newline() . '(function () {' . Main->newline() . '  var v__NAMESPACE = ' . $class_name . ';' . '
'); for my $decl ( @{$self->{body}} ) { if ((Main::isa($decl, 'Decl') && ($decl->decl() eq 'my'))) { ($str = $str . $decl->emit_javascript_init()) } else {  };if ((Main::isa($decl, 'Bind') && (Main::isa($decl->parameters(), 'Decl') && ($decl->parameters()->decl() eq 'my')))) { ($str = $str . '  var ' . $decl->parameters()->var()->emit_javascript() . ';' . Main->newline()) } else {  } }; for my $decl ( @{$self->{body}} ) { if ((Main::isa($decl, 'Decl') && ($decl->decl() eq 'has'))) { ($str = $str . '  // accessor ' . $decl->var()->name() . Main->newline());($str = $str . '  ' . $class_name . '.v_' . $decl->var()->name() . ' = null;' . Main->newline());($str = $str . '  ' . $class_name . '.f_' . $decl->var()->name() . ' = function () { return this.v_' . $decl->var()->name() . ' }' . Main->newline()) } else {  };if (Main::isa($decl, 'Method')) { (my  $sig = $decl->sig());(my  $pos = $sig->positional());(my  $invocant = $sig->invocant());(my  $block = MiniPerl6::Javascript::LexicalBlock->new( 'block' => $decl->block(),'needs_return' => 1,'top_level' => 1, ));($str = $str . '  // method ' . $decl->name() . Main->newline() . '  ' . $class_name . '.f_' . $decl->name());($str = $str . ' = function (' . Main::join([ map { $_->emit_javascript() } @{$pos} ], ', ') . ') {' . Main->newline() . '    var ' . $invocant->emit_javascript() . ' = this;' . Main->newline());($str = $str . '    ' . $block->emit_javascript() . Main->newline() . '  }' . Main->newline());($str = $str . '  ' . $class_name . '.f_' . $decl->name() . ';  // v8 bug workaround' . Main->newline()) } else {  };if (Main::isa($decl, 'Sub')) { (my  $sig = $decl->sig());(my  $pos = $sig->positional());(my  $block = MiniPerl6::Javascript::LexicalBlock->new( 'block' => $decl->block(),'needs_return' => 1,'top_level' => 1, ));($str = $str . '  // sub ' . $decl->name() . Main->newline() . '  ' . $class_name . '.f_' . $decl->name());($str = $str . ' = function (' . Main::join([ map { $_->emit_javascript() } @{$pos} ], ', ') . ') {' . Main->newline() . '    ' . $block->emit_javascript() . Main->newline());($str = $str . '  }' . Main->newline()) } else {  } }; for my $decl ( @{$self->{body}} ) { if ((((Main::isa($decl, 'Decl') && (($decl->decl() eq 'has') || ($decl->decl() eq 'my'))) ? 0 : 1) && ((Main::isa($decl, 'Method') ? 0 : 1) && (Main::isa($decl, 'Sub') ? 0 : 1)))) { ($str = $str . $decl->emit_javascript() . ';') } else {  } }; ($str = $str . '}' . ')();' . Main->newline()) }
}

{
package Val::Int;
sub new { shift; bless { @_ }, "Val::Int" }
sub int { $_[0]->{int} };
sub emit_javascript { my $self = $_[0]; $self->{int} }
}

{
package Val::Bit;
sub new { shift; bless { @_ }, "Val::Bit" }
sub bit { $_[0]->{bit} };
sub emit_javascript { my $self = $_[0]; $self->{bit} }
}

{
package Val::Num;
sub new { shift; bless { @_ }, "Val::Num" }
sub num { $_[0]->{num} };
sub emit_javascript { my $self = $_[0]; $self->{num} }
}

{
package Val::Buf;
sub new { shift; bless { @_ }, "Val::Buf" }
sub buf { $_[0]->{buf} };
sub emit_javascript { my $self = $_[0]; '"' . Main::javascript_escape_string($self->{buf}) . '"' }
}

{
package Val::Undef;
sub new { shift; bless { @_ }, "Val::Undef" }
sub emit_javascript { my $self = $_[0]; 'null' }
}

{
package Val::Object;
sub new { shift; bless { @_ }, "Val::Object" }
sub class { $_[0]->{class} };
sub fields { $_[0]->{fields} };
sub emit_javascript { my $self = $_[0]; die('Val::Object - not used yet') }
}

{
package Lit::Array;
sub new { shift; bless { @_ }, "Lit::Array" }
sub array1 { $_[0]->{array1} };
sub emit_javascript { my $self = $_[0]; (my  $needs_interpolation = 0); for my $item ( @{$self->{array1}} ) { if (((Main::isa($item, 'Var') && ($item->sigil() eq '@')) || (Main::isa($item, 'Apply') && ($item->code() eq 'prefix:<@>')))) { ($needs_interpolation = 1) } else {  } }; if ($needs_interpolation) { (my  $s = '');for my $item ( @{$self->{array1}} ) { if (((Main::isa($item, 'Var') && ($item->sigil() eq '@')) || (Main::isa($item, 'Apply') && ($item->code() eq 'prefix:<@>')))) { ($s = $s . '(function(a_) { ' . 'for (var i_ = 0; i_ < a_.length ; i_++) { a.push(a_[i_]) }' . '})(' . $item->emit_javascript() . '); ') } else { ($s = $s . 'a.push(' . $item->emit_javascript() . '); ') } };'(function () { var a = []; ' . $s . ' return a })()' } else { '[' . Main::join([ map { $_->emit_javascript() } @{ $self->{array1} } ], ', ') . ']' } }
}

{
package Lit::Hash;
sub new { shift; bless { @_ }, "Lit::Hash" }
sub hash1 { $_[0]->{hash1} };
sub emit_javascript { my $self = $_[0]; (my  $needs_interpolation = 0); for my $item ( @{$self->{hash1}} ) { if (Main::isa($item->[0], 'Val::Buf')) {  } else { ($needs_interpolation = 1) } }; if ($needs_interpolation) { (my  $s = '');for my $field ( @{$self->{hash1}} ) { ($s = $s . 'a[' . $field->[0]->emit_javascript() . '] = ' . $field->[1]->emit_javascript() . '; ') };return('(function () { var a = []; ' . $s . ' return a })()') } else { (my  $str = '');for my $field ( @{$self->{hash1}} ) { ($str = $str . $field->[0]->emit_javascript() . ':' . $field->[1]->emit_javascript() . ',') };return('{ ' . $str . ' }') } }
}

{
package Lit::Code;
sub new { shift; bless { @_ }, "Lit::Code" }

}

{
package Lit::Object;
sub new { shift; bless { @_ }, "Lit::Object" }
sub class { $_[0]->{class} };
sub fields { $_[0]->{fields} };
sub emit_javascript { my $self = $_[0]; (my  $fields = $self->{fields}); (my  $str = ''); for my $field ( @{$fields} ) { ($str = $str . 'v_' . $field->[0]->buf() . ': ' . $field->[1]->emit_javascript() . ',') }; 'function () { ' . 'var tmp = {' . $str . '}; ' . 'tmp.__proto__ = ' . Main::to_javascript_namespace($self->{class}) . '; ' . 'return tmp ' . '}()' }
}

{
package Index;
sub new { shift; bless { @_ }, "Index" }
sub obj { $_[0]->{obj} };
sub index_exp { $_[0]->{index_exp} };
sub emit_javascript { my $self = $_[0]; $self->{obj}->emit_javascript() . '[' . $self->{index_exp}->emit_javascript() . ']' }
}

{
package Lookup;
sub new { shift; bless { @_ }, "Lookup" }
sub obj { $_[0]->{obj} };
sub index_exp { $_[0]->{index_exp} };
sub emit_javascript { my $self = $_[0]; $self->{obj}->emit_javascript() . '[' . $self->{index_exp}->emit_javascript() . ']' }
}

{
package Var;
sub new { shift; bless { @_ }, "Var" }
sub sigil { $_[0]->{sigil} };
sub twigil { $_[0]->{twigil} };
sub namespace { $_[0]->{namespace} };
sub name { $_[0]->{name} };
sub emit_javascript { my $self = $_[0]; (my  $table = { '$' => 'v_','@' => 'List_','%' => 'Hash_','&' => 'Code_', }); (my  $ns = ''); if ($self->{namespace}) { ($ns = Main::to_javascript_namespace($self->{namespace}) . '.') } else {  }; (($self->{twigil} eq '.') ? 'v_self.v_' . $self->{name} . '' : (($self->{name} eq '/') ? $table->{$self->{sigil}} . 'MATCH' : $table->{$self->{sigil}} . $ns . $self->{name})) };
sub plain_name { my $self = $_[0]; if ($self->{namespace}) { return($self->{namespace} . '.' . $self->{name}) } else {  }; return($self->{name}) }
}

{
package Bind;
sub new { shift; bless { @_ }, "Bind" }
sub parameters { $_[0]->{parameters} };
sub arguments { $_[0]->{arguments} };
sub emit_javascript { my $self = $_[0]; if (Main::isa($self->{parameters}, 'Lit::Array')) { (my  $a = $self->{parameters}->array1());(my  $str = 'do { ');(my  $i = 0);for my $var ( @{$a} ) { (my  $bind = Bind->new( 'parameters' => $var,'arguments' => Index->new( 'obj' => $self->{arguments},'index_exp' => Val::Int->new( 'int' => $i, ), ), ));($str = $str . ' ' . $bind->emit_javascript() . '; ');($i = ($i + 1)) };return($str . $self->{parameters}->emit_javascript() . ' }') } else {  }; if (Main::isa($self->{parameters}, 'Lit::Hash')) { (my  $a = $self->{parameters}->hash1());(my  $b = $self->{arguments}->hash1());(my  $str = 'do { ');(my  $i = 0);my  $arg;for my $var ( @{$a} ) { ($arg = Val::Undef->new(  ));for my $var2 ( @{$b} ) { if (($var2->[0]->buf() eq $var->[0]->buf())) { ($arg = $var2->[1]) } else {  } };(my  $bind = Bind->new( 'parameters' => $var->[1],'arguments' => $arg, ));($str = $str . ' ' . $bind->emit_javascript() . '; ');($i = ($i + 1)) };return($str . $self->{parameters}->emit_javascript() . ' }') } else {  }; if (Main::isa($self->{parameters}, 'Lit::Object')) { (my  $class = $self->{parameters}->class());(my  $a = $self->{parameters}->fields());(my  $b = $self->{arguments});(my  $str = 'do { ');(my  $i = 0);my  $arg;for my $var ( @{$a} ) { (my  $bind = Bind->new( 'parameters' => $var->[1],'arguments' => Call->new( 'invocant' => $b,'method' => $var->[0]->buf(),'arguments' => [],'hyper' => 0, ), ));($str = $str . ' ' . $bind->emit_javascript() . '; ');($i = ($i + 1)) };return($str . $self->{parameters}->emit_javascript() . ' }') } else {  }; if (Main::isa($self->{parameters}, 'Call')) { return('(' . $self->{parameters}->invocant()->emit_javascript() . '.v_' . $self->{parameters}->method() . ' = ' . $self->{arguments}->emit_javascript() . ')') } else {  }; '(' . $self->{parameters}->emit_javascript() . ' = ' . $self->{arguments}->emit_javascript() . ')' }
}

{
package Proto;
sub new { shift; bless { @_ }, "Proto" }
sub name { $_[0]->{name} };
sub emit_javascript { my $self = $_[0]; Main::to_javascript_namespace($self->{name}) }
}

{
package Call;
sub new { shift; bless { @_ }, "Call" }
sub invocant { $_[0]->{invocant} };
sub hyper { $_[0]->{hyper} };
sub method { $_[0]->{method} };
sub arguments { $_[0]->{arguments} };
sub emit_javascript { my $self = $_[0]; (my  $invocant = $self->{invocant}->emit_javascript()); if (($invocant eq 'self')) { ($invocant = 'v_self') } else {  }; if ((($self->{method} eq 'perl') || (($self->{method} eq 'isa') || (($self->{method} eq 'scalar') || (($self->{method} eq 'keys') || ($self->{method} eq 'values')))))) { if ($self->{hyper}) { return('(function (a_) { ' . 'var out = []; ' . 'if ( typeof a_ == \'undefined\' ) { return out }; ' . 'for(var i = 0; i < a_.length; i++) { ' . 'out.push( f_' . $self->{method} . '(a_[i]) ) } return out;' . ' })(' . $invocant . ')') } else {  };return('f_' . $self->{method} . '(' . $invocant . (@{$self->{arguments}} ? ', ' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ', ') : '') . ')') } else {  }; if ((($self->{method} eq 'join') || (($self->{method} eq 'shift') || (($self->{method} eq 'push') || ($self->{method} eq 'pop'))))) { return($invocant . '.' . $self->{method} . '(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; if ((($self->{method} eq 'yaml') || (($self->{method} eq 'say') || ($self->{method} eq 'chars')))) { if ($self->{hyper}) { return('(function (a_) { ' . 'var out = []; ' . 'if ( typeof a_ == \'undefined\' ) { return out }; ' . 'for(var i = 0; i < a_.length; i++) { ' . 'out.push( Main.' . $self->{method} . '(a_[i]) ) } return out;' . ' })(' . $invocant . ')') } else { if (@{$self->{arguments}}) { return('Main.' . $self->{method} . '(' . $invocant . ', ' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ', ') . ')') } else { return('Main.' . $self->{method} . '(' . $invocant . ')') } } } else {  }; (my  $meth = $self->{method}); if ($self->{hyper}) { return('(function (a_) { ' . 'var out = []; ' . 'if ( typeof a_ == \'undefined\' ) { return out }; ' . 'for(var i = 0; i < a_.length; i++) { ' . 'out.push( a_[i].f_' . $meth . '() ) } return out;' . ' })(' . $invocant . ')') } else {  }; if (($meth eq 'postcircumfix:<( )>')) { return('(' . $invocant . ')(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; return($invocant . '.f_' . $meth . '(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ', ') . ')') }
}

{
package Apply;
sub new { shift; bless { @_ }, "Apply" }
sub code { $_[0]->{code} };
sub arguments { $_[0]->{arguments} };
sub namespace { $_[0]->{namespace} };
sub emit_javascript { my $self = $_[0]; (my  $code = $self->{code}); if (Main::isa($code, 'Str')) {  } else { return('(' . $self->{code}->emit_javascript() . ')->(' . Main::join([ map { $_->emit() } @{ $self->{arguments} } ], ', ') . ')') }; if (($code eq 'self')) { return('v_self') } else {  }; if (($code eq 'false')) { return('0') } else {  }; if (($code eq 'make')) { return('(v_MATCH.v_capture = ' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; if (($code eq 'say')) { return('f_say(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; if (($code eq 'print')) { return('f_print(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; if (($code eq 'warn')) { return('f_warn(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' + ') . ')') } else {  }; if (($code eq 'defined')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' ') . ' != null)') } else {  }; if (($code eq 'substr')) { return('(' . $self->{arguments}->[0]->emit_javascript() . ' || "").substr(' . $self->{arguments}->[1]->emit_javascript() . ', ' . $self->{arguments}->[2]->emit_javascript() . ')') } else {  }; if (($code eq 'Int')) { return('parseInt(' . $self->{arguments}->[0]->emit_javascript() . ')') } else {  }; if (($code eq 'Num')) { return('parseFloat(' . $self->{arguments}->[0]->emit_javascript() . ')') } else {  }; if (($code eq 'prefix:<~>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' ') . ').f_string()') } else {  }; if (($code eq 'prefix:<!>')) { return('( f_bool(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' ') . ') ? false : true)') } else {  }; if (($code eq 'prefix:<?>')) { return('( f_bool(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' ') . ') ? true : false)') } else {  }; if (($code eq 'prefix:<$>')) { return('f_scalar(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' ') . ')') } else {  }; if (($code eq 'prefix:<@>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' ') . ')') } else {  }; if (($code eq 'prefix:<%>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' ') . ').f_hash()') } else {  }; if (($code eq 'infix:<~>')) { return('( f_string(' . $self->{arguments}->[0]->emit_javascript() . ')' . ' + f_string(' . $self->{arguments}->[1]->emit_javascript() . ') )') } else {  }; if (($code eq 'infix:<+>')) { return('f_add(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; if (($code eq 'infix:<->')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' - ') . ')') } else {  }; if (($code eq 'infix:<*>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' * ') . ')') } else {  }; if (($code eq 'infix:</>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' / ') . ')') } else {  }; if (($code eq 'infix:<>>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' > ') . ')') } else {  }; if (($code eq 'infix:<<>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' < ') . ')') } else {  }; if (($code eq 'infix:<>=>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' >= ') . ')') } else {  }; if (($code eq 'infix:<<=>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' <= ') . ')') } else {  }; if (($code eq 'infix:<&&>')) { return('( f_bool(' . $self->{arguments}->[0]->emit_javascript() . ')' . ' && f_bool(' . $self->{arguments}->[1]->emit_javascript() . ') )') } else {  }; if (($code eq 'infix:<||>')) { return('( f_bool(' . $self->{arguments}->[0]->emit_javascript() . ')' . ' || f_bool(' . $self->{arguments}->[1]->emit_javascript() . ') )') } else {  }; if (($code eq 'infix:<eq>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' == ') . ')') } else {  }; if (($code eq 'infix:<ne>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' != ') . ')') } else {  }; if (($code eq 'infix:<==>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' == ') . ')') } else {  }; if (($code eq 'infix:<!=>')) { return('(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ' != ') . ')') } else {  }; if (($code eq 'exists')) { (my  $arg = $self->{arguments}->[0]);if (Main::isa($arg, 'Lookup')) { return('(' . $arg->obj()->emit_javascript() . ').hasOwnProperty(' . $arg->index_exp()->emit_javascript() . ')') } else {  } } else {  }; if (($code eq 'ternary:<?? !!>')) { return('( f_bool(' . $self->{arguments}->[0]->emit_javascript() . ')' . ' ? ' . $self->{arguments}->[1]->emit_javascript() . ' : ' . $self->{arguments}->[2]->emit_javascript() . ')') } else {  }; ($code = 'f_' . $self->{code}); if ($self->{namespace}) { ($code = Main::to_javascript_namespace($self->{namespace}) . '.' . $code) } else { if ((($code ne 'f_index') && (($code ne 'f_die') && (($code ne 'f_pop') && (($code ne 'f_shift') && ($code ne 'f_push')))))) { ($code = 'v__NAMESPACE.' . $code) } else {  } }; $code . '(' . Main::join([ map { $_->emit_javascript() } @{ $self->{arguments} } ], ', ') . ')' }
}

{
package Return;
sub new { shift; bless { @_ }, "Return" }
sub result { $_[0]->{result} };
sub emit_javascript { my $self = $_[0]; return('throw(' . $self->{result}->emit_javascript() . ')') }
}

{
package If;
sub new { shift; bless { @_ }, "If" }
sub cond { $_[0]->{cond} };
sub body { $_[0]->{body} };
sub otherwise { $_[0]->{otherwise} };
sub emit_javascript { my $self = $_[0]; (my  $cond = $self->{cond}); if ((Main::isa($cond, 'Apply') && ($cond->code() eq 'prefix:<!>'))) { (my  $if = If->new( 'cond' => $cond->arguments()->[0],'body' => $self->{otherwise},'otherwise' => $self->{body}, ));return($if->emit_javascript()) } else {  }; if ((Main::isa($cond, 'Var') && ($cond->sigil() eq '@'))) { ($cond = Apply->new( 'code' => 'prefix:<@>','arguments' => [$cond], )) } else {  }; (my  $body = MiniPerl6::Javascript::LexicalBlock->new( 'block' => $self->{body},'needs_return' => 0, )); (my  $otherwise = MiniPerl6::Javascript::LexicalBlock->new( 'block' => $self->{otherwise},'needs_return' => 0, )); return('if ( f_bool(' . $cond->emit_javascript() . ') ) { ' . '(function () { ' . $body->emit_javascript() . ' })() } else { ' . '(function () { ' . $otherwise->emit_javascript() . ' })() }') }
}

{
package While;
sub new { shift; bless { @_ }, "While" }
sub init { $_[0]->{init} };
sub cond { $_[0]->{cond} };
sub continue { $_[0]->{continue} };
sub body { $_[0]->{body} };
sub emit_javascript { my $self = $_[0]; (my  $body = MiniPerl6::Javascript::LexicalBlock->new( 'block' => $self->{body},'needs_return' => 0, )); return('for ( ' . ($self->{init} ? $self->{init}->emit_javascript() . '; ' : '; ') . ($self->{cond} ? 'f_bool(' . $self->{cond}->emit_javascript() . '); ' : '; ') . ($self->{continue} ? $self->{continue}->emit_javascript() . ' ' : ' ') . ') { ' . '(function () { ' . $body->emit_javascript() . ' })()' . ' }') }
}

{
package For;
sub new { shift; bless { @_ }, "For" }
sub cond { $_[0]->{cond} };
sub body { $_[0]->{body} };
sub topic { $_[0]->{topic} };
sub emit_javascript { my $self = $_[0]; (my  $body = MiniPerl6::Javascript::LexicalBlock->new( 'block' => $self->{body},'needs_return' => 0, )); '(function (a_) { for (var i_ = 0; i_ < a_.length ; i_++) { ' . '(function (' . $self->{topic}->emit_javascript() . ') { ' . $body->emit_javascript() . ' })(a_[i_]) } })' . '(' . $self->{cond}->emit_javascript() . ')' }
}

{
package Decl;
sub new { shift; bless { @_ }, "Decl" }
sub decl { $_[0]->{decl} };
sub type { $_[0]->{type} };
sub var { $_[0]->{var} };
sub emit_javascript { my $self = $_[0]; $self->{var}->emit_javascript() };
sub emit_javascript_init { my $self = $_[0]; if (($self->{decl} eq 'my')) { (my  $str = '');($str = $str . 'var ' . $self->{var}->emit_javascript() . ' = ');if (($self->{var}->sigil() eq '%')) { ($str = $str . '{};' . '
') } else { if (($self->{var}->sigil() eq '@')) { ($str = $str . '[];' . '
') } else { ($str = $str . 'null;' . '
') } };return($str) } else { die('not implemented: Decl \'' . $self->{decl} . '\'') } }
}

{
package Sig;
sub new { shift; bless { @_ }, "Sig" }
sub invocant { $_[0]->{invocant} };
sub positional { $_[0]->{positional} };
sub named { $_[0]->{named} };
sub emit_javascript { my $self = $_[0]; ' print \'Signature - TODO\'; die \'Signature - TODO\'; ' }
}

{
package Method;
sub new { shift; bless { @_ }, "Method" }
sub name { $_[0]->{name} };
sub sig { $_[0]->{sig} };
sub block { $_[0]->{block} };
sub emit_javascript { my $self = $_[0]; (my  $sig = $self->{sig}); (my  $invocant = $sig->invocant()); (my  $pos = $sig->positional()); (my  $str = Main::join([ map { $_->emit_javascript() } @{$pos} ], ', ')); 'function ' . $self->{name} . '(' . $str . ') { ' . MiniPerl6::Javascript::LexicalBlock->new( 'block' => $self->{block},'needs_return' => 1,'top_level' => 1, )->emit_javascript() . ' }' }
}

{
package Sub;
sub new { shift; bless { @_ }, "Sub" }
sub name { $_[0]->{name} };
sub sig { $_[0]->{sig} };
sub block { $_[0]->{block} };
sub emit_javascript { my $self = $_[0]; (my  $sig = $self->{sig}); (my  $pos = $sig->positional()); (my  $str = Main::join([ map { $_->emit_javascript() } @{$pos} ], ', ')); 'function ' . $self->{name} . '(' . $str . ') { ' . MiniPerl6::Javascript::LexicalBlock->new( 'block' => $self->{block},'needs_return' => 1,'top_level' => 1, )->emit_javascript() . ' }' }
}

{
package Do;
sub new { shift; bless { @_ }, "Do" }
sub block { $_[0]->{block} };
sub emit_javascript { my $self = $_[0]; '(function () { ' . MiniPerl6::Javascript::LexicalBlock->new( 'block' => $self->{block},'needs_return' => 1, )->emit_javascript() . ' })()' }
}

{
package Use;
sub new { shift; bless { @_ }, "Use" }
sub mod { $_[0]->{mod} };
sub emit_javascript { my $self = $_[0]; '// use ' . $self->{mod} . Main->newline() }
}

1;

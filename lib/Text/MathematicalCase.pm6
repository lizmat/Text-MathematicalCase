
# Most of the information to create the mapper was obtained from
# https://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols

my constant %raw =
  ":ascii" => (
      "A" .. "Z",               # A .. Z
      "a" .. "z",               # a .. z
      "0" .. "9",               # 0 .. 9
  ),
  ":bold" => (
      "\x1D400" .. "\x1D419",   # 𝐀 .. 𝐙
      "\x1D41A" .. "\x1D433",   # 𝐚 .. 𝐳
      "\x1D7CE" .. "\x1D7d7",   # 𝟎 .. 𝟗
  ),
  ":italic" => (
      "\x1D434" .. "\x1D44D",   # 𝐴 .. 𝑍
      ( "\x1D44E" .. "\x1D454", "\x0210E", "\x1D456" .. "\x1D467"
      ),                        # 𝑎 .. 𝑧
      "\x1D7F6" .. "\x1D7FF",   # 𝟶 .. 𝟿
  ),
  ":bold:italic" => (
      "\x1D468" .. "\x1D481",   # 𝑨 .. 𝒁
      "\x1D482" .. "\x1D49B",   # 𝒂 .. 𝒛
      "\x1D7CE" .. "\x1D7d7",   # 𝟎 .. 𝟗
  ),
  ":script" => (
      ( "\x1D49C", "\x0212C", "\x1D49E", "\x1D49F", "\x02130", "\x02131",
        "\x1D4A2", "\x0210B", "\x02110", "\x1D4A5", "\x1D4A6", "\x02112",
        "\x02133", "\x1D4A9", "\x1D4AA", "\x02118", "\x1D4AC", "\x0211B",
        "\x1D4AE" .. "\x1D4B5"
      ),                        # 𝒜 .. 𝒵
      ( "\x1D4B6" .. "\x1D4B9", "\x0212F", "\x1D4BB", "\x0210A",
        "\x1D4BD" .. "\x1D4C3", "\x02134", "\x1D4C5" .. "\x1D4CF"
      ),                        # 𝒶 .. 𝓏
      "\x1D7F6" .. "\x1D7FF",   # 𝟶 .. 𝟿
  ),
  ":script:bold" => (
      "\x1D4D0" .. "\x1D4E9",   # 𝓐 .. 𝓩
      "\x1D4EA" .. "\x1D503",   # 𝓪 .. 𝔃
      "\x1D7CE" .. "\x1D7d7",   # 𝟎 .. 𝟗
  ),
  ":sans-serif" => (
      "\x1D5A0" .. "\x1D5B9",   # 𝖠 .. 𝖹
      "\x1D5BA" .. "\x1D5D3",   # 𝖺 .. 𝗓
      "\x1D7E2" .. "\x1D7EB",   # 𝟢 .. 𝟫
  ),
  ":sans-serif:bold" => (
      "\x1D5D4" .. "\x1D5ED",   # 𝗔 .. 𝗭
      "\x1D5EE" .. "\x1D607",   # 𝗮 .. 𝘇
      "\x1D7EC" .. "\x1D7F5",   # 𝟬 .. 𝟵
  ),
  ":sans-serif:italic" => (
      "\x1D608" .. "\x1D621",   # 𝘈 .. 𝘡
      "\x1D622" .. "\x1D63B",   # 𝘢 .. 𝘻
      "\x1D7E2" .. "\x1D7EB",   # 𝟢 .. 𝟫
  ),
  ":sans-serif:bold:italic" => (
      "\x1D63C" .. "\x1D655",   # 𝘼 .. 𝙕
      "\x1D656" .. "\x1D66F",   # 𝙖 .. 𝙯
      "\x1D7EC" .. "\x1D7F5",   # 𝟬 .. 𝟵
  ),
  ":fraktur" => (
      ( "\x1D504", "\x1D505", "\x0212D", "\x1D507" .. "\x1D50A", "\x0210C",
        "\x02111", "\x1D50D" .. "\x1D514", "\x0211C", "\x1D516" .. "\x1D51C",
        "\x02128"
      ),                        # 𝔄 .. ℨ
      "\x1D51E" .. "\x1D537",   # 𝔞 .. 𝔷
      "\x1D7F6" .. "\x1D7FF",   # 𝟶 .. 𝟿
  ),
  ":fraktur:bold" => (
      "\x1D56C" .. "\x1D585",   # 𝕬 .. 𝖅
      "\x1D586" .. "\x1D59F",   # 𝖆 .. 𝖟
      "\x1D7CE" .. "\x1D7d7",   # 𝟎 .. 𝟗
  ),
  ":monospace" => (
      "\x1D670" .. "\x1D689",   # 𝙰 .. 𝚉
      "\x1D68A" .. "\x1D6A3",   # 𝚊 .. 𝚣
      "\x1D7F6" .. "\x1D7FF",   # 𝟶 .. 𝟿
  ),
  ":double-struck" => (
      ( "\x1D538", "\x1D539", "\x02102", "\x1D53B" .. "\x1D53E", "\x0210D",
        "\x1D540" .. "\x1D544", "\x02115", "\x1D546", "\x02119", "\x0211A",
        "\x0211D", "\x1D54A" .. "\x1D550", "\x02124",
      ),                        # 𝔸 .. ℤ
      "\x1D552" .. "\x1D56B",   # 𝕒 .. 𝕫
      "\x1D7D8" .. "\x1D7E1",   # 𝟘 .. 𝟡
  ),
;

my constant @adverbs    := %raw.keys.sort.List;
my constant $multiplier := @adverbs.end;

my sub make-mapper(Int:D $uc, Int:D $lc --> Map:D) {
    my %mapper;
    
    for @adverbs -> $adverbs {
        my @info := %raw{$adverbs};

        %mapper{$adverbs} := Pair.new(
          @adverbs.map( -> $type {
              |(%raw{$type}.flat) if $type ne $adverbs;
          } ).List.join,
          (|((@info[$uc], @info[$lc], @info[2]).flat) xx $multiplier).List.join
        )
    }

    %mapper.Map
}

my sub process(%mapper, Str:D $what, Str:D \string,
  :$sans-serif, :$script, :$fraktur, :$monospace, :$double-struck, :$ascii,
  :$italic, :$bold
--> Str:D) is hidden-from-backtrace {

    my str $adverbs;
    $adverbs ~= ':sans-serif'    if $sans-serif;
    $adverbs ~= ':script'        if $script;
    $adverbs ~= ':fraktur'       if $fraktur;
    $adverbs ~= ':monospace'     if $monospace;
    $adverbs ~= ':double-struck' if $double-struck;
    $adverbs ~= ':ascii'         if $ascii;
    $adverbs ~= ':bold'          if $bold;
    $adverbs ~= ':italic'        if $italic;

    if %mapper{$adverbs} -> $mapper {
        string.trans($mapper)
    }
    else {
        Failure.new(X::Adverb.new(
          :what{$what},
          :source(try { string.VAR.name } // string.WHAT.raku),
          :nogo($adverbs.substr(1).split(":"))
        ))
    }
}

my constant %mc = make-mapper(0, 1);
my constant %lc = make-mapper(1, 1);
my constant %uc = make-mapper(0, 0);

module Text::MathematicalCase:ver<0.0.1>:auth<cpan:ELIZABETH> {
    my sub mc(Str:D $string, |c --> Str:D) is export(:all) {
        process(%mc, 'mc', $string, |c)
    }
    my sub lc(Str:D $string, |c --> Str:D) is export(:all) {
        process(%lc, 'lc', $string.lc, |c)
    }
    my sub uc(Str:D $string, |c --> Str:D) is export(:all) {
        process(%uc, 'uc', $string.uc, |c)
    }
}

sub EXPORT(*@args, *%_) {

    if @args {
        my $imports := Map.new( |(EXPORT::all::{ @args.map: '&' ~ * }:p) );
        if $imports != @args {
            die "Text::MathematicalCase doesn't know how to export: "
              ~ @args.grep( { !$imports{$_} } ).join(', ')
        }
        $imports
    }
    else {
        Map.new('&mc' => EXPORT::all::<&mc>)
    }
}

=begin pod

=head1 NAME

Text::MathematicalCase - convert to/from mathematical case

=head1 SYNOPSIS

=begin code :lang<raku>

use Text::MathematicalCase;

=end code

=head1 DESCRIPTION

Text::MathematicalCase is ...

=head1 AUTHOR

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/Text-MathematicalCase .
Comments and Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2020 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4

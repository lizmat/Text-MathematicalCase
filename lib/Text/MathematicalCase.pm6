
# Most of the information to create the mapper was obtained from
# https://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols

my constant %raw =
  ":serif" => (
      "A" .. "Z",               # A .. Z
      "a" .. "z",               # a .. z
      "0" .. "9",               # 0 .. 9
  ),
  ":serif:bold" => (
      "\x1D400" .. "\x1D419",   # 𝐀 .. 𝐙
      "\x1D41A" .. "\x1D433",   # 𝐚 .. 𝐳
      "\x1D7CE" .. "\x1D7d7",   # 𝟎 .. 𝟗
  ),
  ":serif:italic" => (
      "\x1D434" .. "\x1D44D",   # 𝐴 .. 𝑍
      ( "\x1D44E" .. "\x1D454", "\x0210E", "\x1D456" .. "\x1D467"
      ),                        # 𝑎 .. 𝑧
      "\x1D7F6" .. "\x1D7FF",   # 𝟶 .. 𝟿
  ),
  ":serif:bold:italic" => (
      "\x1D468" .. "\x1D481",   # 𝑨 .. 𝒁
      "\x1D482" .. "\x1D49B",   # 𝒂 .. 𝒛
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

my constant %mapper = do {
    my %mapper;
    my @lc-source;
    my @lc-target;
    my @uc-source;
    my @uc-target;

    for @adverbs -> $adverbs {
        my @info := %raw{$adverbs};

        @lc-source.push(@info[0]);  # upper ->
        @lc-target.push(@info[1]);  #          lower
        @uc-source.push(@info[1]);  # lower ->
        @uc-target.push(@info[0]);  #          upper

        %mapper{$adverbs} := Pair.new(
          @adverbs.map( -> $type {
              |(%raw{$type}.flat) if $type ne $adverbs;
          } ).List.join,
          (|(@info.flat) xx $multiplier).join
        )
    }

    # temporary store in the mapper, so we can create constants later
    %mapper<lc> := Pair.new(@lc-source.flat.join, @lc-target.flat.join);
    %mapper<uc> := Pair.new(@uc-source.flat.join, @uc-target.flat.join);

    %mapper.Map
}

my constant $lc-mapper = %mapper<lc>;
my constant $uc-mapper = %mapper<uc>;

module Text::MathematicalCase:ver<0.0.1>:auth<cpan:ELIZABETH> {
    my sub mc(Cool:D \string,
      :$serif, :$sans-serif, :$script, :$fraktur, :$monospace, :$double-struck,
      :$italic, :$bold
    --> Str:D) is export(:all) is hidden-from-backtrace {

        my str $adverbs;
        $adverbs ~= ':serif'         if $serif;
        $adverbs ~= ':sans-serif'    if $sans-serif;
        $adverbs ~= ':script'        if $script;
        $adverbs ~= ':fraktur'       if $fraktur;
        $adverbs ~= ':monospace'     if $monospace;
        $adverbs ~= ':double-struck' if $double-struck;
        $adverbs ~= ':bold'          if $bold;
        $adverbs ~= ':italic'        if $italic;

        if %mapper{$adverbs} -> $mapper {
            string.trans($mapper)
        }
        else {
            Failure.new(X::Adverb.new(
              :what<mc>,
              :source(try { string.VAR.name } // string.WHAT.raku),
              :nogo($adverbs.substr(1).split(":"))
            ))
        }
    }

    my sub lc(Cool:D \string --> Str:D) is export(:all) {
        string.lc.trans($lc-mapper)
    }
    my sub uc(Cool:D \string --> Str:D) is export(:all) {
        string.uc.trans($uc-mapper)
    }
    my sub adverbs(--> List:D) is export(:all) {
        @adverbs
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

  use Text::MathematicalCase;        # just mc
  say mc "Hello World" :serif:bold;  # 𝐇𝐞𝐥𝐥𝐨 𝐖𝐨𝐫𝐥𝐝

  use Text::MathematicalCase :all;   # mc lc uc adverbs
  say uc "𝐇𝐞𝐥𝐥𝐨 𝐖𝐨𝐫𝐥𝐝";              # 𝐇𝐄𝐋𝐋𝐎 𝐖𝐎𝐑𝐋𝐃

=end code

=head1 DESCRIPTION

Text::MathematicalCase is module that exports an C<mc> subroutine that
implements converting to/from "mathematical case".  Just like you can
have UPPERCASE or lowercase, you can also have 𝐦𝐚𝐭𝐡𝐞𝐦𝐚𝐭𝐢𝐜𝐚𝐥 𝐜𝐚𝐬𝐞.

"Mathematical case" is basically text expressed in the alphanumeric
symbols of the L<Mathematical Alphanumeric Symbols|https://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols>
unicode block.  In it, several styles are supported:

- serif: serif, 𝐬𝐞𝐫𝐢𝐟 𝐛𝐨𝐥𝐝, 𝑠𝑒𝑟𝑖𝑓 𝑖𝑡𝑎𝑙𝑖𝑐, 𝒔𝒆𝒓𝒊𝒇 𝒃𝒐𝒍𝒅 𝒊𝒕𝒂𝒍𝒊𝒄

- sans-serif: 𝗌𝖺𝗇𝗌-𝗌𝖾𝗋𝗂𝖿, 𝘀𝗮𝗻𝘀-𝘀𝗲𝗿𝗶𝗳 𝗯𝗼𝗹𝗱, 𝘴𝘢𝘯𝘴-𝘴𝘦𝘳𝘪𝘧 𝘪𝘵𝘢𝘭𝘪𝘤, 𝙨𝙖𝙣𝙨-𝙨𝙚𝙧𝙞𝙛 𝙗𝙤𝙡𝙙 𝙞𝙩𝙖𝙡𝙞𝙘

- script: 𝓈𝒸𝓇𝒾𝓅𝓉, 𝓼𝓬𝓻𝓲𝓹𝓽 𝓫𝓸𝓵𝓭

- fraktur: 𝔣𝔯𝔞𝔨𝔱𝔲𝔯, 𝖋𝖗𝖆𝖐𝖙𝖚𝖗 𝖇𝖔𝖑𝖉

- monospace: 𝚖𝚘𝚗𝚘𝚜𝚙𝚊𝚌𝚎

- double-struck: 𝕕𝕠𝕦𝕓𝕝𝕖-𝕤𝕥𝕣𝕦𝕔𝕜

It aptionally also exports an C<lc> and/or a C<uc> subroutine (that
perform the same function as the standard C<lc> and C<uc> subroutines,
but are aware of mathematical case characters).  And it optionally exports
an C<adverbs> subroutine that lists all the possible combinations of
adverbs that can be passed on to the C<mc> subroutine.

This distribution also installs a C<mc> script for easy access to the
mathematical case functionality.

=head1 SUBROUTINES

=head2 mc

  say mc "Hello World" :serif:bold;  # 𝐇𝐞𝐥𝐥𝐨 𝐖𝐨𝐫𝐥𝐝

Convert a string to mathematical case with the given adverbs.

=head2 lc

  use Text::MathematicalCase <lc>;
  say lc "𝐇𝐞𝐥𝐥𝐨 𝐖𝐨𝐫𝐥𝐝";  # 𝐡𝐞𝐥𝐥𝐨 𝐰𝐨𝐫𝐥𝐝

Convert a string to lowercase taking mathematical case into account as well.

=head2 uc

  use Text::MathematicalCase <uc>;
  say uc "𝐇𝐞𝐥𝐥𝐨 𝐖𝐨𝐫𝐥𝐝";  # 𝐇𝐄𝐋𝐋𝐎 𝐖𝐎𝐑𝐋𝐃

Convert a string to uppercase taking mathematical case into account as well.

=head2 adverbs

  use Text::MathematicalCase <adverbs>;
  .say for adverbs;
  # :double-struck
  # :fraktur
  # :fraktur:bold
  # :monospace
  # :sans-serif
  # :sans-serif:bold
  # :sans-serif:bold:italic
  # :sans-serif:italic
  # :script
  # :script:bold
  # :serif
  # :serif:bold
  # :serif:bold:italic
  # :serif:italic

=head1 SCRIPTS

=head2 mc

  $ mc "Hello World" --double-struck
  ℍ𝕖𝕝𝕝𝕠 𝕎𝕠𝕣𝕝𝕕

  $ mc --double-struck < file-with-text
  ℂ𝕠𝕟𝕥𝕖𝕟𝕥 𝕠𝕗 𝕗𝕚𝕝𝕖-𝕨𝕚𝕥𝕙-𝕥𝕖𝕩𝕥

The C<mc> script either takes a string, or reads from C<STDIN> and performs
the mathematical case transformation as indicated by its named arguments.

=head1 AUTHOR

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/Text-MathematicalCase .
Comments and Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2020 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4

[![Actions Status](https://github.com/lizmat/Text-MathematicalCase/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/Text-MathematicalCase/actions) [![Actions Status](https://github.com/lizmat/Text-MathematicalCase/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/Text-MathematicalCase/actions) [![Actions Status](https://github.com/lizmat/Text-MathematicalCase/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/Text-MathematicalCase/actions)

NAME
====

Text::MathematicalCase - convert to/from mathematical case

SYNOPSIS
========

```raku
use Text::MathematicalCase;        # just mc
say mc "Hello World" :serif:bold;  # 𝐇𝐞𝐥𝐥𝐨 𝐖𝐨𝐫𝐥𝐝

use Text::MathematicalCase :all;   # mc lc uc adverbs
say uc "𝐇𝐞𝐥𝐥𝐨 𝐖𝐨𝐫𝐥𝐝";              # 𝐇𝐄𝐋𝐋𝐎 𝐖𝐎𝐑𝐋𝐃
```

DESCRIPTION
===========

Text::MathematicalCase is module that exports an `mc` subroutine that implements converting to/from "mathematical case". Just like you can have UPPERCASE or lowercase, you can also have 𝐦𝐚𝐭𝐡𝐞𝐦𝐚𝐭𝐢𝐜𝐚𝐥 𝐜𝐚𝐬𝐞.

"Mathematical case" is basically text expressed in the alphanumeric symbols of the [Mathematical Alphanumeric Symbols](https://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols) unicode block. In it, several styles are supported:

  * serif: serif, 𝐬𝐞𝐫𝐢𝐟 𝐛𝐨𝐥𝐝, 𝑠𝑒𝑟𝑖𝑓 𝑖𝑡𝑎𝑙𝑖𝑐, 𝒔𝒆𝒓𝒊𝒇 𝒃𝒐𝒍𝒅 𝒊𝒕𝒂𝒍𝒊𝒄

  * sans-serif: 𝗌𝖺𝗇𝗌-𝗌𝖾𝗋𝗂𝖿, 𝘀𝗮𝗻𝘀-𝘀𝗲𝗿𝗶𝗳 𝗯𝗼𝗹𝗱, 𝘴𝘢𝘯𝘴-𝘴𝘦𝘳𝘪𝘧 𝘪𝘵𝘢𝘭𝘪𝘤, 𝙨𝙖𝙣𝙨-𝙨𝙚𝙧𝙞𝙛 𝙗𝙤𝙡𝙙 𝙞𝙩𝙖𝙡𝙞𝙘

  * script: 𝓈𝒸𝓇𝒾𝓅𝓉, 𝓼𝓬𝓻𝓲𝓹𝓽 𝓫𝓸𝓵𝓭

  * fraktur: 𝔣𝔯𝔞𝔨𝔱𝔲𝔯, 𝖋𝖗𝖆𝖐𝖙𝖚𝖗 𝖇𝖔𝖑𝖉

  * monospace: 𝚖𝚘𝚗𝚘𝚜𝚙𝚊𝚌𝚎

  * double-struck: 𝕕𝕠𝕦𝕓𝕝𝕖-𝕤𝕥𝕣𝕦𝕔𝕜

It optionally also exports an `lc` and/or a `uc` subroutine (that perform the same function as the standard `lc` and `uc` subroutines, but are aware of mathematical case characters). And it optionally exports an `adverbs` subroutine that lists all the possible combinations of adverbs that can be passed on to the `mc` subroutine.

This distribution also installs a `mc` script for easy access to the mathematical case functionality.

SUBROUTINES
===========

mc
--

```raku
say mc "Hello World" :serif:bold;  # 𝐇𝐞𝐥𝐥𝐨 𝐖𝐨𝐫𝐥𝐝
```

Convert a string to mathematical case with the given adverbs.

lc
--

```raku
use Text::MathematicalCase <lc>;
say lc "𝐇𝐞𝐥𝐥𝐨 𝐖𝐨𝐫𝐥𝐝";  # 𝐡𝐞𝐥𝐥𝐨 𝐰𝐨𝐫𝐥𝐝
```

Convert a string to lowercase taking mathematical case into account as well.

uc
--

```raku
use Text::MathematicalCase <uc>;
say uc "𝐇𝐞𝐥𝐥𝐨 𝐖𝐨𝐫𝐥𝐝";  # 𝐇𝐄𝐋𝐋𝐎 𝐖𝐎𝐑𝐋𝐃
```

Convert a string to uppercase taking mathematical case into account as well.

adverbs
-------

```raku
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
```

SCRIPTS
=======

mc
--

    $ mc "Hello World" --double-struck
    ℍ𝕖𝕝𝕝𝕠 𝕎𝕠𝕣𝕝𝕕

    $ mc --double-struck < file-with-text
    ℂ𝕠𝕟𝕥𝕖𝕟𝕥 𝕠𝕗 𝕗𝕚𝕝𝕖-𝕨𝕚𝕥𝕙-𝕥𝕖𝕩𝕥

The `mc` script either takes a string, or reads from `STDIN` and performs the mathematical case transformation as indicated by its named arguments.

SEE ALSO
========

See the [App::Unicode::Mangle](https://modules.raku.org/dist/App::Unicode::Mangle) module for a different approach to this type of functionality.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Text-MathematicalCase . Comments and Pull Requests are welcome.

If you like this module, or what I'm doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2020, 2021, 2024, 2025 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.


{=====================================================================================
 Ollama-Delphi-GUI Compiler Directives.
 -Inspired from OllamaBox by tinyBigGAMES ( https://github.com/tinyBigGAMES/OllamaBox)
======================================================================================}

{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}

{$WARN UNIT_PLATFORM OFF}
{$WARN UNIT_DEPRECATED OFF}

{$WARN UNSUPPORTED_CONSTRUCT OFF}

{$Z4}
{$A8}
{$INLINE AUTO}

{$IF (CompilerVersion < 36.0)}
  {$MESSAGE Error 'Must use Delphi 12 or higher'}
{$IFEND}
